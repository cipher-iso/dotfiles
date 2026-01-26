# NEW BASH PROMPT
PS1='\n\[\e[40m\]  \[\e[38;2;0;255;64m\]\[\e[0;40m\]  \[\e[38;2;0;255;64m\][ \[\e[38;2;50;52;73m\]\A\[\e[38;2;33;35;55m\]\[\e[40m\] \[\e[38;2;0;255;64m\]-\[\e[38;2;50;52;73m\] CIPHER\[\e[38;2;0;255;64m\] ]\[\e[40m\] \[\e[38;2;50;52;73m\]>\[\e[40m\] \[\e[38;2;0;255;64m\]\w\[\e[39m\] \[\e[38;2;0;255;64m\]'

# OLD BASH PROMPT
# PS1='\n\[\e[40m\]  \[\e[38;2;0;255;64m\]\[\e[0;40m\]  \[\e[1;38;2;33;35;55m\][\[\e[0;38;2;50;52;73m\]\A\[\e[1;38;2;33;35;55m\]]\[\e[0;40m\] \[\e[1;38;2;0;255;64m\]ᴄɪᴘʜᴇʀ\[\e[0;40m\] \[\e[0;38;2;50;52;73m\]>\[\e[0;40m\] \[\e[1;38;2;33;35;55m\]\w\[\e[39m\] \[\e[0;38;2;0;255;64m\]'

# DECORATIONS & MISCELLANEOUS
export TERMINAL=kitty
export SUDO_PROMPT=$'\e[1;38;2;0;255;64m  > ENTER PASSPHRASE: \e[0m'
export PATH="$HOME/Scripts:$PATH"
export PATH="$HOME/Scripts/ColorGen:$PATH"
BashText

# QoL SHORTCUT ALIAS'
alias :q='exit'
alias :wq='exit'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ff='fastfetch -l none'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias aur='yay -S'
alias aurr='yay -Rns'
alias pak='flatpak install'
alias pakr='flatpak remove'
alias unlock='faillock --reset'
alias dotfiles='git --git-dir=$DOTFILES/ --work-tree=$HOME'	


# BASH SCRIPT ALIAS''
alias cc='ClearSystemCache'
alias update='RunUpdates -arch'
alias runserver='run-server'
alias gif='Convert2Gif'
alias colorgen='~/.config/cipher/GenerateColors.sh'

# ALIAS 'NVIMS' = "nvim ~/Scripts/'xyz'"
nvims() {
    if [ -z "$1" ]; then
        echo "Usage: nvims <filename>"
        return 1
    fi
    nvim "$HOME/Scripts/$1"
}

# Bash completion: only list files in ~/Scripts
_nvims_completions() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    # List only filenames, not full paths
    COMPREPLY=( $(compgen -W "$(ls "$HOME/Scripts")" -- "$cur") )
}
complete -F _nvims_completions nvims

# DUNNO? - DO NOT TOUCH?
[[ $- != *i* ]] && return

