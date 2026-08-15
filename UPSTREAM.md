# 上游版本追踪

记录本项目对应的上游 [agency-agents](https://github.com/msitarzewski/agency-agents) 版本，方便同步更新。

## 当前基线

- **上游仓库**: https://github.com/msitarzewski/agency-agents
- **对应 commit**: 已追平上游 2026-06-16 状态（`3f78a30`）
- **2026-06-18 同步内容**:
  - 新增 `gis/`(13) 与 `security/`(10) 两个部门（对应上游 `a077c9a` / `#572`）
  - 补译上游 `783f6a7` 之后零散新增的 29 个 agent（engineering 6 / marketing 6 / specialized 14 / design 1 / sales 1 / project-management 1）
  - 上游把 `specialized/blockchain-security-auditor`、`specialized/compliance-auditor` 搬到了 `security/`，本地已删旧的 specialized 副本、保留 security 版（去重）
  - 上游把 `specialized/prompt-engineer` 改名搬成 `engineering/engineering-prompt-engineer`；本地的 `specialized/prompt-engineer`（中文名「提示词工程师」）是**原创**，与上游新角色并存，未删
- **已译自上游总数**: 215（不含 `strategy/` 运营文档）；加 51 个中国原创，本地共 **266** 个智能体
- **覆盖状态**: 已与上游达成 agent 文件级 parity（上游所有 agent 均有中文对应）

## 翻译覆盖

截至 2026-06-18，本仓库已覆盖上游全部 agent（文件级 parity，上游每个 agent 都有中文对应）：

| 来源 | 数量 |
|------|------|
| 已译自上游 | 215 |
| 中国市场原创 | 51 |
| **合计** | **266** |

> 按部门明细见 [AGENT-LIST.md](./AGENT-LIST.md) 的「按部门统计」与「按来源统计」（权威来源，由实际文件生成；`scripts/check-counts.mjs` 会校验计数一致）。`strategy/` 目录为运营文档，不计入智能体数。

> `strategy/` 目录是运营文档（playbooks / runbooks / 协作模板），上下游内容一致，不计入智能体覆盖率。

### 上下游路径差异（已映射）

下列 4 个上游 agent 在本地以不同文件名存在，已映射不算缺失：

| 上游路径 | 本地路径 |
|---------|---------|
| `marketing/marketing-bilibili-content-strategist.md` | `marketing/marketing-bilibili-strategist.md` |
| `specialized/customer-service.md` | `support/support-support-responder.md`（拆分） |
| `specialized/sales-outreach.md` | `sales/sales-outbound-strategist.md` |
| `specialized/supply-chain-strategist.md` | `supply-chain/supply-chain-strategist.md` |

## 中国市场原创智能体

本项目除翻译外，新增 49+ 个针对中国市场原创的智能体（小红书/抖音/微信/B站/快手/微博/飞书/钉钉/百度SEO/政务ToG/医疗合规/高考志愿/留学规划/Qt 上位机/养殖档案核对等）。

完整列表见 [AGENT-LIST.md](./AGENT-LIST.md) 中标记为 `原创` 的条目。

## 本地额外目录

下列目录在上游不存在，是本项目针对中国市场新建的部门：

- `hr/` — 招聘专家、绩效管理专家（2 个）
- `legal/` — 合同审查专家、制度文件撰写专家（2 个）
- `supply-chain/` — 库存预测/供应商评估/物流路线优化（3 个）

## 同步说明

- 跟踪上游 `main` 分支
- 新增的上游智能体会逐步翻译
- 上游如果有大的结构调整（目录重命名等），一周内同步
- 上游版本号每次同步后由维护者更新本文件
