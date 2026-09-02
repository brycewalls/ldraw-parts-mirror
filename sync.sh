#!/usr/bin/env bash
# Copy Studio's unofficial parts and primitives into this repository.
#
#   ./sync.sh                 everything
#   ./sync.sh --no-bl         skip Studio's own bl_* files
#   STUDIO_LDRAW="/path" ./sync.sh
#
# Written for the bash macOS actually ships (3.2), where expanding an empty
# array under `set -u` is an error rather than nothing -- hence the plain
# string of rsync flags below instead of an array.
set -euo pipefail
SRC="${STUDIO_LDRAW:-/Applications/Studio 2.0/ldraw}"
HERE="$(cd "$(dirname "$0")" && pwd)"
[ -d "$SRC/UnOfficial" ] || { echo "No Studio library at: $SRC"; exit 1; }

EXCL=""
if [ "${1:-}" = "--no-bl" ]; then
  EXCL="--exclude=bl_*"
  echo "excluding Studio's bl_* files"
fi

for sub in parts parts/s p; do
  mkdir -p "$HERE/ldraw/UnOfficial/$sub"
  # --delete so a part withdrawn upstream leaves here too, rather than this
  # mirror quietly serving something the library has retired.
  # shellcheck disable=SC2086
  rsync -a --delete $EXCL \
    --include='*/' --include='*.dat' --exclude='*' \
    "$SRC/UnOfficial/$sub/" "$HERE/ldraw/UnOfficial/$sub/"
done

echo
echo "files: $(find "$HERE/ldraw" -name '*.dat' | wc -l | tr -d ' ')"
echo "size:  $(du -sh "$HERE/ldraw" | cut -f1)"
echo
echo "next: git add -A && git commit -m 'Sync parts' && git push"
