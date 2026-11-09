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
    global: {
      fetch: (input, init) =>
        fetch(input, {
          ...init,
          signal: init?.signal ?? AbortSignal.timeout(REQUEST_TIMEOUT_MS),
        }),
    },
  });
}
