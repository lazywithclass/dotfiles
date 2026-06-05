#!/usr/bin/env bash
L="$HOME/.config/i3/layouts"

# 1. placeholders first
i3-msg "workspace \"1:スタディ\";   append_layout $L/ws1.json"
i3-msg "workspace \"2:コード\";     append_layout $L/ws2.json"
i3-msg "workspace \"3:ソーシャル\"; append_layout $L/ws3.json"
i3-msg "workspace \"4:ブラウザ\";   append_layout $L/ws4.json"
i3-msg "workspace \"5\";            append_layout $L/ws5.json"

# 2. then launch — they map into the waiting placeholders regardless of focus
obsidian &
kitty -e bash -c 'tmux new-session -d -s main && tmux run-shell "$(tmux show-option -gqv @resurrect-restore-script-path)"; tmux attach -t main' &
Telegram &
discord &
brave &
thunderbird &

# 3. land on ws1
i3-msg 'workspace "1:スタディ"'
