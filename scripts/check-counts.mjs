#!/usr/bin/env node
// 校验文档里的角色总数与实际角色文件一致，防止 AGENT-LIST / README 计数悄悄滞后。
// 角色 = 带 name frontmatter 的 .md（排除 README/攻略/模板等文档）。
// 用法: node scripts/check-counts.mjs   （不一致则以非零码退出，可用于 CI / 发布前自检）
import { readdirSync, readFileSync, existsSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const SKIP = new Set(["node_modules", "scripts", "integrations", "examples", ".git"]);

function countAgents(dir) {
  let n = 0;
  const walk = (d) => {
    for (const e of readdirSync(d, { withFileTypes: true })) {
      if (e.name.startsWith(".") || SKIP.has(e.name)) continue;
      const f = join(d, e.name);
      if (e.isDirectory()) walk(f);
      else if (e.name.endsWith(".md")) {
        const m = readFileSync(f, "utf8").match(/^---\n([\s\S]*?)\n---/);
        if (m && /^\s*name\s*:/m.test(m[1])) n++;
      }
    }
  };
  for (const c of readdirSync(dir, { withFileTypes: true })) {
    if (c.isDirectory() && !c.name.startsWith(".") && !SKIP.has(c.name)) walk(join(dir, c.name));
  }
  return n;
}

const actual = countAgents(root);
const problems = [];
const checkFile = (file, regex, label) => {
  const p = join(root, file);
  if (!existsSync(p)) return;
  const m = readFileSync(p, "utf8").match(regex);
  if (m && Number(m[1]) !== actual) problems.push(`${file} ${label} 写 ${m[1]}，实际 ${actual}`);
};

checkFile("AGENT-LIST.md", /记录项目中所有\s*(\d+)\s*个/, "头部总数");
checkFile("README.md", /(\d+)\s*个即插即用/, "项目规模");
checkFile("package.json", /(\d+)\s*个即插即用/, "包描述");

if (problems.length) {
  console.error(`❌ 角色计数不一致（实际 ${actual} 个）：`);
  problems.forEach((p) => console.error("   - " + p));
  console.error("   请更新对应文档（AGENT-LIST.md / README.md）后再发布。");
  process.exit(1);
}
console.log(`✅ 角色计数一致：${actual} 个`);
