#!/bin/sh
#title           :radioshell.sh
#description     :This script allows to manage and listen online radios in the terminal.
#author          :Tom Celestin
#date            :20190123
#version         :1.0
#usage           :bash radioshell.sh

cmd_list() {
    echo "\n==========[\e[0;32mRADIOS LIST\e[0m]=========="
    echo ""
    while read r;
    do
        echo "* $r"
    done < $RADIOS_LIST | sed 's/ :.*$//' | sed '/#.*$/d' | sort
    echo ""
    echo "================================="
}

get_radio_url_from_name() {
    url=$(grep "$1" "$RADIOS_LIST" | sed 's/^.*: //')
    echo "$url"
}

get_radio_name() {
    line=$1
    echo "$line" | sed 's/ :.*$//'
}

cmd_play() {
    radioname=$1
    echo "\n=================[\e[0;32mSTOP WITH 'q'\e[0m]================="
    echo ""
    mpv $(get_radio_url_from_name $radioname)
    echo ""
    echo ===============================================
}

cmd_random() {
    randomline="$(cat $RADIOS_LIST | sort | sed '/#.*$/d' | shuf -n 1)"
    randomradio=$(get_radio_name "$randomline")
    cmd_play $randomradio
}

cmd_add() {
    read -p "Enter radio name : " radioname
    read -p "Enter radio URL : " radiourl

    $(echo "$radioname : $radiourl" >> "$RADIOS_LIST")
}

cmd_delete() {
    read -p "Do you need the list ? [yes/no] : " answer
    
    if [ "$answer" = 'yes' ]
    then
        echo "$(cmd_list)"
    fi

    echo ""
    read -p "Enter radio name to delete : " radioname
    grep -v "$radioname" $RADIOS_LIST > /tmp/radiolist.tmp; mv /tmp/radiolist.tmp $RADIOS_LIST
}

cmd_help() {
    echo "\n=====================[\e[0;32mCOMMANDS\e[0m]====================="
    echo ""
    echo "  \e[0;34mlist\e[0m...............Show radio names"
    echo "  \e[0;34mplay <radio_name>\e[0m..Play specified radio"
    echo "  \e[0;34mrandom\e[0m.............Play random radio from list"
    echo "  \e[0;34madd\e[0m................Add a radio to the list"
    echo "  \e[0;34mdelete\e[0m.............Delete a radio from the list"
    echo "  \e[0;34mquit\e[0m...............Quit program"
    echo ""
    echo "==================================================="
}

display_title() {
    echo "    ____            ___            __         ____"
    echo "   / __ \____ _____/ (_)___  _____/ /_  ___  / / /"
    echo "  / /_/ / __ \`/ __  / / __ \/ ___/ __ \/ _ \/ / / "
    echo " / _, _/ /_/ / /_/ / / /_/ (__  ) / / /  __/ / /  "
    echo "/_/ |_|\__,_/\__,_/_/\____/____/_/ /_/\___/_/_/   "
    echo ""
}

cmd_exit() {
    exit 1
}

main() {
clear && echo "$(display_title)"

echo "$(cmd_help)"

while true;
do
    echo ""
    read -p "Enter command > " cmd args
    case $cmd in
        "")             continue;;   # skip empty input lines
        help)           cmd_name=help;;
        exit|quit)      cmd_name=exit;;
        list)           cmd_name=list;;
        play)           cmd_name=play;;
        add)            cmd_name=add;;
        delete)         cmd_name=delete;;
        random)         cmd_name=random;;
        *)              echo "\n\e[0;31mCommand doesn't exist. Try 'help'\e[0m" && continue;;
    esac
    cmd_$cmd $args
done
}

main
