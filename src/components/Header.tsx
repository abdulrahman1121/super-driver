import Link from "next/link";
import { Logo } from "@/components/Logo";

export function Header() {
  return (
    <header className="border-b border-slate-200 bg-white">
      <div className="mx-auto flex max-w-5xl items-center justify-between px-4 py-3">
        <Link
          href="/"
          className="flex items-center gap-2.5 rounded-lg focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-indigo-700"
        >
          <Logo />
          <span className="text-xl font-bold tracking-tight text-slate-900">
            SuperDriver
          </span>
        </Link>
        <Link
          href="/#lessons"
          className="rounded-lg px-3 py-2 text-sm font-semibold text-indigo-800 hover:bg-indigo-50 focus-visible:outline-2 focus-visible:outline-indigo-700"
        >
          Lessons
        </Link>
      </div>
    </header>
  );
}
