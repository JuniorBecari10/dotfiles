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
