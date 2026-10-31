#!/usr/bin/env bash
# Génère les pages secondaires à partir de src/pages/*.html et des gabarits de src/partials.
# Chaque fichier source commence par des lignes CLE=valeur, puis une ligne "---", puis le contenu.
# Usage : bash tools/build-pages.sh   (depuis la racine du site)
set -euo pipefail
cd "$(dirname "$0")/.."

BASE="https://ciprio.vercel.app"

for src in src/pages/*.html src/pages/blog/*.html; do
  [ -f "$src" ] || continue
  meta=$(sed '/^---$/q' "$src" | sed '$d')
  body=$(sed '1,/^---$/d' "$src")
  get() { printf '%s\n' "$meta" | sed -n "s/^$1=//p" | head -1; }
  out=$(get OUT); title=$(get TITLE); desc=$(get DESC); path=$(get PATH); cur=$(get NAV); ogtype=$(get OGTYPE)
  extra=$(printf '%s\n' "$meta" | sed -n 's/^EXTRA=//p')
  [ -n "$ogtype" ] || ogtype="website"

  fill() {
    awk -v TITLE="$title" -v DESC="$desc" -v BASE="$BASE" -v PATHV="$path" -v OGTYPE="$ogtype" -v EXTRA="$extra" -v CUR="$cur" '
      function rep(s, k, v,   i) { while ((i = index(s, k)) > 0) s = substr(s, 1, i - 1) v substr(s, i + length(k)); return s }
      {
        line = $0
        line = rep(line, "{{TITLE}}", TITLE); line = rep(line, "{{DESC}}", DESC)
        line = rep(line, "{{BASE}}", BASE); line = rep(line, "{{PATH}}", PATHV)
        line = rep(line, "{{OGTYPE}}", OGTYPE); line = rep(line, "{{EXTRA}}", EXTRA)
        while (match(line, /\{\{CUR_[a-z]+\}\}/)) {
          key = substr(line, RSTART + 6, RLENGTH - 8)
          line = substr(line, 1, RSTART - 1) (key == CUR ? " aria-current=\"page\"" : "") substr(line, RSTART + RLENGTH)
        }
        print line
      }' "$1"
  }

  mkdir -p "$(dirname "$out")"
  {
    fill src/partials/head.html
    fill src/partials/nav.html
    printf '%s\n' "$body"
    fill src/partials/footer.html
    printf '</body>\n</html>\n'
  } > "$out"
  echo "built $out"
done
