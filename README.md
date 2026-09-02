# ldraw-parts-mirror

Part files for [Brick Outliner](https://brycewalls.github.io/brick-outliner/),
served straight from GitHub through jsDelivr. No Firebase, no bucket, no
egress bill.

## Drop the folder in

Copy BrickLink Studio's `ldraw` folder in at the top level, so the tree reads:

    ldraw/UnOfficial/parts/*.dat      unofficial parts
    ldraw/UnOfficial/parts/s/*.dat    their subparts
    ldraw/UnOfficial/p/*.dat          unofficial primitives

`sync.sh` does exactly that copy, and only that copy:

    ./sync.sh                                  # from /Applications/Studio 2.0/ldraw
    STUDIO_LDRAW=/some/other/path ./sync.sh

Then:

    git add -A && git commit -m "Sync parts" && git push

## Why the layout is not negotiable

Brick Outliner asks a mirror for `MIRROR + key`, where the key is the path
below `parts/` or `p/`, lowercased — `3001.dat`, `s/3068bs01.dat`. The two
directories above map onto two entries in the tool's `MIRRORS` list, so the
folders here have to keep those exact names. Flatten or rename them and every
lookup 404s.

The official `parts/` tree is deliberately **not** here: the public LDraw
mirrors serve it and stay authoritative, and a stale copy shadowing the live
library is a bug this project has already had once.

## Serving

jsDelivr, from a tag rather than a branch, so files are cached hard and a
re-sync is a deliberate act:

    https://cdn.jsdelivr.net/gh/<user>/ldraw-parts-mirror@<tag>/ldraw/UnOfficial/parts/

Bump the tag after a sync, then update `MIRRORS` in the tool.

## Licensing

Most files here are LDraw community files under CCAL 2.0 or CC BY 4.0 and are
redistributable with attribution — see the LDraw section of the tool's NOTICE.
A minority, chiefly those named `bl_*`, carry no `!LICENSE` line and are
marked `0 Author: Studio`; they originate with BrickLink. They are mirrored
here as a deliberate decision by this repository's owner, not because a
licence grants it. If you hold rights in them and would rather they were not
mirrored, open an issue and they will be removed.
