#!/bin/sh

noctalia msg bar-hide > /dev/null &

hide_workspace_indicators_task() {
    sleep $1
    trap '' TERM
    noctalia msg bar-hide left > /dev/null
    noctalia msg bar-hide right > /dev/null
}

cancel_hide_workspace_indicators() {
    kill $hide_workspace_indicators_task_pid 2>/dev/null
    wait $hide_workspace_indicators_task_pid 2>/dev/null
}

hide_workspace_indicators() {
    cancel_hide_workspace_indicators
    hide_workspace_indicators_task $1 &
    hide_workspace_indicators_task_pid=$!
}

overview=false

niri msg event-stream \
    | grep --line-buffered -E '^(Workspace focused|Workspaces changed|Overview toggled):' \
    | while read -r line; do
	case "$line" in
	    'Overview toggled: false')
		noctalia msg bar-hide > /dev/null
		overview=false
	    ;;
	    'Overview toggled: true')
		cancel_hide_workspace_indicators
		noctalia msg bar-show > /dev/null
		overview=true
	    ;;
	    'Workspace'*) if ! $overview; then
		cancel_hide_workspace_indicators
		noctalia msg bar-show left > /dev/null
		noctalia msg bar-show right > /dev/null
		hide_workspace_indicators 1.6
	    fi ;;
	esac
    done
