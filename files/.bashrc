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
alias nv='nvim'

alias ff='fastfetch'
alias fsi='dotnet fsi'
alias fsx='fsi'

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# xbps aliases

# Install
alias xi='sudo xbps-install'

# Install from source
alias xsrc='sudo xbps-src'

# Remove
alias xr='sudo xbps-remove'

# Search package (repo)
alias xs='xbps-query -Rs'

# Search installed packages
alias xsi='xbps-query -l | grep -i'

# Show package info
alias xq='xbps-query -R'

# Update repo index
alias xup='sudo xbps-install -S'

# Upgrade system
alias xuall='sudo xbps-install -Su'

# Or do both update+upgrade in one
alias xufull='sudo xbps-install -Suv'

# Reconfigure
alias xrec='sudo xbps-reconfigure -f'

# List orphaned packages
alias xo='xbps-query -O'

# Remove orphaned packages
alias xro='sudo xbps-remove -Oo'

# Explain why something is installed
alias xw='xbps-query -x'

# Update xbps itself
alias xix='xbps-install -u xbps'

# git add, commit
gac() {
    # check if inside a git repo
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: not a git repository." >&2
        return 1
    fi
    
    if [ $# -eq 0 ]; then
        echo "Usage: gac <commit message>" >&2
        return 1
    fi

    if git diff --quiet && git diff --cached --quiet; then
        echo "No changes to commit."
        return 0
    fi

    git add .
    git commit -m "$@"
}

# git add, commit, push
# Args:
# -b <branch> - override branch to be pushed to. If not defined it is set to the current branch.
gacp() {
    local branch=""
    local msg=()
    
    # check if inside a git repo
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: not a git repository." >&2
        return 1
    fi
    
    # parse args
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b|--branch)
                shift
                branch="$1"
                ;;
            *)
                msg+=("$1")
                ;;
        esac
        shift
    done

    if [ ${#msg[@]} -eq 0 ]; then
        echo "Usage: gacp [-b branch] <commit message>" >&2
        return 1
    fi

    if git diff --quiet && git diff --cached --quiet; then
        echo "No changes to commit."
        return 0
    fi

    # default branch if not overridden
    if [ -z "$branch" ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
    fi

    git add .
    git commit -m "${msg[@]}"
    git push -u origin "$branch"
}

# mkdir and cd
mkcd() {
    if [ $# -eq 0 ]; then
        echo "Usage: mkcd <directory name>"
        return 1
    fi

    mkdir -p "$@"
    cd "$_"
}

# Copy to clipboard
xcopy() {
    # If text is piped: cb < file or echo "txt" | cb
    if [ -t 0 ]; then
        # No piped input → treat arguments as text
        printf "%s" "$*" | xclip -selection clipboard
    else
        # Piped input
        xclip -selection clipboard
    fi
}

# Paste from clipboard
xpaste() {
    xclip -selection clipboard -o
}

# Enable a runit service
sv-enable() {
    local svc="$1"

    if [ -z "$svc" ]; then
        echo "Usage: sv-enable <service>"
        return 1
    fi

    if [ ! -d "/etc/sv/$svc" ]; then
        echo "Service '$svc' does not exist in /etc/sv/"
        return 1
    fi

    sudo ln -sf "/etc/sv/$svc" /var/service/
    echo "Enabled: $svc"
}

# Disable a runit service
sv-disable() {
    local svc="$1"

    if [ -z "$svc" ]; then
        echo "Usage: sv-disable <service>"
        return 1
    fi

    if [ -L "/var/service/$svc" ]; then
        sudo rm "/var/service/$svc"
        echo "Disabled: $svc"
    else
        echo "Service '$svc' is not enabled."
    fi
}

# ----------------------------

# Disable Ctrl-Z binding
stty susp undef

# To return it:
# stty susp ^Z

# Define prompt.
# folder $
# Example: ~ $

parse_git_branch() {
    # Get current branch, or return nothing if not a repo
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if [ -n "$branch" ]; then
        dirty=""
        
        # Check if there are staged or unstaged changes
        if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
            dirty="*"
        fi
        
        echo " $branch$dirty"
    fi
}

PS1='\[\e[1;32m\]\w\[\e[0m\]\[\e[1;31m\]$(parse_git_branch)\[\e[0m\] \$ '
