#!/usr/bin/env fish

set FZF_DEFAULT_OPTS (fmbl)
set GIT_DIRECTORY (pwd -P)

# The files that we're going to add individual patches from
set files (git diff --name-only | fzf --multi --preview-window="top" --preview="git diff {} | diff-so-fancy")

function cleanup_state
    rm -rf $TMPDIR
end

# Create a tmpdir, and delete it at the end of the script execution, or whenever
# the user exits early.
set TMPDIR (mktemp -d)
trap cleanup_state EXIT
cd $TMPDIR

for file in $files
    # We're going to make a subfolder for storing all the patches for this file.
    set folder_name (string replace --all --regex "[/.]" "-" $file)
    mkdir $folder_name
    cd $folder_name

    # Store the diff for the entire file into `original.patch` so we can split it
    set full_diff (git -C $GIT_DIRECTORY diff $file | string collect)
    echo $full_diff >"ORIGINAL.patch"

    # Split the patch into individual hunks,
    splitpatch -H "ORIGINAL.patch" >/dev/null # Split up patch into individual hunks
    rm "ORIGINAL.patch" # Don't need it anymore now that the hunks are split up

    # Choose from the individual hunks
    set patches (fzf --multi --preview-window="top" --preview="cat {} | diff-so-fancy")

    # Apply every hunk we selected
    for patch in $patches
        cat "$TMPDIR/$folder_name/$patch" | git -C $GIT_DIRECTORY apply --cached -
    end

    # Leave the subdir
    cd $TMPDIR
end
