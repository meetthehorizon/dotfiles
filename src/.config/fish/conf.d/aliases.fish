if status is-interactive
    # Aliases
    abbr -a ls  "eza --icons always"
    abbr -a ll  "eza -la --icons always --group-directories-first"

    # Abbreviations
    abbr -a v "nvim"

    # Git
    abbr -a g   "git"
    abbr -a ga  "git add"
    abbr -a gc  "git commit"
    abbr -a gp  "git push"
    abbr -a gs  "git status"
    abbr -a gb  "git branch"
    abbr -a gr  "git rebase"
    abbr -a gpl "git pull"
    abbr -a gfk "git commit --amend --no-edit"
    abbr -a gco "git checkout"
    abbr -a glo "git log --oneline -n "
    abbr -a grs "git restore --staged"
    abbr -a grh "git reset --hard"
    abbr -a grs "git rebase -i --autosquash --root"
    abbr -a grc "git rebase --continue"

    # CLI Tools
    abbr -a lg  lazygit
end
