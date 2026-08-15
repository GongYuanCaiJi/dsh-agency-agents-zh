#!/usr/bin/env bash
#
# generate-ar-catalog.sh — 扫描 ar repo 的 agent 文件，从 frontmatter 抽 name，生成 CATALOG.md
#
# Usage: scripts/generate-ar-catalog.sh <target_repo_dir>

set -euo pipefail

TARGET="${1:?target repo dir required}"
OUT="$TARGET/CATALOG.md"

if [ ! -d "$TARGET" ]; then
  echo "[ERR] $TARGET does not exist"
  exit 1
fi

dept_name() {
  case "$1" in
    academic)            echo "📖 أكاديمي" ;;
    design)              echo "🎨 التصميم" ;;
    engineering)         echo "🛠️ الهندسة" ;;
    finance)             echo "🏦 المالية" ;;
    game-development)    echo "🎮 تطوير الألعاب" ;;
    hr)                  echo "👔 الموارد البشرية" ;;
    legal)               echo "⚖️ القانوني" ;;
    marketing)           echo "📢 التسويق" ;;
    paid-media)          echo "💰 الإعلانات المدفوعة" ;;
    product)             echo "📦 المنتج" ;;
    project-management)  echo "📋 إدارة المشاريع" ;;
    sales)               echo "💼 المبيعات" ;;
    spatial-computing)   echo "🥽 الحوسبة المكانية" ;;
    specialized)         echo "🔬 تخصصات" ;;
    supply-chain)        echo "🚚 سلسلة التوريد" ;;
    support)             echo "🤝 الدعم" ;;
    testing)             echo "🧪 الاختبار" ;;
    gis)                 echo "🗺️ نظم المعلومات الجغرافية" ;;
    security)            echo "🛡️ الأمن" ;;
    *)                   echo "$1" ;;
  esac
}

DEPT_ORDER="academic design engineering finance game-development hr legal marketing paid-media product project-management sales spatial-computing specialized supply-chain support testing gis security"

cat > "$OUT" <<'HEADER_EOF'
# كتالوج الوكلاء

> استخدم Ctrl+F / Cmd+F للبحث بالاسم العربي، ثم اعثر على مسار الملف وأخبر أداة الذكاء الاصطناعي بتحميله.
>
> مثال: `استخدم الدور engineering/engineering-software-architect.md لمراجعة بنيتي المعمارية`

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
  printf "\n## %s (%d)\n\n| الاسم | مسار الملف |\n|---------|-----------|\n" "$dname" "$count" >> "$OUT"
  echo "$files" | while read -r f; do
    [ -z "$f" ] && continue
    name=$(extract_name "$f")
    rel=${f#"$TARGET/"}
    echo "| $name | \`$rel\` |" >> "$OUT"
  done
done

printf "\n---\n\n" >> "$OUT"
TOTAL=$(find "$TARGET" -name "*.md" -not -path "*/.*" -not -name "README.md" -not -name "CATALOG.md" -not -name "CONTRIBUTING.md" -not -name "UPSTREAM.md" -not -name "AGENT-LIST.md" -not -name "LICENSE*" -not -path "*/scripts/*" | wc -l | tr -d ' ')
echo "**الإجمالي: $TOTAL وكيلاً** · الترجمة العربية لـ [agency-agents](https://github.com/msitarzewski/agency-agents)" >> "$OUT"

echo "[ok] generated $OUT ($(wc -l < "$OUT" | tr -d ' ') lines, $TOTAL agents)"
