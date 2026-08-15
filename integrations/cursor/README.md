# Cursor Integration

Converts all 180 Agency agents into Cursor `.mdc` rule files. Rules are
**project-scoped** — install them from your project root.

## Install

```bash
# Convert first, then install from your project root
./scripts/convert.sh --tool cursor
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool cursor
```

This creates `.cursor/rules/<agent-slug>.mdc` files in your project.

## Finding and Activating Rules

After installation, rules default to `alwaysApply: false`, meaning they
won't activate automatically. You need to enable them manually:

1. Open **Cursor Settings** (`Cmd+,` / `Ctrl+,`) → **Rules** → **Project Rules**
2. You'll see all installed agent rules listed there
3. Toggle on the agents you need (avoid enabling all 180 at once — too much context)
4. Once enabled, the rules automatically apply in Cursor Chat and Composer

Alternatively, reference an agent in your prompt:

```
@rules Use the frontend developer standards to review this component.
```

Or enable a rule as always-on by editing its frontmatter:

```yaml
---
description: Expert frontend developer...
globs: "**/*.tsx,**/*.ts"
alwaysApply: true
---
```

## Troubleshooting

If you can't see rules in Cursor:

- Ensure `.cursor/rules/` is in your **project root** (not a global directory)
- Files must have `.mdc` extension (not `.md`)
- Try reopening the project or restarting Cursor

## Regenerate

```bash
./scripts/convert.sh --tool cursor
```
