#!/bin/zsh
#

# Release some autoloads
autoload -Uz colors; colors
autoload -Uz is-at-least; is-at-least

typeset TMPFILE="/tmp/.zplug-$$$RANDOM"

if [[ -z $ZSH_VERSION ]]; then
    printf "this requires zsh 4.1.9 or newer\n"
    exit 1
fi

root=$(dirname ${0:A})

export ZPLUG_HOME=${root}/.zplug

setup_zsh_configs()
{
    ln -sf ${root}/.zshrc $HOME/.zshrc
    ln -sf ${root}/.p10k.zsh $HOME/.p10k.zsh
    ln -sf ${root}/.zsh_aliases $HOME/.zsh_aliases
    
    # point .zplug home to correct location
    sed "s@%%PLACEHOLDER_zplughome%%@$ZPLUG_HOME@g" ${root}/.zshenv > $HOME/.zshenv
}

setup_tmux_configs()
{
    ln -sf ${root}/.tmux.conf $HOME/.tmux.conf

    [ -d $HOME/.tmuxp ] && rm -rf $HOME/.tmuxp
    ln -sf ${root}/.tmuxp $HOME/.tmuxp

    # install tpm plugin manager
    git clone https://github.com/tmux-plugins/tpm ${root}/.tmux/plugins/tpm
    ln -sf ${root}/.tmux $HOME/.tmux
}

setup_alacritty_configs()
{
    [ -d $HOME/.config/alacritty ] && rm -rf $HOME/.config/alacritty
    ln -sf ${root}/config/alacritty $HOME/.config/alacritty
}

setup_zplug()
{
    [ -d $ZPLUG_HOME ] && rm -rf $ZPLUG_HOME
    git clone https://github.com/zplug/zplug.git $ZPLUG_HOME
}

spin()
{
    local \
        before_msg="$1" \
        after_msg="$2"
    local    spinner
    local -a spinners
    spinners=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)

    # hide cursor
    tput civis

    while true
    do
        for spinner in "${spinners[@]}"
        do
            if [[ -f $TMPFILE ]]; then
                rm -f $TMPFILE
                tput cnorm
                return 1
            fi
            sleep 0.05
            printf " $fg[white]$spinner$reset_color  $before_msg\r" 2>/dev/null
        done

        echo "$jobstates" \
            | awk '
            /[0-9]+=/ {
                jobs[++job_count] = $0
            }
            END {
                for (i = 1; i <= job_count; i++) {
                    print(jobs[i])
                }
                exit job_count == 0
            }' \
                | xargs test -z && break
    done

    if [[ -n $after_msg ]]; then
        printf "\033[2K"
        printf " $fg_bold[blue]\U2714$reset_color  $after_msg\n"
    fi 2>/dev/null

    # show cursor
    tput cnorm || true
}

execute()
{
    local    arg title error
    local -a args errors

    while (( $# > 0 ))
    do
        case "$1" in
            --title)
                title="$2"
                shift
                ;;
            --error)
                errors+=( "$2" )
                shift
                ;;
            -*|--*)
                return 1
                ;;
            *)
                args+=( "$1" )
                ;;
        esac
        shift
    done

    {
        for arg in "${args[@]}"
        do
            ${~${=arg}} &>/dev/null
            # When an error causes
            if [[ $status -ne 0 ]]; then
                # error mssages
                printf "\033[2K" 2>/dev/null
                printf \
                    " $fg[yellow]\U26A0$reset_color  $title [$fg[red]FAILED$reset_color]\n" \
                    2>/dev/null
                printf "$status\n" >"$TMPFILE"
                # additional error messages
                if (( $#errors > 0 )); then
                    for error in "${errors[@]}"
                    do
                        printf "    -> $error\n" 2>/dev/null
                    done
                fi
            fi
        done
    } &

    spin \
        "$title" \
        "$title [$fg[green]SUCCEEDED$reset_color]"

    if [[ $status -ne 0 ]]; then
	printf "\033[2K" 2>/dev/null
	printf "Oops \U2620 ... Try again!\n" 2>/dev/null
	exit 1
    fi
}


execute \
    --title \
    "Checking if your zsh version is newer than 4.1.9" \
    "sleep 1" \
    "is-at-least 4.1.9"

execute \
    --title \
    "Setup zsh config files" \
    "setup_zsh_configs"

execute \
    --title \
    "Setup tmux/tmuxp config files" \
    "setup_tmux_configs"

execute \
    --title \
    "Setup alacritty config files" \
    "setup_alacritty_configs"

execute \
    --title \
    "Installing zplug to $ZPLUG_HOME" \
    --error \
    "Is git installed?" \
    --error \
    "Does '$ZPLUG_HOME' already exist?" \
    "setup_zplug"

printf " All processes are successfully completed \U1F389\n"
