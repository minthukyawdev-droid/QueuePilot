import type { Metadata } from "next";

import "./globals.css";

export const metadata: Metadata = {
  title: "QueuePilot",
  description: "Don't just wait. Get ready.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
