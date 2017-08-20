# Aliases:
alias ..='cd ..'
alias emacs='emacs -nw'
alias sc='screen'


# Environments:
PS1='${debian_chroot:+($debian_chroot)}\u@\h [\w]:\n$ '

if [ 1 -eq $SHLVL ]; then
  # Environments:
  if [ -e "${HOME}/bin" ]; then
    PATH="${HOME}/bin:$PATH"
  fi

  if [ -e "${HOME}/.nodebrew" ]; then
    PATH="$PATH:${HOME}/.nodebrew/current/bin"
  fi
fi


# Pretty functions:
cgrep() {
  find . -regex ".*\.\(c\|cc\|h\|cpp\|hpp\|cxx\|hxx\)" -print0 | xargs -0 grep --color=auto -Hine "$@"
}

jgrep() {
  find . -name "*.java" -print0 | xargs -0 grep --color=auto -Hine "$@"
}

date_string() {
  date '+%Y%m%d_%H%M%S'
}


# fzf (pick up just I needed):
which fzf > /dev/null 2>&1
if [ 0 -eq $? -a ! -e "${HOME}/.fzf" ]; then
  __fzf_cd__() {
    local cmd dir
    cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | cut -b3-"}"
    dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" fzf +m) && printf 'cd %q' "$dir"
  }

  __fzf_history__() (
    local line
    shopt -u nocaseglob nocasematch
    line=$(HISTTIMEFORMAT= history | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" fzf | command grep '^ *[0-9]') &&
      if [[ $- =~ H ]]; then
        sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
      else
        sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
      fi
  )

  # Required to refresh the prompt after fzf
  bind '"\er": redraw-current-line'
  bind '"\e^": history-expand-line'

  # ALT-C - cd into the selected directory
  bind '"\ec": " \C-e\C-u`__fzf_cd__`\e\C-e\er\C-m"'

  # CTRL-R - Paste the selected command from history into the command line
  bind '"\C-r": " \C-e\C-u`__fzf_history__`\e\C-e\e^\er"'
fi


# extra init
if [ -e "${HOME}/.bash_env" ]; then
  . "${HOME}/.bash_env"
fi
