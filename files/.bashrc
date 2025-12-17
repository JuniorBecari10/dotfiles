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

# Clipboard helper functions
xcopy() {
    if [ -t 0 ]; then
        printf "%s" "$*" | xclip -selection clipboard
    else
        xclip -selection clipboard
    fi
}

xpaste() {
    xclip -selection clipboard -o
}

# xbps/X11 helper
# xbps + X11 helper command
x() {
    cmd="$1"
    shift || true

    case "$cmd" in
        # --- Core operations ---
        install|i)            sudo xbps-install -S "$@" ;;
        install-yes|iy)       sudo xbps-install -Sy "$@" ;;
        src)                  sudo xbps-src "$@" ;;
        remove|r)             sudo xbps-remove "$@"; sudo xbps-remove -Ooy ;;
        remove-yes|ry)        sudo xbps-remove -y "$@"; sudo xbps-remove -Ooy ;;
        search|s)             xbps-query -Rs "$@" ;;
        search-installed|si)  xbps-query -l | grep -i "$@" ;;
        info|q)               xbps-query -R "$@" ;;
        update|up)            sudo xbps-install -S ;;
        upgrade|u)            sudo xbps-install -Su ;;
        full-upgrade|fu)      sudo xbps-install -Suv ;;
        reconfigure|rec)      sudo xbps-reconfigure -f "$@" ;;

        # --- Orphans ---
        orphans|o)              xbps-query -O ;;
        remove-orphans|ro)      sudo xbps-remove -Oo ;;
        remove-orphan-yes|roy) sudo xbps-remove -Ooy ;;

        # --- Dependency tools ---
        deps|d)               xbps-query -d "$@" ;;
        rdeps|rd)             xbps-query -R -x "$@" ;;

        # --- File ownership ---
        owns|f)               xbps-query -o "$@" ;;
        files|fl)             xbps-query -f "$@" ;;

        # --- Repo management ---
        replist|rl)           xbps-query -L ;;
        repadd|ra)            sudo xbps-query -A "$@" ;;
        repremove|rr)         sudo xbps-query -Rr "$@" ;;

        # --- Updates ---
        list-updates|lu)      xbps-install -nu 2>/dev/null | grep -v "already installed" ;;
        outdated|od)          xbps-install -nu | awk '/updating/' ;;

        # --- Keyring ---
        sync-keys|sk)         sudo xbps-install -S --sync-keyring ;;

        # --- Build helpers ---
        clean-src|cs)         sudo xbps-src clean ;;
        show-template|st)     xbps-src show "$@" ;;

        # --- Logs ---
        log|lg)               sudo less /var/log/xbps/xbps.log ;;

        # --- Help ---
        *)
            cat <<EOF
Usage: x <command> [arguments]

Install packages:
  i, install <pkg>          Install a package (with repo sync)
  iy, install-yes <pkg>     Install (auto-yes)

Remove:
  r, remove <pkg>           Remove a package
  ry, remove-yes <pkg>      Remove a package (auto-yes)

Update & upgrade:
  up, update                Update repo index
  u, upgrade                Upgrade system
  fu, full-upgrade          Update + upgrade + verbose

Search & info:
  s, search <name>          Search repo packages
  si, search-installed      Search among installed pkgs
  q, info <pkg>             Show package info

Reconfigure:
  rec, reconfigure <pkg>    Reconfigure a package

Orphans:
  o, orphans                List orphaned packages
  ro, remove-orphans        Remove orphaned packages
  roy, remove-orphans-yes   Remove orphaned packages (auto-yes)

Dependencies:
  d, deps <pkg>             Show dependencies
  rd, rdeps <pkg>           Show reverse dependencies

File ownership:
  f, owns <file>            Which package owns this file?
  fl, files <pkg>           List files of a package

Repository management:
  rl, replist               List repositories
  ra, repadd <repo>         Add repository
  rr, repremove <repo>      Remove repository

Updates:
  lu, list-updates          List packages that can update
  od, outdated              Show outdated packages

Keyring:
  sk, sync-keys             Sync keyring with repos

Build helpers:
  cs, clean-src             Clean xbps-src build files
  st, show-template <pkg>   Show template for a source pkg

Logs:
  lg, log                   View XBPS log

EOF
            ;;
    esac
}


sv() {
    action="$1"
    shift || true
    svc="$1"

    case "$action" in
        # --- Enable / Disable services ---
        enable)
            [ -z "$svc" ] && echo "Usage: sv enable <service>" && return 1
            [ ! -d "/etc/sv/$svc" ] && echo "Service '$svc' not found in /etc/sv/" && return 1
            
            sudo ln -sf "/etc/sv/$svc" /var/service/
            echo "Enabled: $svc"
            ;;

        disable)
            [ -z "$svc" ] && echo "Usage: sv disable <service>" && return 1
            if [ -L "/var/service/$svc" ]; then
                sudo rm "/var/service/$svc"
                echo "Disabled: $svc"
            else
                echo "Service '$svc' was not enabled."
            fi
            ;;

        # --- Standard runit controls ---
        start|stop|restart|status|log)
            [ -z "$svc" ] && echo "Usage: sv $action <service>" && return 1
            sudo sv "$action" "$svc"
            ;;

        # --- Advanced runit controls ---
        once|pause|cont|reload|hup|term|kill)
            [ -z "$svc" ] && echo "Usage: sv $action <service>" && return 1
            sudo sv "$action" "$svc"
            ;;

        # --- Listing helpers ---
        list)
            echo "Enabled services (in /var/service):"
            ls -1 /var/service/
            ;;

        avail|list-available)
            echo "Available services (in /etc/sv):"
            ls -1 /etc/sv/
            ;;

        # --- Edit service run script ---
        edit)
            [ -z "$svc" ] && echo "Usage: sv edit <service>" && return 1
            [ ! -f "/etc/sv/$svc/run" ] && echo "Service '$svc' has no run script" && return 1
            ${EDITOR:-vim} "/etc/sv/$svc/run"
            ;;

        # --- Help ---
        *)
            cat <<EOF
Usage: sv <command> [service]

Enable / Disable:
  sv enable <svc>      Enable service
  sv disable <svc>     Disable service

Basic Control:
  sv start <svc>       Start service
  sv stop <svc>        Stop service
  sv restart <svc>     Restart service
  sv status <svc>      Show service status
  sv log <svc>         View logs

Advanced:
  sv once <svc>        Start once, no respawn
  sv pause <svc>       Pause service
  sv cont <svc>        Resume after pause
  sv reload <svc>      Reload configuration
  sv hup <svc>         Send HUP signal
  sv term <svc>        Send TERM signal
  sv kill <svc>        Kill service

Listing:
  sv list              List enabled services
  sv avail             List available service definitions

Editing:
  sv edit <svc>        Edit the service run script (\$EDITOR)
EOF
            ;;
    esac
}

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
