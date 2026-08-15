<div align="center">

# dsh-agency-agents-zh

**267 个即插即用的 AI 专家角色——从前端开发到区块链安全，从小红书运营到抖音策略，原样移植为 DeepSeek Harness 插件。**

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![dsh](https://img.shields.io/badge/dsh-0.1.0--rc.6-8A2BE2)](https://github.com/deepseek-ai/deepseek-harness)
[![upstream](https://img.shields.io/badge/upstream-agency--agents--zh%401.2.7-181717)](https://github.com/jnMetaCode/agency-agents-zh)

[English](#english) · [中文](#中文)

</div>

## 中文

本插件把 [jnMetaCode/agency-agents-zh](https://github.com/jnMetaCode/agency-agents-zh)（19k+ star 的中文 AI 专家团队角色库）**逐字移植**为 DeepSeek Harness 插件：上游全部 267 个智能体角色定义原封不动地搬入，通过 dsh 的 `skill` 工具加载。上游文字是中文，按「100% 原样复制」规则不翻译——角色正文保持上游原文。

### 功能

- **267 个角色，零改动**：覆盖工程、设计、营销、产品、游戏、安全、GIS、金融等 20 个部门，含 52 个中国市场原创智能体（小红书/抖音/微信/飞书/钉钉等平台运营，以及跨境电商、政务 ToG、医疗合规、机械设计等垂直领域）。
- **逐字可自验**：所有角色文件与上游 v1.2.7 逐字节一致，杂凑钉在 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)，附可直接复制的验证命令。
- **按需加载**：catalog 只暴露名字与描述，角色正文在模型真正调用时才读取，不占启动时间。

### 效果

装上之后，模型在会话中能看到角色 catalog，并在任务匹配某个角色时用 `skill` 工具加载完整人设——`marketing-xiaohongshu-operator`（小红书运营专家）、`engineering-software-architect`（软件架构师）、`finance-fraud-detector`（金融欺诈检测专家）等，全部按上游原样可用。也支持用户显式调用：在输入里以 `/角色-id` 开头即可加载。

### 安装

```sh
dsh plugin --profile <name> add github:GongYuanCaiJi/dsh-agency-agents-zh
```

本插件无 build script、零运行时依赖，git 安装不会触发 pnpm 的 build-script 白名单，无需配置 `allowBuilds`。

本地路径安装（同样零依赖，无需先 `npm install`）：

```sh
git clone https://github.com/GongYuanCaiJi/dsh-agency-agents-zh.git
dsh plugin --profile <name> add ./dsh-agency-agents-zh
```

### 用法

装好即用，无需额外配置：模型在会话中看到角色 catalog，任务匹配时自动加载角色正文；也可以显式调用——在输入里以 `/角色-id` 开头，例如 `/marketing-xiaohongshu-operator`。

### 移植出身

本包是 [jnMetaCode/agency-agents-zh](https://github.com/jnMetaCode/agency-agents-zh) 的**移植**（port），上游为 MIT 许可（Copyright (c) 2025 Michael Sitarzewski 原版 · Copyright (c) 2026 jnMetaCode 中译）——LICENSE 见 [LICENSE](LICENSE)，逐字文件的杂凑与验证命令见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

**如果你喜欢这些角色，请也给[上游仓库](https://github.com/jnMetaCode/agency-agents-zh)点个 star。**

### License

MIT。上游 [jnMetaCode/agency-agents-zh](https://github.com/jnMetaCode/agency-agents-zh) `Copyright (c) 2025 Michael Sitarzewski` + `Copyright (c) 2026 jnMetaCode`，本移植 `Copyright (c) 2026 GongYuanCaiJi`。见 [LICENSE](LICENSE)。

---

## English

This plugin is a **verbatim port** of [jnMetaCode/agency-agents-zh](https://github.com/jnMetaCode/agency-agents-zh)
(a 19k+ star Chinese AI-expert role library) to DeepSeek Harness: all 267 agent
role definitions from upstream are copied unchanged and loaded through dsh's
`skill` tool. Per the "100% verbatim copy" rule, the Chinese role bodies are
**not translated**.

### Features

- **267 roles, zero changes**: engineering, design, marketing, product, game,
  security, GIS, finance and more across 20 departments, including 52
  China-market original agents (Xiaohongshu/Douyin/WeChat/Feishu/DingTalk
  operations, cross-border e-commerce, government ToG, healthcare compliance,
  mechanical design, …).
- **Self-verifiable verbatim claim**: all role files are byte-identical to
  upstream v1.2.7; hashes are pinned in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)
  with copy-paste verification commands.
- **Lazy loading**: the catalog exposes names and descriptions only; role
  bodies are read when the model actually loads a skill — no boot-time cost.

### What you get

Once installed, the model sees a role catalog in the session and loads the
full persona via the `skill` tool when a task matches —
`marketing-xiaohongshu-operator` (Xiaohongshu operations expert),
`engineering-software-architect` (software architect), `finance-fraud-detector`
(financial fraud detection expert) and more, exactly as upstream. Users can
also invoke a role explicitly by starting a message with `/role-id`.

### Install

```sh
dsh plugin --profile <name> add github:GongYuanCaiJi/dsh-agency-agents-zh
```

This package has no build scripts and zero runtime dependencies, so a git
install does not trip pnpm's build-script allowlist — no `allowBuilds`
configuration needed.

Local-path install (also zero dependencies — no `npm install` needed first):

```sh
git clone https://github.com/GongYuanCaiJi/dsh-agency-agents-zh.git
dsh plugin --profile <name> add ./dsh-agency-agents-zh
```

### Usage

Ready to use after install — no configuration needed: the model sees the role
catalog in the session and loads a role's body when a task matches. You can
also invoke one explicitly by starting a message with `/role-id`, e.g.
`/marketing-xiaohongshu-operator`.

### Attribution

This package is a **port** of
[jnMetaCode/agency-agents-zh](https://github.com/jnMetaCode/agency-agents-zh).
Upstream is MIT licensed (Copyright (c) 2025 Michael Sitarzewski original ·
Copyright (c) 2026 jnMetaCode Chinese translation) — see [LICENSE](LICENSE);
per-file hashes and verification commands live in
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

**If you like these roles, please also star the [upstream repository](https://github.com/jnMetaCode/agency-agents-zh).**

### License

MIT. Upstream
[jnMetaCode/agency-agents-zh](https://github.com/jnMetaCode/agency-agents-zh)
`Copyright (c) 2025 Michael Sitarzewski` + `Copyright (c) 2026 jnMetaCode`;
this port `Copyright (c) 2026 GongYuanCaiJi`. See [LICENSE](LICENSE).
