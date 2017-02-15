#!/bin/bash
#
# Beautiful powerline-style prompt written in pure bash, simple and very fast.
# 
# Author  : Yury Plashenkov
# Website : https://yuryplashenkov.com/projects/powerline
# Github  : https://github.com/plashenkov/powerline 
# License : MIT License

__ps1() {
  # Colors:
  # http://misc.flogisoft.com/bash/tip_colors_and_formatting
  local user_bg_color=31
  local user_text_color=231
  local user_bold=true
  local path_bg_color=240
  local path_text_color=252
  local path_separator_color=245
  local path_bold=false
  
  if [ "$user_bold" = true ]; then user_bold="1;"; else user_bold=""; fi
  if [ "$path_bold" = true ]; then path_bold="1;"; else path_bold=""; fi

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
    path=${path//\//"\[\e[0;38;5;${path_separator_color};48;5;${path_bg_color}m\]  \[\e[${path_bold}38;5;${path_text_color}m\]"}
  fi

  PS1="\[\e[${user_bold}48;5;${user_bg_color};38;5;${user_text_color}m\] \u \[\e[0;38;5;${user_bg_color};48;5;${path_bg_color}m\]\[\e[${path_bold}48;5;${path_bg_color};38;5;${path_text_color}m\] $path \[\e[0;38;5;${path_bg_color}m\]\[\e[0m\] "
}

# Skip Midnight Commander
if ! ps $PPID | grep -q mc; then
  PROMPT_COMMAND=__ps1
fi
