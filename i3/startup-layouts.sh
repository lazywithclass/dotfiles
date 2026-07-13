#!/usr/bin/env bash
set -u

obsidian &
kitty -e bash -c 'tmux new-session -d -s main && tmux run-shell "$(tmux show-option -gqv @resurrect-restore-script-path)"; tmux attach -t main' &
Telegram &
discord &
brave &
thunderbird &

place() {
  local class=$1 ws=$2
  for _ in $(seq 1 100); do
    if i3-msg -t get_tree | grep -qE "\"class\":\"$class"; then
      i3-msg "[class=\"$class\"] move to workspace \"$ws\"" >/dev/null
      return
    fi
    sleep 0.2
  done
}

place obsidian    "1:スタディ"
place kitty       "2:コード"
place Telegram    "3:ソーシャル"
place discord     "3:ソーシャル"
place Brave       "4:ブラウザ"
place thunderbird "5:メール"

i3-msg 'workspace "1:スタディ"'
