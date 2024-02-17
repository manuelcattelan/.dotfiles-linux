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

# pf - fuzzy find file and open it with default editor
pf() {
    file="$(fdfind --type f --hidden --exclude .git | fzf)" \
        && ${EDITOR:-nvim} "$file" \
        && history -s "${EDITOR:-nvim} "$file""
}

# pd - fuzzy find dir and `cd` into it
pd() {
    dir="$(fdfind --type d --hidden --exclude .git | fzf)" \
        && cd "$dir" \
        && history -s "cd "$dir""
}

# pdr - fuzzy find parent dir and `cd` into it
pdr() {
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
