#!/usr/bin/env fish

set FZF_DEFAULT_OPTS (fmbl)

set DIRECTORY /etc/nixos

function cleanup_state
    rm -rf $TMPDIR
end

# Currently staged changes, with -R so we can unstage them
# Use `string collect` to not split on newlines
set diff (git -C $DIRECTORY diff --staged -R | string collect)

# Internal dependency from nix package inputs
# Splits patch into hunks within $TMPDIR
set TMPDIR (hip $diff)

# Delete TMPDIR on exit, even if user exits early
trap cleanup_state EXIT

cd $TMPDIR
set applied_patches (fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd $DIRECTORY
for patch in $applied_patches
    # Unstage the given patch thanks to -R in the `git diff` command
    # Using `-` to read from stdin
    cat "$TMPDIR/$patch" | git apply --cached -
end

# $TMPDIR is cleaned up here automatically
