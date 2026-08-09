#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias grepc='grep --color=always -e "^" -e'
alias greprn='grep -rn'

alias feh='feh --geometry 1100x700'
alias fehe='feh --edit'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias lah='ls -lah'

alias ff='fastfetch'
alias fsi='dotnet fsi'
alias fsx='fsi'

alias gc='gitcheck'
alias gs='git status'

alias yz='yazi'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias clean-kernels='sudo vkpurge rm all'
alias killall='pkill -9'
alias le='ls -1'
alias lea='ls -1a'

export EDITOR=hx

# Source functions
for f in ~/dotfiles/helpers/*.sh; do
    [ -f "$f" ] && . "$f"
done
unset f

# Set Path
PATH="$HOME/.local/share/lspctl/bin:$HOME/programs:$HOME/go/bin:$HOME/.cache/.bun/bin:$HOME/.bun/bin:$HOME/.dotnet/tools:$PATH"
. "$HOME/.cargo/env"

# Define prompt.
# folder $
# Example: ~ $
parse_git_branch() {
    local branch dirty="" sync=""

    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ -z "$branch" ] && return

    local ahead behind

    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)

    [ "$ahead" -gt 0 ] 2>/dev/null && sync="${sync}↑"  # needs push
    [ "$behind" -gt 0 ] 2>/dev/null && sync="${sync}↓" # needs pull

    local staged modified untracked

    staged=$(git diff --cached --name-only | wc -l)
    modified=$(git diff --name-only | wc -l)
    untracked=$(git ls-files --others --exclude-standard | wc -l)

    if [ "$staged" -ne 0 ] || [ "$modified" -ne 0 ] || [ "$untracked" -ne 0 ]; then
        dirty="*"
    fi

    echo " $branch$dirty$sync"
}

PS1='\[\e[1;32m\]\w\[\e[0m\]\[\e[1;31m\]$(parse_git_branch)\[\e[0m\] \$ '
