// Bundled-agent provider for dsh-agency-agents-zh.
//
// The agent definitions are the upstream agency-agents-zh files verbatim
// (see THIRD_PARTY_NOTICES.md); this file is the only dsh adaptation layer —
// registering them with the dsh skills registry so the `skill` tool can load
// them at runtime. The provider pattern (list candidates from a package
// relative agents dir, load the markdown body on demand) is adapted from
// dsh-mattpocock-skills (lib/skills.js), which is the community-standard way
// to ship a directory of skill files in a dsh bundle; the scan here walks
// every top-level agent directory recursively, mirroring the upstream
// `scripts/check-counts.mjs` definition of an agent (a .md with a `name:`
// frontmatter field, excluding docs/scripts/examples/integrations).
//
// Each agent file is a flat `<category>/<agent-id>.md`; the skill name is the
// file basename (kebab-case, matching the ids in the upstream AGENT-LIST.md),
// and the description is read from the frontmatter.

import { readdirSync, readFileSync } from 'node:fs'
import { join } from 'node:path'
import { fileURLToPath } from 'node:url'
import { extractDescription } from './frontmatter.js'

/** Provider identity attached to every candidate this plugin contributes. */
export const PROVIDER = 'dsh-agency-agents-zh'

/**
 * dsh's documented rank for packaged skill providers (BUNDLED_SKILL_RANK in
 * @deepseek-ai/dsh-skill). Kept as a literal so this package carries no
 * runtime dependencies.
 */
const BUNDLED_SKILL_RANK = 600

/** Upstream agents carry no invocation restrictions; both surfaces are open. */
const INVOCATION = { modelInvocable: true, userInvocable: true }

/** Origin bucket for packaged skills (dsh SkillSource vocabulary). */
const SKILL_SOURCE = 'bundled'

/** Package-relative repo root, mirroring the upstream repository layout. */
const ROOT = fileURLToPath(new URL('..', import.meta.url))

/** Directories that are not agent content (mirrors upstream check-counts.mjs). */
const SKIP_DIRS = new Set(['node_modules', 'scripts', 'integrations', 'examples', '.git', '.github'])

/**
 * Enumerate the bundled agents as registry candidates.
 *
 * Walks every top-level directory (skipping docs/scripts/integrations/
 * examples, which are not agent content) and collects .md files whose
 * frontmatter carries a `name:` field — the same definition the upstream
 * `scripts/check-counts.mjs` uses. The skill name is the file basename
 * without the extension.
 *
 * @returns candidates ready for `ctx.skills.registerProvider`
 */
export function listBundledAgents() {
  const agents = []
  let entries
  try {
    entries = readdirSync(ROOT, { withFileTypes: true })
  } catch (error) {
    console.warn(`[${PROVIDER}] cannot scan package root ${ROOT}: ${error.message}`)
    return agents
  }
  for (const entry of entries) {
    if (!entry.isDirectory() || entry.name.startsWith('.') || SKIP_DIRS.has(entry.name)) continue
    collectFrom(join(ROOT, entry.name), agents)
  }
  return agents
}

function collectFrom(dir, agents) {
  let entries
  try {
    entries = readdirSync(dir, { withFileTypes: true })
  } catch (error) {
    console.warn(`[${PROVIDER}] skipping unreadable directory ${dir}: ${error.message}`)
    return
  }
  for (const entry of entries) {
    const file = join(dir, entry.name)
    if (entry.isDirectory()) {
      collectFrom(file, agents)
    } else if (entry.name.endsWith('.md')) {
      let body
      try {
        body = readFileSync(file, 'utf8')
      } catch (error) {
        console.warn(`[${PROVIDER}] skipping unreadable agent file ${file}: ${error.message}`)
        continue
      }
      // An agent is a .md with a `name:` frontmatter field (upstream rule).
      const fm = /^---\n([\s\S]*?)\n---/u.exec(body)
      if (!fm || !/^\s*name\s*:/mu.test(fm[1] ?? '')) continue
      const name = entry.name.replace(/\.md$/, '')
      agents.push({
        name,
        description: extractDescription(body) || `${PROVIDER} agent ${name}`,
        invocation: INVOCATION,
        provider: PROVIDER,
        source: SKILL_SOURCE,
        rank: BUNDLED_SKILL_RANK,
        resourceBase: { kind: 'directory', path: dir },
        locator: file,
      })
    }
  }
}

/**
 * Register the bundled agents with the dsh skills registry.
 *
 * Uses `ctx.inject(['skills'], ...)` so the registration happens when the
 * skills service is available and the plugin still loads in compositions
 * where it is not. Content is loaded lazily via the provider `get()` — only
 * catalog metadata is read at boot.
 *
 * @param ctx - plugin context from `apply()`
 */
export function registerAgencyAgents(ctx) {
  ctx.inject(['skills'], (skillCtx) => {
    const candidates = listBundledAgents()
    if (candidates.length === 0) {
      console.warn(`[${PROVIDER}] no bundled agents found — catalog will be empty`)
      return
    }
    const provider = {
      name: PROVIDER,
      list: () => Promise.resolve(candidates),
      async get(candidate) {
        try {
          // Definition = candidate metadata + the verbatim agent body.
          return { ...candidate, content: readFileSync(candidate.locator, 'utf8') }
        } catch {
          return undefined
        }
      },
    }
    skillCtx.skills.registerProvider(() => provider)
  })
}
