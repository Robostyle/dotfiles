function __niri
    if test -e /usr/bin/zoxide
        niri completions fish | source
    end
end
