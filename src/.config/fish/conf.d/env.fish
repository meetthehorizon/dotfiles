# Add local bin to path
fish_add_path $HOME/.local/bin

# direct ssh-agent to keyring
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/keyring/ssh"
