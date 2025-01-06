shopt -s inherit_errexit

DIRECTORY="/etc/nixos"    # Git directory we're operating on
ORIGINAL="original.patch" # Unsplit patch with all the hunks together
TMPDIR=$(mktemp -d)

cleanup_state()
{
  rm -rf "$TMPDIR"
}

trap cleanup_state EXIT # Delete TMPDIR on exit, even if user exits early
cd "$TMPDIR"

git -C "$DIRECTORY" diff >"$ORIGINAL" # Uses `git diff` for unstaged changes
splitpatch -H "$ORIGINAL"             # Split up patch into individual hunks

rm "$ORIGINAL" # Don't need it anymore now that the hunks are split up

applied_patches=$(fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd "$DIRECTORY"
for patch in $applied_patches; do
  # Read the patch content and apply it directly via stdin
  git apply --cached <"$TMPDIR/$patch"
done
