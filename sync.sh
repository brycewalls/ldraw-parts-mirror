#!/usr/bin/env bash
# Copy Studio's unofficial parts and primitives into this repository.
#
#   ./sync.sh
#   STUDIO_LDRAW="/path/to/ldraw" ./sync.sh
#   ./sync.sh --no-bl        # skip Studio's own bl_* files
set -euo pipefail
SRC="${STUDIO_LDRAW:-/Applications/Studio 2.0/ldraw}"
HERE="$(cd "$(dirname "$0")" && pwd)"
[ -d "$SRC/UnOfficial" ] || { echo "No Studio library at: $SRC"; exit 1; }

EXCL=()
[ "${1:-}" = "--no-bl" ] && EXCL=(--exclude='bl_*')

for sub in parts parts/s p; do
  mkdir -p "$HERE/ldraw/UnOfficial/$sub"
  # --delete so a part withdrawn upstream leaves here too, rather than the
  # mirror quietly serving something the library has retired.
  rsync -a --delete "${EXCL[@]}" --include='*/' --include='*.dat' --exclude='*' \
    "$SRC/UnOfficial/$sub/" "$HERE/ldraw/UnOfficial/$sub/" 2>/dev/null || true
done

echo "files: $(find "$HERE/ldraw" -name '*.dat' | wc -l | tr -d ' ')"
echo "size:  $(du -sh "$HERE/ldraw" | cut -f1)"
echo
echo "git add -A && git commit -m 'Sync parts' && git push"
