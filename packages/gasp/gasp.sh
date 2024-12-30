DIRECTORY="/etc/nixos" # Git directory we're operating on
TMPDIR=$(mktemp -d)
ORIGINAL="original.patch" # Unsplit patch with all the hunks together
BAD_PATTERN="diff --git"  # `splitpatch` has a bug that adds bad output to the end of each hunk

cd "$TMPDIR"

git -C "$DIRECTORY" diff >"$ORIGINAL" # Uses `git diff` for unstaged changes
splitpatch -H "$ORIGINAL"             # Split up patch into individual hunks

rm "$ORIGINAL" # So we can iterate over each hunk individually

for file in *.patch; do

  # Check last two lines for bad pattern
  if tail -n 2 "$file" | rg -q "$BAD_PATTERN" "$file"; then
    head -n -2 "$file" >tmpfile && mv tmpfile "$file"
  fi

done

applied_patches=$(fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd "$DIRECTORY"
for patch in $applied_patches; do
  # Read the patch content and apply it directly via stdin
  git apply --cached <"$TMPDIR/$patch"
done

rm -rf "$TMPDIR"
