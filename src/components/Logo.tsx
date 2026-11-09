// SuperDriver logo mark: a steering wheel (rim, hub, three spokes) on a blue
// rounded square. Original artwork, drawn as plain SVG so it scales cleanly and
// needs no image file. Decorative: the "SuperDriver" text beside it names it.
export function Logo({ size = 36 }: { size?: number }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 40 40"
      aria-hidden="true"
      focusable="false"
    >
      <rect width="40" height="40" rx="10" fill="#4338ca" />
      <g fill="none" stroke="#ffffff" strokeWidth="3" strokeLinecap="round">
        <circle cx="20" cy="20" r="12.5" />
        <path d="M7.5 20h8M24.5 20h8M20 24.5V32.5" />
      </g>
      <circle cx="20" cy="20" r="4" fill="#ffffff" />
    </svg>
  );
}
