ORIGINAL=$1 # Original, unsplit contents of patch

TMPDIR=$(mktemp -d)
cd "$TMPDIR"

echo "$ORIGINAL" >"ORIGINAL.patch" # Uses `git diff` for unstaged changes
splitpatch -H "ORIGINAL.patch"     # Split up patch into individual hunks
rm "ORIGINAL.patch"                # Don't need it anymore now that the hunks are split up

echo "$TMPDIR" # So it can be cd'ed into, used, and then destroyed
