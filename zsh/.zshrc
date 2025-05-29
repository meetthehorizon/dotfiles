# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/conart/.zshrc'

setopt autocd
autoload -Uz compinit
compinit

alias vim=nvim
alias cat=bat
alias clear="clear;neofetch;"
alias vizsh="vim ~/.zshrc"

source /usr/share/zsh-antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

eval "$(starship init zsh)"

clear
