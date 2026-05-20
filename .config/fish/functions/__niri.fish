function __niri
    if test -e /usr/bin/niri
        niri completions fish | source
    end
end
