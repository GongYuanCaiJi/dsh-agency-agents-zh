// Type declarations for the dsh-agency-agents-zh plugin entry.
//
// The package is plain JavaScript; this mirrors the exports in index.js
// (name + apply) so TypeScript consumers get typed access to the plugin
// surface. The plugin is loaded by the dsh harness through cordis.

import type { Context } from '@deepseek-ai/cordis'

export const name: 'dsh-agency-agents-zh'

export function apply(ctx: Context): void
