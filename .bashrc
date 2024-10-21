#
# ~/.bashrc
#\u@\h

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

_set_my_PS1() {
    PS1=' \[\e[35m\]\W\[\e[m\] ❯ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="\u@$iso_info \W > "
        fi
    fi
}
_set_my_PS1
unset -f _set_my_PS1

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1: Do not use for executable files!
    # Note2: uses mime bindings, so you may need to use
    #        e.g. a file manager to make some file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $*" >&2
        /usr/bin/exo-open "$@" >& /dev/null &
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            /usr/bin/xdg-open "$file" >& /dev/null &
        done
        return
    fi

    echo "Sorry, none of programs [$progs] is found." >&2
    echo "Tip: install one of packages" >&2
    for prog in $progs ; do
        echo "    $(pacman -Qqo "$prog")" >&2
    done
}

# Autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##
alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

alias vim='nvim'
alias nv='nvim'
alias v='nvim'
alias r='ranger'
alias sudo='sudo '
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lg='lazygit'
alias um='sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist --protocol https --download-timeout 15'
# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=_Pacdiff
################################################################################

# Rust enviroment entry
. "$HOME/.cargo/env"

# Raner env entry
RANGER_LOAD_DEFAULT_RC="FALSE"

export EDITOR='nvim'
export VISUAL='nvim'

# Vim mode
set -o vi

# Disable ctrl-s pause
stty -ixon

