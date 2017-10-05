tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
    trap - INT EXIT
}

# Change the color of the tab when using SSH
# reset the color after the connection closes
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "*prd*" ]]; then
            tab-color 216 0 0
        elif [[ "$*" =~ "*dev*" ]]; then
            tab-color 0 108 216
        else
            #tab-color 179 179 179
        fi
    fi
    command ssh $*
}

compdef _ssh color-ssh=ssh

alias ssh=color-ssh
