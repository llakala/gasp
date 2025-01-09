shopt -s inherit_errexit

cleanup_state()
{
  rm -rf "$TMPDIR"
}

DIRECTORY="/etc/nixos"
diff=$(git -C "$DIRECTORY" diff) # Currently unstaged changes

# Internal dependency from nix package inputs, split patch into hunks within $TMPDIR
TMPDIR=$(hip "$diff")

trap cleanup_state EXIT # Delete TMPDIR on exit, even if user exits early

cd "$TMPDIR"
applied_patches=$(fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd "$DIRECTORY"
for patch in $applied_patches; do
  git apply --cached <"$TMPDIR/$patch" # Stage changes
done

# $TMPDIR is cleaned up here automatically