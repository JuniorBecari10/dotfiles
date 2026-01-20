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

alias yz='yazi'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

export EDITOR=hx

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
        # Core operations
        install|i)                             sudo xbps-install -S "$@" ;;
        install-yes|iy)                        sudo xbps-install -Sy "$@" ;;

        install-nosync|ii)                     sudo xbps-install "$@" ;;
        install-nosync-yes|iiy)                sudo xbps-install -y "$@" ;;

        remove|r)                              sudo xbps-remove "$@"; echo "Done. Removing orphans..."; sudo xbps-remove -Ooy ;;
        remove-yes|ry)                         sudo xbps-remove -y "$@"; echo "Done. Removing orphans..."; sudo xbps-remove -Ooy ;;

        remove-only|rr)                        sudo xbps-remove "$@" ;;
        remove-only-yes|rry)                   sudo xbps-remove -y "$@" ;;

        search|s|q)                            xbps-query -Rs "$@" ;;
        search-installed|si|qi)                xbps-query -l | grep -i "$@" | sed "s/ii //g" ;;
        search-installed-manually|sim|qim)     xbps-query -m ;;

        info)                                  xbps-query -R "$@" ;;

        update|up)                             sudo xbps-install -S ;;
        upgrade|u)                             sudo xbps-install -Su ;;
        upgrade-yes|uy)                        sudo xbps-install -Suy ;;

        full-upgrade|fu)                       sudo xbps-install -Suv ;;
        full-upgrade-yes|fuy)                  sudo xbps-install -Suvy ;;

        reconfigure|rec)                       sudo xbps-reconfigure -f "$@" ;;
        reconfigure-all|reca)                  sudo xbps-reconfigure -fa "$@" ;;

        # Orphans
        orphans|o)                             xbps-query -O ;;
        remove-orphans|ro)                     sudo xbps-remove -Oo ;;
        remove-orphans-yes|roy)                sudo xbps-remove -Ooy ;;

        # Conversion
        to-automatic|ta|to-deps|td)            sudo xbps-pkgdb -m auto "$@" ;;
        to-manual|tm)                          sudo xbps-pkgdb -m manual "$@" ;;

        # Dependency tools
        deps|d)                                xbps-query -x "$@" ;;
        rdeps|rd)                              xbps-query -R -X "$@" ;;

        # File ownership
        files|fl)                              xbps-query -f "$@" ;;

        # Repo management
        rep-list|rl)                           xbps-query -L ;;
        rep-add|ra)                            sudo xbps-query -A "$@" ;;
        rep-remove|rr)                         sudo xbps-query -Rr "$@" ;;

        # Updates
        outdated|od)                           xbps-install -nu | awk '/update/' ;;

        # Help
        *)
            cat <<EOF
Usage: x <command> [arguments]

Install packages:
  i, install <pkg>                Install packages with repo sync
  iy, install-yes <pkg>           Install packages with repo sync (auto-yes)
  
  ii, install-nosync <pkg>        Install packages without repo sync
  iiy, install-nosync-yes <pkg>   Install packages without repo sync (auto-yes)

Remove:
  r, remove <pkg>                 Remove packages and clear orphans
  ry, remove-yes <pkg>            Remove packages and clear orphans (auto-yes)
  
  rr, remove <pkg>                Remove packages and don't clear orphans
  rry, remove-yes <pkg>           Remove packages and don't clear orphans (auto-yes)

Update & upgrade:
  up, update                              Update repo index
  
  u, upgrade                              Upgrade system
  uy, upgrade-yes                         Upgrade system (auto-yes)

  fu, full-upgrade                        Update + upgrade + verbose
  fuy, full-upgrade-yes                   Update + upgrade + verbose (auto-yes)

Search & info:
  s, q, search <name>                     Search repo packages
  si, qi, search-installed                Search among installed packages
  sie, qie, search-installed-explicitly   Search among explicitly installed packages
  
  info <pkg>                              Show package info

Reconfigure:
  rec, reconfigure <pkg>                  Reconfigure a package
  reca, reconfigure-all <pkg>             Reconfigure all packages (and rebuild initramfs)

