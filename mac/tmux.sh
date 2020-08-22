#!/bin/bash

if [ "$#" -eq 0 ]; then
  tmux split-window -h -c '#{pane_current_path}'
  tmux split-window -h -c '#{pane_current_path}'\; select-layout even-horizontal
  tmux select-pane -t 1
  tmux split-window -v
  tmux select-pane -t 1
else
  case $1 in
    a)
      tmux split-window -h -c '#{pane_current_path}'
      tmux split-window -h -c '#{pane_current_path}'\; select-layout even-horizontal
      tmux select-pane -t 1
      ;;
    *)
      echo [ERROR] "$1" は設定されていない引数です
      ;;
  esac
fi
