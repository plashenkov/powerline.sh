#!/bin/bash
#
# Beautiful powerline-style prompt written in pure bash, simple and very fast.
#
# Author  : Yuri Plashenkov
# Github  : https://github.com/plashenkov/powerline.sh
# License : MIT License

__ps1() {
  # Colors (see "88/256 Colors" section):
  # http://misc.flogisoft.com/bash/tip_colors_and_formatting#colors1
  local host="\u@\h"
  local host_bg_color=31
  local host_text_color=231
  local host_bold=true
  local path_bg_color=240
  local path_text_color=252
  local path_separator_color=245
  local path_bold=false
  local mc_marker="mc"
  local mc_bg_color=237
  local mc_text_color=231
  local mc_bold=true

  if [ "$host_bold" = true ]; then host_bold="1;"; else host_bold=""; fi
  if [ "$path_bold" = true ]; then path_bold="1;"; else path_bold=""; fi
  if [ "$mc_bold" = true ]; then mc_bold="1;"; else mc_bold=""; fi

  local path=$PWD
  if [ "$path" != "/" ]; then
    # Replace home directory with ~
    path=${path/#$HOME/\~}

    # Trim leading and trailing slashes
    path=${path#/}
    path=${path%/}

    # Compact too long path
    IFS="/" read -ra dirs <<< "$path"
    local dir_count=${#dirs[@]}
    if [ $dir_count -gt 4 ]; then
      path=".../${dirs[$dir_count-3]}/${dirs[$dir_count-2]}/${dirs[$dir_count-1]}"
    fi

    # Replace path separator (/) with powerline separator symbol
    path=${path//\//"\[\e[0;38;5;${path_separator_color};48;5;${path_bg_color}m\]  \[\e[${path_bold}38;5;${path_text_color}m\]"}
  fi

  # Midnight Commander
  local mc="\[\e[0;38;5;${host_bg_color};48;5;${path_bg_color}m\]"
  if [ -n "$MC_SID" ] && [ -n "$mc_marker" ] && [ "$mc_marker" != false ]; then
    mc="\[\e[0;38;5;${host_bg_color};48;5;${mc_bg_color}m\]\[\e[${mc_bold}48;5;${mc_bg_color};38;5;${mc_text_color}m\] ${mc_marker} \[\e[0;38;5;${mc_bg_color};48;5;${path_bg_color}m\]"
  fi

  PS1="\n\[\e[${host_bold}48;5;${host_bg_color};38;5;${host_text_color}m\] ${host} ${mc}\[\e[${path_bold}48;5;${path_bg_color};38;5;${path_text_color}m\] $path \[\e[0;38;5;${path_bg_color}m\]\[\e[0m\] "
}

PROMPT_COMMAND=__ps1
