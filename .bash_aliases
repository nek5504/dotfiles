if [ 1 -eq $SHLVL ]; then
  alias emacs='emacs -nw'

  if [ -e "${HOME}/bin" ]; then
    PATH="${HOME}/bin:$PATH"
  fi

  if [ -e "${HOME}/.nodebrew" ]; then
    PATH="$PATH:${HOME}/.nodebrew/current/bin"
  fi

  if [ -e "${HOME}/.bash_env" ]; then
    . "${HOME}/.bash_env"
  fi
fi
