#!/usr/bin/env fish

switch (count $argv)
    case 0
        set DIRECTORY (pwd -P)

    case 1
        set DIRECTORY $argv[1]

    case '*'
        echo "Too many arguments! Only expected 0 or 1."
        exit 1
end

satod $DIRECTORY kill
