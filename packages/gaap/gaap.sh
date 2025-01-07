shopt -s inherit_errexit

cleanup_state()
{
  rm -rf "$TMPDIR"
}

DIRECTORY="/etc/nixos"
diff=$(git -C "$DIRECTORY" diff)

# Internal dependency from nix package inputs, split patch into hunks within $TMPDIR
TMPDIR=$(hip "$diff")

trap cleanup_state EXIT # Delete TMPDIR on exit, even if user exits early

cd "$TMPDIR"
applied_patches=$(fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd "$DIRECTORY"
for patch in $applied_patches; do
  # Read the patch content and apply it directly via stdin
  git apply --cached <"$TMPDIR/$patch"
done

# $TMPDIR is cleaned up here automatically