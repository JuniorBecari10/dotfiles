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
