import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import type { Database } from "@/lib/database.types";

// How long we wait for Supabase before giving up. Without a timeout a stalled
// network request would leave the page (or a quiz answer) hanging forever.
const REQUEST_TIMEOUT_MS = 8000;

export type Supabase = SupabaseClient<Database>;

// One client factory for server components and the browser. There is no sign-in
// in this slice, so no cookies or sessions are involved: requests use the
// public anon key, and the database (RLS + column grants) decides what is
// visible. The anon key is safe to expose; the service-role key must never
// appear in this app.
export function createSupabase(): Supabase {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !anonKey) {
    // A misconfigured deploy should fail loudly with a useful message, not
    // with a confusing "fetch failed" later.
    throw new Error(
      "Supabase is not configured: set NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY.",
    );
  }
  return createClient<Database>(url, anonKey, {
    auth: { persistSession: false, autoRefreshToken: false },
    // supabase-js retries failed reads on its own (4 attempts, 1s/2s/4s pauses),
    // and getLesson/getLessons retry too. Stacked with an 8s timeout that made a
    // stalled database take ~78s to fail (measured). One retry layer only: ours.
    db: { retry: false },
    global: {
      fetch: (input, init) => {
        // supabase-js passes its own signal, so the timeout must be combined
        // with it (either one aborts the request), not used only when absent.
        const timeout = AbortSignal.timeout(REQUEST_TIMEOUT_MS);
        const signal =
          init?.signal && typeof AbortSignal.any === "function"
            ? AbortSignal.any([init.signal, timeout])
            : (init?.signal ?? timeout);
        return fetch(input, { ...init, signal });
      },
    },
  });
}
