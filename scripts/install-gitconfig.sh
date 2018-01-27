#!/bin/sh

backup() {
    for f in "$@"
    do
        if [ -e "$f" ]; then
            log "Copy: \"$f\" -> \"${f}.bak\""
            cp -a "$f" "${f}.bak"
        fi
    done
}

install() {
    log "Install"

    # [core]
    git config --global core.autoCRLF           false
    git config --global core.editor             vi
    git config --global core.excludesfile       ~/.gitignore_global

    # [merge]
    git config --global merge.tool              vimdiff

    # [url."https://"]
    git config --global url."https://".insteadOf        git://
}

log() {
    echo "($0)" "$@"
}

backup ~/.gitconfig
install
