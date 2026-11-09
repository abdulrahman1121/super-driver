import Link from "next/link";

export default function NotFound() {
  return (
    <main className="mx-auto max-w-xl px-4 py-16 text-center">
      <h1 className="text-2xl font-bold text-slate-900">
        We can&apos;t find that page
      </h1>
      <p className="mt-3 text-slate-700">
        The lesson may have moved, or the link may be wrong.
      </p>
      <Link
        href="/#lessons"
        className="mt-6 inline-block rounded-lg bg-indigo-600 px-6 py-3 font-semibold text-white hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-700"
      >
        See all lessons
      </Link>
    </main>
  );
}
