#!/usr/bin/env fish

set FZF_DEFAULT_OPTS (fmbl)

switch (count $argv)
    case 0
        set DIRECTORY /etc/nixos

    case 1
        set DIRECTORY $argv[1]

    case '*'
        echo "Error: Too many arguments passed"
        exit 1
end

function cleanup_state
    rm -rf $TMPDIR
end

# Currently unstaged changes
# Use `string collect` to not split on newlines
set diff (git -C $DIRECTORY diff | string collect)

# Internal dependency from nix package inputs
# Splits patch into hunks within $TMPDIR
set TMPDIR (hip $diff)

# Delete TMPDIR on exit, even if user exits early
trap cleanup_state EXIT

cd $TMPDIR
set applied_patches (fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd $DIRECTORY
for patch in $applied_patches
    # Remove the given patch from tree via -R, Using `-` to read from stdin
    cat "$TMPDIR/$patch" | git apply -R -
end

# $TMPDIR is cleaned up here automatically
