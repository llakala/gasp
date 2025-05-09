#!/usr/bin/env fish

set FZF_DEFAULT_OPTS (fmbl)

switch (count $argv)
    case 0
        set DIRECTORY (pwd -P)

    case 1
        if [ $argv[1] = "." ]
            echo "unable to understand passing a period!"
            exit 1
        end
        set DIRECTORY $argv[1]


    case '*'
        echo "Error: Too many arguments passed"
        exit 1
end

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
