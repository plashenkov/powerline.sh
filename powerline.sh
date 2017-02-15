#!/bin/bash
#
# Beautiful powerline-style prompt written in pure bash, simple and very fast.
# 
# © Yury Plashenkov
# License: MIT

__ps1() {
  # Color codes:
  # http://misc.flogisoft.com/bash/tip_colors_and_formatting

  local path=$PWD

  if [ "$path" != "/" ]; then
    # Replace home directory with ~
    path=${path/#$HOME/\~}

    # Strip leading and trailing slashes
    path=${path#/}
    path=${path%/}

    # Strip too long path
    IFS="/" read -ra dirs <<< "$path"
    local dir_count=${#dirs[@]}

    if [ $dir_count -gt 4 ]; then
      path=".../${dirs[$dir_count-3]}/${dirs[$dir_count-2]}/${dirs[$dir_count-1]}"
    fi

    # Replace path separator (/) with powerline separator symbol
    path=${path//\//"\[\e[91m\]  \[\e[30m\]"}
  fi

  PS1="\[\e[44;37m\] \u \[\e[47;34m\]\[\e[47;30m\] $path \[\e[49;37m\]\[\e[0m\] "
}

# Skip Midnight Commander
if ! ps $PPID | grep -q mc; then
  PROMPT_COMMAND=__ps1
fi
