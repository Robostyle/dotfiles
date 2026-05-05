function __zoxide
    if test -e /usr/bin/zoxide
        zoxide init fish | source
    end
end
