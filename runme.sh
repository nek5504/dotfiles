#!/bin/sh

backup() {
  for f in $(ls -a ./dotfiles/)
  do
    if [ "." = "$f" -o ".." = "$f" ]; then
      continue
    fi

    log "Copy: \"${HOME}/$f\" -> \"./dotfiles/$f\""
    cp -a "${HOME}/$f" "./dotfiles/$f"
  done
}

install() {
  for f in $(ls -a ./dotfiles/)
  do
    if [ "." = "$f" -o ".." = "$f" ]; then
      continue
    fi

    log "Copy: \"./dotfiles/$f\" -> \"${HOME}/$f\""
    cp -a "./dotfiles/$f" "${HOME}/$f"
  done
}

help() {
cat << EOF >&2
Usage: $(basename $0) [command]

command:
  -b, --backup      Backup local dotfiles.
  -i, --install	    Install dotfiles.
EOF
}

log() {
    echo "($0)" "$@"
}

set -e

case $1 in
  -b|--backup) backup ;;
  -i|--install) install ;;
  *) help ;;
esac
