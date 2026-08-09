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

    git add .

    if git rev-parse --verify HEAD >/dev/null 2>&1 \
       && git diff --quiet \
       && git diff --cached --quiet; then
        echo "No changes to commit."
        return 0
    fi

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

    git add .

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

clone() {
    local bare=false
    local branch=""
    local args=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b|--bare)
                bare=true
                shift
                ;;
            -B|--branch)
                if [[ -z "$2" ]]; then
                    echo "Error: --branch requires an argument" >&2
                    return 1
                fi
                branch="$2"
                shift 2
                ;;
            -*)
                echo "Unknown option: $1" >&2
                return 1
                ;;
            *)
                args+=("$1")
                shift
                ;;
        esac
    done

    if [[ ${#args[@]} -eq 1 ]]; then
        user="JuniorBecari10"
        repo="${args[0]}"
    elif [[ ${#args[@]} -eq 2 ]]; then
        user="${args[0]}"
        repo="${args[1]}"
    else
        echo "Usage: clone [-b|--bare] [-B|--branch <branch>] <repo>" >&2
        echo "       clone [-b|--bare] [-B|--branch <branch>] <user> <repo>" >&2
        return 1
    fi

    local cmd=(git clone)
    "$bare" && cmd+=(--bare)
    [[ -n "$branch" ]] && cmd+=(--branch "$branch")
    cmd+=("https://github.com/$user/$repo.git")

    "${cmd[@]}"
}

gitcheck() {
    local do_fetch=1
    if [ "$1" = "--no-fetch" ] || [ "$1" = "-n" ]; then
        do_fetch=0
    fi

    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo "Not a git repository."
        return 1
    fi

    local branch upstream
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

    echo "Branch: $branch"

    if [ -z "$upstream" ]; then
        echo "No upstream branch set."
    else
        echo "Upstream: $upstream"

        if [ "$do_fetch" -eq 1 ]; then
            if git fetch --quiet 2>/dev/null; then
                echo "(fetched latest from remote)"
            else
                echo "(fetch failed — showing possibly stale info)"
            fi
        else
            echo "(skipped fetch — info may be stale)"
        fi

        echo ""

        local ahead behind
        ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
        behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)

        if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
            echo "⚠ Diverged: $ahead commit(s) to push, $behind to pull"
        elif [ "$ahead" -gt 0 ]; then
            echo "↑ $ahead commit(s) ahead — push needed"
        elif [ "$behind" -gt 0 ]; then
            echo "↓ $behind commit(s) behind — pull needed"
        else
            echo "✓ Up to date with upstream"
        fi
    fi

    local staged modified untracked
    staged=$(git diff --cached --name-only | wc -l)
    modified=$(git diff --name-only | wc -l)
    untracked=$(git ls-files --others --exclude-standard | wc -l)

    echo ""

    [ "$staged" -gt 0 ] && echo "● $staged file(s) staged"
    [ "$modified" -gt 0 ] && echo "● $modified file(s) modified (unstaged)"
    [ "$untracked" -gt 0 ] && echo "● $untracked untracked file(s)"

    if [ "$staged" -eq 0 ] && [ "$modified" -eq 0 ] && [ "$untracked" -eq 0 ]; then
        echo "✓ Working tree clean"
    fi
}
