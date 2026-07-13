#!/usr/bin/env bash

cur=$(i3-msg -t get_tree | jq -r '.. | select(.focused? == true) | .name')
new=$(rofi -dmenu -l 0 -p 'Title' -filter "$cur") || exit 0
[ -n "$new" ] && i3-msg title_format "$new"
