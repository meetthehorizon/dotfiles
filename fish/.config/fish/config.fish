# fish settings
set -U fish_greeting ""
set -U fish_history_max 100000

# yazi
function y
    set tmp (mktemp -t yazi-cwd.XXXXXX)
    yazi $argv --cwd-file=$tmp
    set cwd (cat $tmp)
    if test -n "$cwd" -a "$cwd" != "$PWD"
        cd $cwd
    end
    rm $tmp
end

# env var
set -Ux EDITOR nvim
set -Ux BROWSER firefox
set -Ux VISUAL nvim
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

# ssh agent
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c)
    ssh-add ~/.ssh/id_ed25519
end

if status is-interactive
    # alias
    alias vim nvim
    alias viz 'vim ~/.config/fish/config.fish'
    alias vin 'vim ~/.config/nvim/init.lua'
    alias clr 'clear; fastfetch'
    alias code 'code --reuse-window'
    alias time-btrfs 'xhost +SI:localuser:root && sudo DISPLAY=:1 timeshift-launcher'
    
    zoxide init fish | source
    if test "$TERM_PROGRAM" != "vscode"
        clr
    end
end
