// dsh-agency-agents-zh plugin entry.
//
// The agents themselves are the upstream agency-agents-zh files verbatim
// (see THIRD_PARTY_NOTICES.md); this entry and lib/agents.js are the only dsh
// adaptation layer — registering them with the dsh skills registry so the
// `skill` tool can load them at runtime.

import { registerAgencyAgents } from './lib/agents.js'

export const name = 'dsh-agency-agents-zh'

export function apply(ctx) {
  registerAgencyAgents(ctx)
}
