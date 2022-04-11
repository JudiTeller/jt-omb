#!/usr/bin/env bash

_time() {
  THEME_CLOCK_FORMAT="%H:%M"
  clock_prompt
}

__clock() {
  local LIGHT_BLUE="\[\033[1;34m\]"
  if [[ "${THEME_SHOW_CLOCK}" = "true" ]]; then
    echo "$(_time)${NO_COLOR}"
  fi
}

prompt_setter() {

#   Named "Tonka" because of the colour scheme
local RESET="\[\033[0m\]"
local WHITE="\[\033[1;97m\]"
local LIGHT_GREY="\[\033[1;38;5;252m\]"
local BLACK="\[\033[30m\]"
local LIGHT_BLUE="\[\033[1;34m\]"
local YELLOW="\[\033[1;33m\]"
local NO_COLOR="\[\033[0m\]"
local NO_COLOR_BG="\[\033[49m\]"
local PURPLE="\[\033[0;35m\]"
local CYAN="\[\033[0;36m\]"
local MAGENTA_L="\[\033[1;38;5;201m\]"
local PURPLE_FG="\[\033[1;38;5;56m\]"
local PURPLE_BG="\[\033[48;5;56m\]"
local BLUE_FG="\[\033[38;5;17m\]"
local BLUE_BG="\[\033[48;5;17m\]"
local ORANGE_FG="\[\033[38;5;130m\]"
local ORANGE_BG="\[\033[48;5;130m\]"
local INFO_COLOR="\[\033[38;5;85m\]"
local GRADIENT_1="\[\033[38;5;92m\]"
local GRADIENT_2="\[\033[38;5;129m\]"
local GRADIENT_3="\[\033[38;5;165m\]"


local BAR_START=""
local BAR_CONNECT=""



case $TERM in
    xterm*|rxvt*)
        TITLEBAR='\[\033]0;\u@\h: \w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac


PS1="\n\n$TITLEBAR"
PS1+="$GRADIENT_1╭$PURPLE_FG─"
PS1+="$PURPLE_FG$BAR_START"
PS1+="$PURPLE_BG$LIGHT_GREY \u@\h"
PS1+="$PURPLE_FG$BLUE_BG$BAR_CONNECT "
PS1+="$LIGHT_GREY\w "
PS1+="$BLUE_FG$ORANGE_BG$BAR_CONNECT "
PS1+="$INFO_COLOR"
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type d | wc -l) " # print number of folders
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type f | wc -l) " # print number of files
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type l | wc -l) " # print number of symlinks
PS1+="$ORANGE_FG"

parse_git_bg() {
  [[ $(git status -s 2> /dev/null) ]] && echo -e "\e[48;5;73m" || echo -e "\e[48;5;70m"
}
parse_git_fg() {
  [[ $(git status -s 2> /dev/null) ]] && echo -e "\e[38;5;73m" || echo -e "\e[38;5;70m"
}
PS1+="\$(git branch 2> /dev/null | grep '^*' | colrm 1 2 | xargs -I BRANCH echo -n \"" # check if git branch exists
PS1+="\$(parse_git_bg)$BAR_CONNECT " # end FILES container / begin BRANCH container
PS1+="$BLACK BRANCH"  # print current git branch
PS1+="$RESET\$(parse_git_fg)\")$NO_COLOR_BG$BAR_CONNECT\n" # end last container (either FILES or BRANCH)

PS1+="$GRADIENT_2│"
PS1+="$NO_COLOR  $LIGHT_BLUE("
PS1+="$(__clock)"
PS1+="$LIGHT_BLUE)\n$GRADIENT_2╰$GRADIENT_2─$GRADIENT_3─$GRADIENT_3─"
PS1+="$MAGENTA_L>_$NO_COLOR "

PS2="$LIGHT_BLUE>$WHITE>>$NO_COLOR   "

}

safe_append_prompt_command prompt_setter

THEME_SHOW_CLOCK=${THEME_SHOW_CLOCK:-"true"}
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"\[\033[1;34m\]"}

export PS3=">> "

LS_COLORS='no=00:fi=00:di=38;5;33:ln=01;36:pi=40;34:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:*.log=38;5;41:*.php=38;5;99:';

export LS_COLORS
