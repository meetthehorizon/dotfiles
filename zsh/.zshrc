# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/conart/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
setopt AUTO_CD

# cuda setup
source /etc/profile

# antidote setup
source /usr/share/zsh-antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# starship prompt init
eval "$(starship init zsh)"
# starship prompt
# antidote bundle spaceship-prompt/spaceship-prompt

cat ~/.cache/wal/sequences &
. "$HOME/.cargo/env"

# environment variables
export PATH="$HOME/.local/bin:$PATH"

# aliases
alias vim="nvim"
alias clear="clear;fastfetch;"
alias vizsh="vim ~/.zshrc;source ~/.zshrc"
alias za="zathura"

# yazi change cwd when exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# environment variables
export PATH=$PATH:/home/conart/.spicetify

# commands to run on shell init
clear

