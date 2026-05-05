##? clip - allows pipeing content into the clipboard using OSC 52.

function clip
    # Start the OSC 52 sequence
    if set -q ZELLIJ
        printf "\ePtmux;\e\e]52;c;"
    else
        printf "\e]52;c;"
    end

    # Pipe the data through base64 and strip all newlines/whitespace
    # then output it directly to the terminal
    cat $argv | base64 -w 0 | tr -d '[:space:]'

    # Send the Bell character to terminate the sequence
    if set -q ZELLIJ
        printf "\a\e\\"
    else
        printf "\a"
    end
end

# vim: ft=zsh ts=4 sw=4 expandtab
