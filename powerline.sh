#!/bin/bash

__ps1() {
    # Color codes:
    # http://misc.flogisoft.com/bash/tip_colors_and_formatting

    local path=$PWD

    if [ "$path" != "/" ]
    then
        # Replace home directory with ~
        path=${path/#$HOME/\~}

        # Strip leading and trailing slashes
        path=${path#/}
        path=${path%/}

        # Strip too long path
        IFS="/" read -ra dirs <<< "$path"
        local dirCount=${#dirs[@]}

        if [ $dirCount -gt 4 ]
        then
            path=".../${dirs[$dirCount-3]}/${dirs[$dirCount-2]}/${dirs[$dirCount-1]}"
        fi

        # Replace path separator (/) with powerline separator symbol
        path=${path//\//"\[\e[90m\]  \[\e[30m\]"}
    fi

    PS1="\[\e[44;37m\] \u \[\e[47;34m\]\[\e[47;30m\] $path \[\e[49;37m\]\[\e[0m\] "
}

PROMPT_COMMAND=__ps1
