#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cgrep='grep --color=always -e "^" -e'

alias ll='ls -la'
alias ff='fastfetch'
alias fsi='dotnet fsi'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'

# git add, commit, push
gacp() {
    if [ $# -eq 0 ]; then
        echo "Usage: gacp <commit message>"
        return 1
    fi

    if git diff --quiet && git diff --cached --quiet; then
        echo "No changes to commit."
        return 0
    fi

    branch=$(git rev-parse --abbrev-ref HEAD)

    git add .
    git commit -m "$*"
    git push -u origin "$branch"
}

# (user) folder $

PATH=$PATH:~/go/bin/

# Disable Ctrl-Z binding
stty susp undef

# To return it:
# stty susp ^Z

# Example:
# (antonio) ~ $
PS1='\[\e[1;36m\](\u)\[\e[0m\] \[\e[1;32m\]\w\[\e[0m\] \$ '
