if status is-interactive
    # Aliases
    alias ls="eza --icons"
    alias ll="eza -la --icons --group-directories-first"

    # Abbreviations
    abbr -a v "nvim"
    
    # Git
    abbr -a g "git"
    abbr -a ga "git add"
    abbr -a gc "git commit"
    abbr -a gp "git push"
    abbr -a gs "git status"
    abbr -a gb "git branch"
    abbr -a gpl "git pull"
    abbr -a gfk "git commit --amend --no-edit"
    abbr -a gco "git checkout"
    abbr -a glo "git log --oneline"
    abbr -a grs "git restore --staged"
    abbr -a grh "git reset --hard"
    abbr -a grb "git rebase"
    abbr -a grbs "git rebase -i --autosquash --root"
    abbr -a grbc "git rebase --continue"

    # Systemd
    abbr -a ss "systemctl status"
    abbr -a sr "sudo systemctl restart"
end
