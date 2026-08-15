#!/usr/bin/env bash
#
# generate-regional-agent.sh — 用 Opus 生成区域专属原创 agent
#
# Usage:
#   scripts/generate-regional-agent.sh <target_dir> <category/file.md> <lang_native> "<name_native>" "<one-line desc>" "<region context, what platforms/regulations apply>"
#
# Example:
#   ./scripts/generate-regional-agent.sh /Users/yx/work/wenzhang/agency-agents-ko \
#     marketing/marketing-kakaotalk-business-operator.md \
#     "한국어 (Korean)" \
#     "KakaoTalk 비즈니스 채널 운영자" \
#     "KakaoTalk 비즈니스 채널 / 알림톡 / 친구톡 마케팅 전문가" \
#     "KakaoTalk 채널, 알림톡 vs 친구톡, 친구 추가율, 카카오 모먼트, 한국 메신저 마케팅 규제, ..."

set -euo pipefail

TARGET_DIR="${1:?target dir required}"
REL_PATH="${2:?relative file path required (e.g. marketing/marketing-foo.md)}"
LANG_NATIVE="${3:?lang native (e.g. \"한국어 (Korean)\")}"
NAME_NATIVE="${4:?agent name in native lang}"
DESCRIPTION="${5:?one-line description}"
REGION_CONTEXT="${6:?region context: platforms, regulations, user behavior etc.}"

MODEL="${MODEL:-opus}"
OUT="$TARGET_DIR/$REL_PATH"

if [ -f "$OUT" ] && [ "${FORCE:-0}" != "1" ]; then
  echo "[skip] $REL_PATH already exists (use FORCE=1)"
  exit 0
fi

mkdir -p "$(dirname "$OUT")"

PROMPT_FILE=$(mktemp -t gen-agent-XXXXXX.txt)
trap 'rm -f "$PROMPT_FILE"' EXIT

cat > "$PROMPT_FILE" <<PROMPT_EOF
You are generating a new AI agent persona file in markdown for the agency-agents project.

TARGET LANGUAGE: ${LANG_NATIVE}
AGENT NAME (in native language): ${NAME_NATIVE}
ONE-LINE DESCRIPTION (in native language, expand as needed): ${DESCRIPTION}

REGION CONTEXT (use as inspiration; ground your content in real concrete platforms / regulations / user behavior — DO NOT invent fake API endpoints or pricing):
${REGION_CONTEXT}

OUTPUT FORMAT — strictly follow this skeleton:

\`\`\`
---
name: ${NAME_NATIVE}
description: <expand the description into 1-2 natural-flowing sentences in ${LANG_NATIVE}, ~30-60 words>
emoji: <pick a fitting emoji>
color: <pick a fitting color, either a CSS name like "indigo" or HEX like "#FF2442">
---

# ${NAME_NATIVE}

<one short paragraph in ${LANG_NATIVE} introducing the agent — "You are ..., a seasoned practitioner in ...">

## <translated heading: "Identity & Memory">

- **<role>**: ...
- **<personality>**: ...
- **<memory>**: ...
- **<experience>**: ...

## <translated heading: "Core Mission">

### <subsection in native lang>
- Specific bullet 1
- Specific bullet 2
- (3-5 bullets per subsection)

### <subsection 2>
...

### <subsection 3>
...

## <translated heading: "Critical Rules">

### <subsection>
- Rule with WHY/HOW
- ...

### <subsection 2>
- ...

## <translated heading: "Technical Deliverables">

### <deliverable 1, e.g. a content template or process>

\\\`\\\`\\\`<lang or markdown>
<actual concrete template / code / spec>
\\\`\\\`\\\`

### <deliverable 2>

\\\`\\\`\\\`
...
\\\`\\\`\\\`

### <deliverable 3>

\\\`\\\`\\\`
...
\\\`\\\`\\\`

## <translated heading: "Workflow Process">

### Step 1: ...
- Action
- Action
- Action

### Step 2: ...
...

### Step 3: ...
...

## <translated heading: "Communication Style">

- **<adjective>**: "<example phrase in ${LANG_NATIVE}>"
- **<adjective>**: "<example>"
- (3-5 bullets)

## <translated heading: "Success Metrics">

You're successful when:
- Quantifiable metric 1
- Quantifiable metric 2
- (5-8 bullets, mix of business outcomes + craft quality)

---

**Reference Note**: <one sentence reminder about how this agent extends agency-agents>
\`\`\`

CONTENT REQUIREMENTS:
- Write in NATURAL, professional ${LANG_NATIVE} — not literal translation from English. Use the register that senior practitioners in this region/language would use.
- Be CONCRETE with platform names, feature names, regulations, KPIs that are REAL in this region. Refer to actual product names (e.g. KakaoTalk channels, Naver SmartStore, Wildberries seller cabinet). Do NOT invent fake APIs or fake pricing.
- KEEP English technical terms as-is when standard (CRM, ROI, GMV, SEO, API, OAuth, etc.). Do NOT awkwardly translate trademarks/product names.
- Include at least 3 concrete "Technical Deliverables" code blocks (templates, formulas, checklists, JSON schemas, etc.).
- Target length: 180-280 lines.
- Output ONLY the agent markdown file. Do NOT wrap in code fences. Start directly with the frontmatter \`---\`.
- Do NOT add any prefatory text like "Here is the agent file:". Start with \`---\`.
PROMPT_EOF

if claude -p --no-session-persistence --model "$MODEL" --output-format text \
    --disallowedTools "Write,Edit,NotebookEdit,Read,Bash,Glob,Grep,WebFetch,WebSearch,Task" \
    --append-system-prompt "You MUST NOT call any tools. Output the markdown content as plain text in your response. Do not say 'I'll output...' or 'The file is ready...' — just emit the markdown starting with ---." \
    "$(cat "$PROMPT_FILE")" < /dev/null > "$OUT" 2>/dev/null; then
  LINES=$(wc -l < "$OUT" | tr -d ' ')
  FIRST=$(head -1 "$OUT")
  if [ "$FIRST" = "---" ] && [ "$LINES" -gt 100 ]; then
    echo "[ok  ] $REL_PATH ($LINES lines)"
  else
    echo "[WARN] $REL_PATH may be broken: starts with '$FIRST', $LINES lines"
  fi
else
  echo "[ERR ] generation failed: $REL_PATH"
  exit 1
fi
