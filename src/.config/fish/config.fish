set -g fish_greeting

if status is-interactive
    fastfetch
    starship init fish | source
    zoxide init fish | source
end
