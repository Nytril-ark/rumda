#!/bin/bash

CYAN='\033[36m'
GREEN='\033[32m'
NC='\033[0m'

DIR="."
SORT_MODE="pages"
TARGETS=()

for arg in "$@"; do
  if [[ "$arg" == "-s" ]]; then
    NEED_SORT=1
  elif [[ "$NEED_SORT" == "1" ]]; then
    SORT_MODE="$arg"
    NEED_SORT=0
  elif [[ "$arg" =~ ^[0-9]+$ ]]; then
    TARGETS+=("$arg")
  else
    DIR="$arg"
  fi
done

if ! command -v pdfinfo >/dev/null 2>&1; then
  echo "pdfinfo not found. Install poppler-utils (e.g. apt install poppler-utils)"
  exit 1
fi

total=0
results=()
maxlen=5

while IFS= read -r -d '' file; do
  pages=$(pdfinfo "$file" 2>/dev/null | awk -F': *' '/^Pages/{print $2}')
  if [[ -n "$pages" ]]; then
    total=$((total + pages))
    results+=("$pages"$'\t'"$file")
    (( ${#pages} > maxlen )) && maxlen=${#pages}
  else
    results+=("0"$'\t'"$file"$'\t'"unreadable")
  fi
done < <(find "$DIR" -type f -iname "*.pdf" -print0)

if [[ "$SORT_MODE" == "name" ]]; then
  sorted=$(printf "%s\n" "${results[@]}" | sort -t$'\t' -k2)
else
  sorted=$(printf "%s\n" "${results[@]}" | sort -t$'\t' -k1,1nr)
fi

printf "%${maxlen}s  ${CYAN}%s${NC}\n" "Pages" "File"
printf "%${maxlen}s  ${CYAN}%s${NC}\n" "-----" "----"

while IFS=$'\t' read -r pages file flag; do
  if [[ "$flag" == "unreadable" ]]; then
    printf "%${maxlen}s  ${CYAN}%s${NC} - could not read page count\n" "?" "$file"
  else
    printf "%${maxlen}s  ${CYAN}%s${NC}\n" "$pages" "$file"
  fi
done <<< "$sorted"

echo
printf "${CYAN}Total pages:${NC} %s\n" "$total"

if [[ ${#TARGETS[@]} -gt 0 && "$total" -gt 0 ]]; then
  sum=0
  for t in "${TARGETS[@]}"; do
    sum=$(( sum + t ))
  done
  percent=$(( sum * 100 / total ))
  printf "%s/%s ${GREEN}[%s%%]${NC}\n" "$sum" "$total" "$percent"
fi
