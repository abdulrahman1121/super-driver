// Renders a section's plain-text body. Format (see the sections table): a blank
// line starts a new block; inside a block, lines starting with "- " are bullets
// and any lines before the first bullet are an intro paragraph. Text is only
// ever rendered as text (never as HTML), so content cannot inject markup.
export function SectionBody({ body }: { body: string }) {
  const blocks = body.split(/\n{2,}/).map((block) => block.split("\n"));

  return (
    <div className="space-y-4 text-lg leading-relaxed text-slate-800">
      {blocks.map((lines, i) => {
        const firstBullet = lines.findIndex((l) => l.startsWith("- "));
        const intro = firstBullet === -1 ? lines : lines.slice(0, firstBullet);
        const bullets =
          firstBullet === -1
            ? []
            : lines.slice(firstBullet).map((l) => l.replace(/^- /, ""));
        return (
          <div key={i} className="space-y-2">
            {intro.length > 0 && <p>{intro.join(" ")}</p>}
            {bullets.length > 0 && (
              <ul className="list-disc space-y-1.5 pl-6 marker:text-indigo-600">
                {bullets.map((b, j) => (
                  <li key={j}>{b}</li>
                ))}
              </ul>
            )}
          </div>
        );
      })}
    </div>
  );
}
