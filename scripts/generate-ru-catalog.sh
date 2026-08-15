#!/usr/bin/env bash
#
# generate-ru-catalog.sh — 扫描 ru repo 的 agent 文件，从 frontmatter 抽 name，生成 CATALOG.md
#
# Usage: scripts/generate-ru-catalog.sh <target_repo_dir>

set -euo pipefail

TARGET="${1:?target repo dir required}"
OUT="$TARGET/CATALOG.md"

if [ ! -d "$TARGET" ]; then
  echo "[ERR] $TARGET does not exist"
  exit 1
fi

dept_name() {
  case "$1" in
    academic)            echo "📖 Академический" ;;
    design)              echo "🎨 Дизайн" ;;
    engineering)         echo "🛠️ Инжиниринг" ;;
    finance)             echo "🏦 Финансы" ;;
    game-development)    echo "🎮 Game Dev" ;;
    hr)                  echo "👔 HR" ;;
    legal)               echo "⚖️ Юридический" ;;
    marketing)           echo "📢 Маркетинг" ;;
    paid-media)          echo "💰 Платный трафик" ;;
    product)             echo "📦 Продукт" ;;
    project-management)  echo "📋 Проекты" ;;
    sales)               echo "💼 Продажи" ;;
    spatial-computing)   echo "🥽 Spatial Computing" ;;
    specialized)         echo "🔬 Спец. области" ;;
    supply-chain)        echo "🚚 Supply Chain" ;;
    support)             echo "🤝 Поддержка" ;;
    testing)             echo "🧪 Тестирование" ;;
    gis)                 echo "🗺️ ГИС" ;;
    security)            echo "🛡️ Безопасность" ;;
    *)                   echo "$1" ;;
  esac
}

DEPT_ORDER="academic design engineering finance game-development hr legal marketing paid-media product project-management sales spatial-computing specialized supply-chain support testing gis security"

cat > "$OUT" <<'HEADER_EOF'
# Каталог агентов

> Используйте Ctrl+F / Cmd+F для поиска по русскому имени, найдите путь к файлу и попросите AI-инструмент загрузить его.
>
> Пример: `Используйте роль engineering/engineering-software-architect.md для ревью моей архитектуры`

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
  printf "\n## %s (%d)\n\n| Имя | Путь к файлу |\n|---------|-----------|\n" "$dname" "$count" >> "$OUT"
  echo "$files" | while read -r f; do
    [ -z "$f" ] && continue
    name=$(extract_name "$f")
    rel=${f#"$TARGET/"}
    echo "| $name | \`$rel\` |" >> "$OUT"
  done
done

printf "\n---\n\n" >> "$OUT"
TOTAL=$(find "$TARGET" -name "*.md" -not -path "*/.*" -not -name "README.md" -not -name "CATALOG.md" -not -name "CONTRIBUTING.md" -not -name "UPSTREAM.md" -not -name "AGENT-LIST.md" -not -name "LICENSE*" -not -path "*/scripts/*" | wc -l | tr -d ' ')
echo "**Всего: $TOTAL агентов** · русский перевод [agency-agents](https://github.com/msitarzewski/agency-agents)" >> "$OUT"

echo "[ok] generated $OUT ($(wc -l < "$OUT" | tr -d ' ') lines, $TOTAL agents)"
