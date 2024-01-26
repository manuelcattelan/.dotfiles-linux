#!/usr/bin/env bash
# ~/.bash_functions: collection of bash functions sourced from ~/.bashrc.

# automatically execute `ll` after `cd`
cd() {
    if [ -n "$1" ]; then
        builtin cd "$@" && ll
    else
        builtin cd ~ && ll
    fi
}

# ff - fuzzy find file and open it with default editor
ff() {
    file="$(fdfind --type f --hidden --exclude .git | fzf)" \
        && ${EDITOR:-nvim} "$file" \
        && history -s "${EDITOR:-nvim} "$file""
}

# fd - fuzzy find dir and `cd` into it
fd() {
    dir="$(fdfind --type d --hidden --exclude .git | fzf)" \
        && cd "$dir" \
        && history -s "cd "$dir""
}

# fdr - fuzzy find parent dir and `cd` into it
fdr() {
    local dirs=()
    find_parent_dirs() {
        if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
        if [[ "${1}" == '/' ]]; then
            for _dir in "${dirs[@]}"; do echo $_dir; done
        else
            find_parent_dirs $(dirname "$1")
        fi
    }
    dir=$(find_parent_dirs $(realpath "${1:-$PWD}") | fzf) \
        && cd "$dir" \
        && history -s "cd "$dir""
}
