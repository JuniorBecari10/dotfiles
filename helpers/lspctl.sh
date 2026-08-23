lspctl() (
    cd ~/dev/lspctl || return
    cargo run -q -- "$@"
)
