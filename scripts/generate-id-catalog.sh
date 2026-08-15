#!/usr/bin/env bash
#
# generate-id-catalog.sh — 扫描 id repo 的 agent 文件，从 frontmatter 抽 name，生成 CATALOG.md
#
# Usage: scripts/generate-id-catalog.sh <target_repo_dir>

set -euo pipefail

TARGET="${1:?target repo dir required}"
OUT="$TARGET/CATALOG.md"

if [ ! -d "$TARGET" ]; then
  echo "[ERR] $TARGET does not exist"
  exit 1
fi

dept_name() {
  case "$1" in
    academic)            echo "📖 Akademik" ;;
    design)              echo "🎨 Design" ;;
    engineering)         echo "🛠️ Engineering" ;;
    finance)             echo "🏦 Finance" ;;
    game-development)    echo "🎮 Game Dev" ;;
    hr)                  echo "👔 HR" ;;
    legal)               echo "⚖️ Hukum" ;;
    marketing)           echo "📢 Marketing" ;;
    paid-media)          echo "💰 Paid Media" ;;
    product)             echo "📦 Produk" ;;
    project-management)  echo "📋 Manajemen Proyek" ;;
    sales)               echo "💼 Sales" ;;
    spatial-computing)   echo "🥽 Spatial Computing" ;;
    specialized)         echo "🔬 Spesialisasi" ;;
    supply-chain)        echo "🚚 Supply Chain" ;;
    support)             echo "🤝 Support" ;;
    testing)             echo "🧪 Testing" ;;
    gis)                 echo "🗺️ GIS" ;;
    security)            echo "🛡️ Keamanan" ;;
    *)                   echo "$1" ;;
  esac
}

DEPT_ORDER="academic design engineering finance game-development hr legal marketing paid-media product project-management sales spatial-computing specialized supply-chain support testing gis security"

cat > "$OUT" <<'HEADER_EOF'
# Katalog Agent

> Gunakan Ctrl+F / Cmd+F untuk mencari nama Indonesia, temukan path file, lalu minta alat AI memuatnya.
>
> Contoh: `Gunakan persona engineering/engineering-software-architect.md untuk review arsitektur saya`

---

HEADER_EOF

extract_name() {
  local f="$1"
  awk 'BEGIN{c=0} /^---$/{c++; if(c>=2)exit; next} c==1 && /^name:/{sub(/^name:[[:space:]]*/, ""); gsub(/["'\''`]/, ""); sub(/[[:space:]]*$/, ""); print; exit}' "$f"
}

for dept in $DEPT_ORDER; do
  if [ ! -d "$TARGET/$dept" ]; then
    continue
  fi
  files=$(find "$TARGET/$dept" -name "*.md" -not -name "README.md" | sort)
  count=$(echo "$files" | grep -c '^.' || true)
  if [ "$count" -eq 0 ]; then
    continue
  fi
  dname=$(dept_name "$dept")
  printf "\n## %s (%d)\n\n| Nama | Path file |\n|---------|-----------|\n" "$dname" "$count" >> "$OUT"
  echo "$files" | while read -r f; do
    [ -z "$f" ] && continue
    name=$(extract_name "$f")
    rel=${f#"$TARGET/"}
    echo "| $name | \`$rel\` |" >> "$OUT"
  done
done

printf "\n---\n\n" >> "$OUT"
TOTAL=$(find "$TARGET" -name "*.md" -not -path "*/.*" -not -name "README.md" -not -name "CATALOG.md" -not -name "CONTRIBUTING.md" -not -name "UPSTREAM.md" -not -name "AGENT-LIST.md" -not -name "LICENSE*" -not -path "*/scripts/*" | wc -l | tr -d ' ')
echo "**Total: $TOTAL agen** · terjemahan Bahasa Indonesia dari [agency-agents](https://github.com/msitarzewski/agency-agents)" >> "$OUT"

echo "[ok] generated $OUT ($(wc -l < "$OUT" | tr -d ' ') lines, $TOTAL agents)"
