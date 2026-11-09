"use client";

// Shown when a page fails to load (for example Supabase is unreachable after
// our retry). The visitor gets plain words and a retry, never a stack trace.
// retry() refetches the server data and re-renders; reset() would only clear the
// error on the client and show the same failure again (found by testing).
export default function Error({
  retry,
}: {
  error: unknown;
  retry: () => void;
}) {
  return (
    <main className="mx-auto max-w-xl px-4 py-16 text-center">
      <h1 className="text-2xl font-bold text-slate-900">
        Something went wrong
      </h1>
      <p className="mt-3 text-slate-700">
        We couldn&apos;t load this page. Check your connection and try again.
      </p>
      <button
        type="button"
        onClick={() => retry()}
        className="mt-6 rounded-lg bg-indigo-600 px-6 py-3 font-semibold text-white hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700"
      >
        Try again
      </button>
    </main>
  );
}
