function ssh
    if test $TERM = xterm-kitty
        echo "using kitty +kitten ssh"
        echo
        kitty +kitten ssh $argv
    else
        command ssh $argv
    end
end