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
set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
set -U fish_user_paths $HOME/.ghcup/bin $fish_user_paths
set -x QML2_IMPORT_PATH /usr/local/lib/qt6/qml $QML2_IMPORT_PATH

# ssh agent
set -q SSH_AGENT_FILE; or set SSH_AGENT_FILE ~/.ssh/agent.env

# Start ssh-agent if needed
if not test -f $SSH_AGENT_FILE
    ssh-agent -c > $SSH_AGENT_FILE
    ssh-add ~/.ssh/id_ed25519
end

# Load the ssh-agent env
source $SSH_AGENT_FILE ^/dev/null

if status is-interactive
    # alias
    alias vim nvim
    alias ls "exa --color=always --git --icons "
    alias ll "exa -lh --git --icons"    
    alias viz 'vim ~/.config/fish/config.fish'
    alias clr 'clear; fastfetch'
    alias evim 'NVIM_APPNAME=nvim-exp nvim'

    starship init fish | source
    
    zoxide init fish | source
    starship init fish | source
    if test "$TERM_PROGRAM" != "vscode"
        clr
    else
        clear
    end
end