Orphans:
  o, orphans                              List orphaned packages
  ro, remove-orphans                      Remove orphaned packages
  roy, remove-orphans-yes                 Remove orphaned packages (auto-yes)

Conversion:
  ta, to-automatic, td, to-deps           Mark packages as dependencies (automatically installed)
  tm, to-manual                           Mark packages as manually installed

Dependencies:
  d, deps <pkg>                           Show dependencies
  rd, rdeps <pkg>                         Show reverse dependencies

File ownership:
  f, owns <file>                          Which package owns this file?
  fl, files <pkg>                         List files of a package

Repository management:
  rl, rep-list                            List repositories
  ra, rep-add <repo>                      Add repository
  rr, rep-remove <repo>                   Remove repository

Updates:
  od, outdated                            Show outdated packages (that needs to be updated)
EOF
            ;;
    esac
}

svc() {
    action="$1"
    shift || true
    svc="$1"

    case "$action" in
        # Enable / Disable services
        enable)
            [ -z "$svc" ] && echo "Usage: svc enable <service>" && return 1
            [ ! -d "/etc/sv/$svc" ] && echo "Service '$svc' not found in /etc/sv/" && return 1

            sudo ln -sf "/etc/sv/$svc" /var/service/
            echo "Enabled: $svc"
            ;;

        disable)
            [ -z "$svc" ] && echo "Usage: svc disable <service>" && return 1
            if [ -L "/var/service/$svc" ]; then
                sudo rm "/var/service/$svc"
                echo "Disabled: $svc"
            else
                echo "Service '$svc' was not enabled."
            fi
            ;;

        # Basic runit controls
        start|stop|restart|status)
            [ -z "$svc" ] && echo "Usage: svc $action <service>" && return 1
            sudo /usr/bin/sv "$action" "$svc"
            ;;

        # Advanced runit / signal controls
        once|pause|cont|reload|hup|term|kill)
            [ -z "$svc" ] && echo "Usage: svc $action <service>" && return 1
            sudo /usr/bin/sv "$action" "$svc"
            ;;

        # Logs (actual log viewing)
        log)
            [ -z "$svc" ] && echo "Usage: svc log <service>" && return 1
            logdir="/var/log/sv/$svc/current"
            [ ! -f "$logdir" ] && echo "No logs found for '$svc'" && return 1
            sudo tail -f "$logdir"
            ;;

        # Listing helpers
        list)
            sudo /usr/bin/sv status /var/service/*
            ;;

        avail|list-available)
            ls -1 /etc/sv/
            ;;

        # Edit service run script
        edit)
            [ -z "$svc" ] && echo "Usage: svc edit <service>" && return 1
            run="/etc/sv/$svc/run"
            [ ! -f "$run" ] && echo "Service '$svc' has no run script" && return 1
            sudo ${EDITOR:-vim} "$run"
            ;;

        # Help
        *)
            cat <<EOF
Usage: svc <command> [service]

Enable / Disable:
  svc enable <svc>      Enable service
  svc disable <svc>     Disable service

Basic Control:
  svc start <svc>       Start service
  svc stop <svc>        Stop service
  svc restart <svc>     Restart service
  svc status <svc>      Show service status

Advanced:
  svc once <svc>        Start once, no respawn
  svc pause <svc>       Pause service
  svc cont <svc>        Resume after pause
  svc reload <svc>      Reload configuration (if supported)
  svc hup <svc>         Send HUP signal
  svc term <svc>        Send TERM signal
  svc kill <svc>        Kill service

Logs:
  svc log <svc>         Follow service logs

Listing:
  svc list              Show status of enabled services
  svc avail             List available service definitions

Editing:
  svc edit <svc>        Edit the service run script (\$EDITOR)
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

    if git rev-parse --verify HEAD >/dev/null 2>&1 \
       && git diff --quiet \
       && git diff --cached --quiet; then
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

    if git rev-parse --verify HEAD >/dev/null 2>&1 \
       && git diff --quiet \
       && git diff --cached --quiet; then
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

# Path
PATH="$HOME/programs:$HOME/go/bin:$HOME/.cache/.bun/bin:$HOME/.bun/bin:$HOME/.dotnet/tools:$PATH"

# ----------------------------

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
