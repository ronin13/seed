#!/bin/bash
unset TMUX
if tmux has-session -t term;then
    xterm -fs 11 -e tmux attach-session -d -t term
else
    xterm -fs 11 -e tmux new-session -s term
fi
