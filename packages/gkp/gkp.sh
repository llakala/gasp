shopt -s inherit_errexit

cleanup_state()
{
  rm -rf "$TMPDIR"
}

DIRECTORY="/etc/nixos"
diff=$(git -C "$DIRECTORY" diff) # Unstaged changes

# Internal dependency from nix package inputs, split patch into hunks within $TMPDIR
TMPDIR=$(hip "$diff")

trap cleanup_state EXIT # Delete TMPDIR on exit, even if user exits early

cd "$TMPDIR"
applied_patches=$(fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd "$DIRECTORY"
for patch in $applied_patches; do
  git apply -R <"$TMPDIR/$patch" # -R to get rid of an unstaged change
done

# $TMPDIR is cleaned up here automatically