#!/usr/bin/env fish

set FZF_DEFAULT_OPTS (fmbl)

switch (count $argv)
    case 0 1
        echo "Not enough arguments passed!"
        exit 1

    case 2
        if [ $argv[1] = "." ]
            echo "unable to understand passing a period for the directory!"
            exit 1
        end
        set DIRECTORY $argv[1]
        set TYPE $argv[2]

    case '*'
        echo "Error: Too many arguments passed"
        exit 1
end

switch $TYPE
    case hire
        # Unstaged diff
        set ORIGINAL_DIFF (git -C $DIRECTORY diff | string collect)

        # Apply the given patch to the staged changes, staging it
        function apply_diff -a tmpdir patch
            cat "$tmpdir/$patch" | git apply --cached -
        end

    case fire
        # Staged diff
        set ORIGINAL_DIFF (git -C $DIRECTORY diff --staged | string collect)

        # Unapply the given patch to the staged changes, unstaging it
        function apply_diff -a tmpdir patch
            cat "$tmpdir/$patch" | git apply --cached -R -
        end

    case kill
        # Unstaged diff
        set ORIGINAL_DIFF (git -C $DIRECTORY diff | string collect)

        # Unapply the given patch from the unstaged changes, getting rid of it
        function apply_diff -a tmpdir patch
            cat "$tmpdir/$patch" | git apply -R -
        end

    case '*'
        echo "Unexpected type! Expected hire, fire, or kill."
        exit 1

end

function cleanup_state
    rm -rf $TMPDIR
end

set TMPDIR (mktemp -d)
trap cleanup_state EXIT # Delete TMPDIR on exit, even if user exits early

cd $TMPDIR
echo $ORIGINAL_DIFF >"ORIGINAL.patch"
splitpatch -H "ORIGINAL.patch" >/dev/null # Split up patch into individual hunks
rm "ORIGINAL.patch" # Don't need it anymore now that the hunks are split up

set applied_patches (fzf -m --preview-window="top" --preview="cat {} | diff-so-fancy")

cd $DIRECTORY
for patch in $applied_patches
    apply_diff $TMPDIR $patch
end

# $TMPDIR is cleaned up here automatically
