# Trae 集成

将本仓库的 215 个智能体转换为 Trae 项目级 rule 文件，安装到 `<your-project>/.trae/rules/`。Trae rule 与 Cursor `.mdc` 同源，差异在于扩展名 `.md` 与 IDE 内置的 rule 管理面板。

## 安装

```bash
# 1. 在仓库目录生成 rule 文件
./scripts/convert.sh --tool trae

# 2. 切到目标项目根目录再安装（项目级，不要在 home 跑）
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool trae
```

执行后会得到 `<your-project>/.trae/rules/<agent-slug>.md` 一批文件。

## 关于"几乎不自动触发"——这是预期行为，不是 bug

对应 [issue #59](https://github.com/jnMetaCode/agency-agents-zh/issues/59)。

`scripts/convert.sh` 转换出的每条 rule 默认 frontmatter：

```yaml
---
description: <角色一句话描述>
globs:
alwaysApply: false
---
```

这是 Cursor / Trae 共同约定的 **"agent-requested rule"** —— 模型读完 description 自己判断要不要拉进来。一旦你 `install --tool trae` 把 215 条 rule 全装上：

- description 之间相互稀释，模型很难命中"应该用哪一条"；
- 即便命中也只是"读一下这条 rule"，不会变成长期 system prompt；
- 全量装载会消耗大量上下文预算，IDE 通常会挑选性截断。

**结论**：默认全装 = 几乎不会自动触发。这是设计决定，不是安装失败。

## 三种正确的使用姿势

### 姿势一：精选安装（强烈推荐）

只装你真正会用的 10–20 条，让自动匹配真正生效：

```bash
# 先生成
./scripts/convert.sh --tool trae

# 再按需复制
mkdir -p /your/project/.trae/rules
cp integrations/trae/rules/engineering-frontend-developer.md      /your/project/.trae/rules/
cp integrations/trae/rules/engineering-code-reviewer.md           /your/project/.trae/rules/
cp integrations/trae/rules/engineering-backend-architect.md       /your/project/.trae/rules/
cp integrations/trae/rules/engineering-git-workflow-master.md     /your/project/.trae/rules/
# ... 按当前项目的语言/框架/职责挑
```

或者先全装、再到 `.trae/rules/` 删掉用不上的（更直接）。

### 姿势二：在对话里显式 @ 调用

即使全装，你也可以在 Trae Chat / Builder 里手动指定：

```
@engineering-pc-host-engineer 帮我审查这段 QSerialPort 的粘包处理
@engineering-code-reviewer 看下这次提交的安全风险
```

`@` 后输入 rule 文件名（去掉 `.md`）即可定向加载。这条永远生效，不依赖模型的自动判断。

### 姿势三：把高频 rule 改为 alwaysApply

挑 1–3 条**绝大多数对话都需要**的（如代码审查标准、git 工作流），手动改其 frontmatter：

```yaml
---
description: ...
globs: "**/*.ts,**/*.tsx"   # 也可按文件类型自动挂载
alwaysApply: true            # 始终生效
---
```

⚠️ 不要把所有 rule 都改成 `alwaysApply: true`——会爆上下文，且角色之间互相打架。

## 对照表：什么时候用哪种

| 场景 | 推荐姿势 |
|------|----------|
| 单一技术栈（纯前端 / 纯 Qt / 纯 K8s 运维） | 姿势一（精选 5–10 条） + 姿势三（核心 1–2 条 alwaysApply） |
| 多面手项目，今天前端、明天后端、后天写文档 | 姿势一（精选 15–20 条） + 姿势二（按需 @）|
| 偶尔用一下某个垂直角色（小红书运营 / 直播电商） | 姿势二（@ 调用即可，不必常驻）|

## 故障排查

- **`.trae/rules/` 里有文件但 Trae 看不到**：确认在项目根目录而不是 home 目录；重启 Trae 一次；扩展名必须是 `.md`，不是 `.mdc`。
- **`@<rule-name>` 补全列表里看不到刚装的 rule**：Trae 启动时扫描一次目录，新装后需要重启窗口。
- **装了一堆但模型还是答得很泛**：参见上文"几乎不自动触发"——把 `.trae/rules/` 里的文件砍到 10–20 条以内再试。
- **想看每条 rule 的 description**：直接 `head -5` rule 文件即可，frontmatter 一目了然。

## 重新生成

修改了源 agent（`engineering/`、`marketing/` 等目录下的 `.md`）后：

```bash
./scripts/convert.sh --tool trae
# 已经 install 过的项目需要重新跑一次 install --tool trae 才会同步
```
