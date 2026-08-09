x() {
    cmd="$1"
    shift || true

    case "$cmd" in
        # Core operations
        install|i)                             sudo xbps-install -S "$@" ;;
        install-yes|iy)                        sudo xbps-install -Sy "$@" ;;

        install-nosync|ii)                     sudo xbps-install "$@" ;;
        install-nosync-yes|iiy)                sudo xbps-install -y "$@" ;;

        remove|r)                              sudo xbps-remove -R "$@"; echo "Done. Removing orphans..."; sudo xbps-remove -Ooy ;;
        remove-yes|ry)                         sudo xbps-remove -Ry "$@"; echo "Done. Removing orphans..."; sudo xbps-remove -Ooy ;;

        remove-only|re)                        sudo xbps-remove -R "$@" ;;
        remove-only-yes|rey)                   sudo xbps-remove -R -y "$@" ;;

        search|s|q)                            xbps-query -Rs "$@" ;;
        search-installed|si|qi)                xbps-query -l | grep -i "$@" | sed "s/ii //g" ;;
        search-installed-manually|sim|qim)     xbps-query -m ;;

        info)                                  xbps-query -R "$@" ;;

        update|up)                             sudo xbps-install -S ;;
        upgrade|u)                             sudo xbps-install -Su ;;
        upgrade-yes|uy)                        sudo xbps-install -Suy ;;

        upgrade-xbps|ux)                       sudo xbps-install -u xbps ;;
        upgrade-xbps-yes|uxy)                  sudo xbps-install -uy xbps ;;

        full-upgrade|fu)                       sudo xbps-install -uy xbps; sudo xbps-install -Suv ;;
        full-upgrade-yes|fuy)                  sudo xbps-install -uy xbps; sudo xbps-install -Suvy ;;

        reconfigure|rec)                       sudo xbps-reconfigure -f "$@" ;;
        reconfigure-all|reca)                  sudo xbps-reconfigure -fa "$@" ;;

        # Orphans
        orphans|o)                             xbps-query -O ;;
        remove-orphans|ro)                     sudo xbps-remove -Oo ;;
        remove-orphans-yes|roy)                sudo xbps-remove -Ooy ;;

        # Conversion
        to-automatic|ta|to-deps|td)            sudo xbps-pkgdb -m auto "$@" ;;
        to-manual|tm)                          sudo xbps-pkgdb -m manual "$@" ;;

        # Hold / pin
        hold|h)                                sudo xbps-pkgdb -m hold "$@" ;;
        unhold|uh)                             sudo xbps-pkgdb -m unhold "$@" ;;
        held|lh)                               xbps-query -H ;;

        # Version check
        version|v|ver)                         xbps-query -p pkgver "$@" ;;

        # Dependency tools
        deps|d)                                xbps-query -x "$@" ;;
        rdeps|rd)                              xbps-query -R -X "$@" ;;

        # File ownership
        files|fl)                              xbps-query -f "$@" ;;
        owns|f)                                xbps-query -o "$@" ;;

        # Repo management
        rep-list|rl)                           xbps-query -L ;;

        rep-add|ra)
            if [ -z "$1" ]; then
                echo "Usage: x rep-add <repo-url>"
                return 1
            fi

            conf="/etc/xbps.d/99-custom-$(echo "$1" | md5sum | cut -c1-8).conf"
            echo "repository=$1" | sudo tee "$conf" > /dev/null
            echo "Added repo to $conf"
            sudo xbps-install -S
            ;;

        rep-remove|rr)
            if [ -z "$1" ]; then
                echo "Usage: x rep-remove <repo-url-or-substring>"
                return 1
            fi

            matches=$(sudo grep -rl "$1" /etc/xbps.d/ 2>/dev/null)
            if [ -z "$matches" ]; then
                echo "No repo config found matching: $1"
                return 1
            fi

            echo "$matches" | xargs -r sudo rm -v
            ;;

        # Updates
        outdated|od)                           xbps-install -nu | awk '/update/' ;;

        # Help
        *)
            cat <<EOF
Usage: x <command> [arguments]

Install packages:
  i, install <pkg>                        Install packages with repo sync
  iy, install-yes <pkg>                   Install packages with repo sync (auto-yes)

  ii, install-nosync <pkg>                Install packages without repo sync
  iiy, install-nosync-yes <pkg>           Install packages without repo sync (auto-yes)

Remove:
  r, remove <pkg>                         Remove packages and clear orphans
  ry, remove-yes <pkg>                    Remove packages and clear orphans (auto-yes)

  re, remove-only <pkg>                   Remove packages and don't clear orphans
  rey, remove-only-yes <pkg>              Remove packages and don't clear orphans (auto-yes)

Search & info:
  s, q, search <name>                     Search repo packages
  si, qi, search-installed                Search among installed packages
  sim, qim, search-installed-manually     Search among manually installed packages

  info <pkg>                              Show package info

Update & upgrade:
  up, update                              Update repo index

  u, upgrade                              Upgrade system
  uy, upgrade-yes                         Upgrade system (auto-yes)

  ux, upgrade-xbps                        Upgrade xbps
  uxy, upgrade-xbps-yes                   Upgrade xbps (auto-yes)

  fu, full-upgrade                        Update + upgrade + verbose
  fuy, full-upgrade-yes                   Update + upgrade + verbose (auto-yes)

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

Hold / pin:
  h, hold <pkg>                           Pin package(s) at current version
  uh, unhold <pkg>                        Unpin package(s)
  lh, held                                List held/pinned packages

Version:
  v, ver <pkg>                            Show installed version of package

Dependencies:
  d, deps <pkg>                           Show dependencies
  rd, rdeps <pkg>                         Show reverse dependencies

File ownership:
  f, owns <file>                          Which package owns this file?
  fl, files <pkg>                         List files of a package

Repository management:
  rl, rep-list                            List repositories
  ra, rep-add <url>                       Add repository (writes to /etc/xbps.d/)
  rr, rep-remove <url|substring>          Remove repository config matching pattern

Updates:
  od, outdated                            Show outdated packages (that needs to be updated)
EOF
            ;;
    esac
}
