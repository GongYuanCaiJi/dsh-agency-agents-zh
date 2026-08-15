#!/usr/bin/env bash
#
# sync-tw.sh — 自动生成繁體中文 README
#
# 用法：./scripts/sync-tw.sh
#
# 依赖：opencc（brew install opencc）

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SRC="$REPO_ROOT/README.md"
DST="$REPO_ROOT/README.zh-TW.md"

if ! command -v opencc >/dev/null 2>&1; then
  echo "[ERR] 未找到 opencc，请先安装：brew install opencc"
  exit 1
fi

# 1. OpenCC 简体转台湾繁体
opencc -i "$SRC" -o "$DST" -c s2twp

# 2. 修正术语："智慧體"→"智能體"（台湾开发者通用）
sed -i '' 's/智慧體/智能體/g' "$DST"

# 3. 修正标题，加上"繁體中文"标记
sed -i '' 's/^# agency-agents 中文版（AI 智能體專家團隊）/# agency-agents 中文版（AI 智能體專家團隊）繁體中文/' "$DST"

# 4. 修正语言导航：繁体版高亮繁體中文
sed -i '' 's/\*\*簡體中文\*\*/[簡體中文](README.md)/' "$DST"
sed -i '' 's/\[繁體中文\](README.zh-TW.md)/**繁體中文**/' "$DST"

echo "[OK] 已生成 $DST"
