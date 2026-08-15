// Agent frontmatter parsing for bundled-agent descriptions.
//
// The agent files carry YAML frontmatter (`name`, `description`, `emoji`,
// `color`); this provider reads `description:` for the catalog summary, with
// a first-non-heading-line fallback — the same shape dsh-mattpocock-skills
// uses for SKILL.md (adapted from dsh-lens@0.2.5). Kept as its own module so
// the scanner (lib/agents.js) is a pure registry adapter.

/** Parse `description:` from the YAML frontmatter, falling back to prose. */
export function extractDescription(markdown) {
  const match = /^---\n([\s\S]*?)\n---/u.exec(markdown)
  if (!match) return firstNonHeadingLine(markdown)
  const described = /^description:\s*(.+)$/mu.exec(match[1] ?? '')
  return described?.[1]?.replace(/^['"]|['"]$/g, '').trim() || firstNonHeadingLine(markdown)
}

/** First non-empty, non-heading line of the markdown body (dsh-lens fallback). */
export function firstNonHeadingLine(markdown) {
  const body = markdown.replace(/^---[\s\S]*?---\n?/u, '')
  const line = body.split('\n').map((item) => item.trim()).find((item) => item && !item.startsWith('#'))
  return line
}
