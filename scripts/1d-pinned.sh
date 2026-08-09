#!/bin/sh
set -e

if [ ! -d "$PINNED_DIR" ]; then
    echo "Error: $PINNED_DIR does not exist." >&2
    exit 1
fi

if ! command -v xdowngrade >/dev/null 2>&1; then
    echo "Error: xdowngrade not found. Install the xtools package first." >&2
    exit 1
fi

for f in "$PINNED_DIR"/*.xbps; do
    [ -f "$f" ] || continue

    echo "Downgrading/installing from $f ..."
    yes | sudo xdowngrade "$f"

    # Derive pkgname from the pkgver string to hold it afterward
    pkgver=$(xbps-uhelper getpkgversion "$f" 2>/dev/null || true)
    if [ -z "$pkgver" ]; then
        base=$(basename "$f")
        pkgname=$(echo "$base" | sed -E 's/-[0-9][^-]*_[0-9]+\.[a-zA-Z0-9_]+\.xbps$//')
    else
        pkgname=$(xbps-uhelper getpkgname "$pkgver" 2>/dev/null || true)
        [ -z "$pkgname" ] && pkgname=$(echo "$(basename "$f")" | sed -E 's/-[0-9][^-]*_[0-9]+\.[a-zA-Z0-9_]+\.xbps$//')
    fi

    if [ -n "$pkgname" ]; then
        echo "Holding $pkgname ..."
        sudo xbps-pkgdb -m hold "$pkgname"
    else
        echo "Warning: could not determine package name for $f, skipping hold" >&2
    fi
done
