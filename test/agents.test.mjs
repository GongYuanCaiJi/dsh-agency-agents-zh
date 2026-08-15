import { test } from 'node:test'
import assert from 'node:assert/strict'
import { readFileSync, existsSync, readdirSync } from 'node:fs'
import { join, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'
import { Context } from '@deepseek-ai/cordis'
import { SkillRegistry, isSkillName } from '@deepseek-ai/dsh-skill'
import { listBundledAgents, registerAgencyAgents, PROVIDER } from '../lib/agents.js'
import { apply } from '../index.js'

const ROOT = fileURLToPath(new URL('..', import.meta.url))

// 獨立真相 1：上游權威清單 AGENT-LIST.md（pin agency-agents-zh@1.2.7，
// gitHead 465aa4a5a40a376e9ef6c2e151889997992215b9）宣告的 agent id。
// 每個 id 是 agent 檔案名去掉 .md；skill name 直接採用它（kebab-case 檔名）。
const EXPECTED_AGENTS = readFileSync(join(ROOT, 'AGENT-LIST.md'), 'utf8')
  .split('\n')
  .map((line) => /^\| `([a-z0-9][a-z0-9-]*)`/.exec(line)?.[1])
  .filter(Boolean)
  .sort()

// 獨立真相 2：直接從檔案系統讀 frontmatter（不經 provider 的解析路徑），
// 驗證 provider 接對了 description 這條線。
function readFrontmatterDescription(file) {
  const body = readFileSync(file, 'utf8')
  const fm = /^---\n([\s\S]*?)\n---/u.exec(body)
  const d = fm && /^description:\s*(.+)$/mu.exec(fm[1] ?? '')
  return d?.[1]?.replace(/^['"]|['"]$/g, '').trim()
}

// 獨立真相 3：不走 provider，直接 walk 檔案系統找「有 name frontmatter 的 .md」，
// 驗證 AGENT-LIST 的每個 id 都有真實檔案對應（provider 之外的第二條掃描路徑）。
// 掃描定義與上游 scripts/check-counts.mjs 一致：所有頂層目錄，排除
// node_modules/scripts/integrations/examples/.git（strategy 沒有 name frontmatter，
// 自然不會被算成 agent）。
const SKIP_DIRS = new Set(['node_modules', 'scripts', 'integrations', 'examples', '.git', '.github'])

function walkAgentsOnDisk() {
  const ids = new Set()
  for (const entry of readdirSync(ROOT, { withFileTypes: true })) {
    if (!entry.isDirectory() || entry.name.startsWith('.') || SKIP_DIRS.has(entry.name)) continue
    const walk = (d) => {
      for (const e of readdirSync(d, { withFileTypes: true })) {
        const f = join(d, e.name)
        if (e.isDirectory()) walk(f)
        else if (e.name.endsWith('.md')) {
          const body = readFileSync(f, 'utf8')
          const fm = /^---\n([\s\S]*?)\n---/u.exec(body)
          if (fm && /^\s*name\s*:/mu.test(fm[1] ?? '')) ids.add(e.name.replace(/\.md$/, ''))
        }
      }
    }
    walk(join(ROOT, entry.name))
  }
  return ids
}

function makeContext() {
  const ctx = new Context()
  const registry = new SkillRegistry(ctx)
  return { ctx, registry }
}

test('AGENT-LIST 的每個 id 在檔案系統都有對應 agent 檔（獨立 walk）', () => {
  const onDisk = walkAgentsOnDisk()
  assert.equal(onDisk.size, EXPECTED_AGENTS.length, 'AGENT-LIST 數目與磁碟 agent 數必須一致')
  const missing = EXPECTED_AGENTS.filter((id) => !onDisk.has(id))
  assert.deepEqual(missing, [], 'AGENT-LIST 宣告但磁碟上找不到的 id')
  const extra = [...onDisk].filter((id) => !EXPECTED_AGENTS.includes(id)).sort()
  assert.deepEqual(extra, [], '磁碟上有但 AGENT-LIST 未宣告的 id')
})

test('listBundledAgents 回傳 exactly 上游 AGENT-LIST 宣告的 agent 集合', () => {
  const candidates = listBundledAgents()
  const names = candidates.map((c) => c.name).sort()
  assert.deepEqual(names, EXPECTED_AGENTS)
})

test('每個 candidate 滿足 dsh skill registry 契約', () => {
  const candidates = listBundledAgents()
  assert.ok(candidates.length > 0)
  for (const c of candidates) {
    assert.ok(isSkillName(c.name), `invalid skill name ${c.name}`)
    assert.equal(typeof c.description, 'string')
    assert.ok(c.description.length > 0, `${c.name} must have a description`)
    assert.deepEqual(c.invocation, { modelInvocable: true, userInvocable: true })
    assert.equal(c.provider, PROVIDER)
    assert.equal(c.source, 'bundled')
    assert.equal(c.rank, 600)
    assert.equal(c.resourceBase?.kind, 'directory')
    assert.ok(typeof c.resourceBase?.path === 'string')
    // locator 指向包內實際存在的 agent 檔，且就在 resourceBase 目錄下
    assert.equal(c.locator, join(c.resourceBase.path, `${c.name}.md`))
    assert.ok(existsSync(c.locator), `${c.locator} must exist`)
    assert.ok(readFileSync(c.locator, 'utf8').length > 0)
  }
})

test('candidate.description 與檔案 frontmatter 一致（接對線）', () => {
  const candidates = listBundledAgents()
  for (const c of candidates) {
    const expected = readFrontmatterDescription(c.locator)
    assert.ok(expected, `${c.name} frontmatter description must exist`)
    assert.equal(c.description, expected, `${c.name} description mismatch`)
  }
})

test('registerAgencyAgents 把 provider 接進真 registry', async () => {
  const { ctx, registry } = makeContext()
  registerAgencyAgents(ctx)
  const summaries = await registry.list({ cwd: ROOT })
  const names = summaries.map((s) => s.name).sort()
  assert.deepEqual(names, EXPECTED_AGENTS)
  for (const s of summaries) {
    assert.ok(s.description.length > 0, `${s.name} catalog description missing`)
    assert.equal(s.invocation.modelInvocable, true)
  }
})

test('registry.get 載入的內容是磁碟上的逐字 agent 檔', async () => {
  const { ctx, registry } = makeContext()
  registerAgencyAgents(ctx)
  // 抽一個原創（中文）agent 與一個翻譯 agent 驗證逐字保留
  for (const name of ['marketing-xiaohongshu-operator', 'engineering-software-architect']) {
    const agent = await registry.get(name, { cwd: ROOT })
    assert.ok(agent, `${name} must resolve`)
    const onDisk = readFileSync(join(agent.resourceBase.path, `${name}.md`), 'utf8')
    assert.equal(agent.content, onDisk, `${name} content must be verbatim`)
    assert.equal(agent.name, name)
    assert.equal(agent.provider, PROVIDER)
    assert.equal(agent.source, 'bundled')
    assert.ok(agent.description.length > 0)
  }
})

test('index apply() 註冊完整 catalog', async () => {
  const { ctx, registry } = makeContext()
  apply(ctx)
  const summaries = await registry.list({ cwd: ROOT })
  assert.deepEqual(summaries.map((s) => s.name).sort(), EXPECTED_AGENTS)
})
