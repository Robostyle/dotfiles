function __starship
    if test -e /usr/bin/starship
        set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
        starship init fish | source
    end
end
