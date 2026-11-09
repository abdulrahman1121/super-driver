import type { Metadata } from "next";
import { Geist } from "next/font/google";
import { Header } from "@/components/Header";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "SuperDriver",
  description:
    "Learn Washington State driving rules with short lessons and quick checks.",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en" className={`${geistSans.variable} h-full antialiased`}>
      <body className="flex min-h-full flex-col">
        <Header />
        <div className="flex-1">{children}</div>
        <footer className="border-t border-slate-200 bg-white">
          <p className="mx-auto max-w-5xl px-4 py-4 text-sm text-slate-600">
            SuperDriver is a study aid based on the Washington State Driver
            Guide. For the official rules, always check the guide at dol.wa.gov.
          </p>
        </footer>
      </body>
    </html>
  );
}
