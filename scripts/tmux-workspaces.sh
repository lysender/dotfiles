#!/bin/bash
# Run with: bash scripts/tmux-workspaces.sh

set -euo pipefail

if [[ -n "${TMUX:-}" ]]; then
	printf '%s\n' 'Already inside tmux. Use Ctrl-b s to switch sessions; run this script outside tmux to create missing sessions.' >&2
	exit 1
fi

if ! command -v tmux >/dev/null 2>&1; then
	printf '%s\n' 'tmux is not installed or not in PATH.' >&2
	exit 1
fi

# Each entry is session|window name|working directory. The first entry for
# each session becomes its initial window; subsequent entries retain order.
workspaces=(
	"work|tab1|$HOME/workspaces/work/tab1"
	"work|tab2|$HOME/workspaces/work/tab2"
	"work|tab3|$HOME/workspaces/work/tab3"
	"personal|tab1|$HOME/workspaces/personal/tab1"
	"personal|tab2|$HOME/workspaces/personal/tab2"
	"personal|tab3|$HOME/workspaces/personal/tab3"
	"misc|home|$HOME"
	"misc|nvim|$HOME/.config/nvim"
	"misc|dotfiles|$HOME/dotfiles"
	"watch|tab1|$HOME/workspaces/work/tab1"
	"watch|tab2|$HOME/workspaces/work/tab2"
	"watch|tab3|$HOME/workspaces/work/tab3"
)

# Check every directory for sessions that need creating before creating any,
# so a missing directory cannot leave a partially initialized layout.
missing=0
for entry in "${workspaces[@]}"; do
	IFS='|' read -r session window directory <<<"$entry"
	if ! tmux has-session -t "=$session" 2>/dev/null && [[ ! -d "$directory" ]]; then
		printf 'Missing directory for %s/%s: %s\n' "$session" "$window" "$directory" >&2
		missing=1
	fi
done
if ((missing)); then
	exit 1
fi

# Create each missing session once, then add its windows. Existing sessions
# are deliberately left untouched, including any windows changed by hand.
for session in work personal misc watch; do
	if tmux has-session -t "=$session" 2>/dev/null; then
		continue
	fi

	first=1
	for entry in "${workspaces[@]}"; do
		IFS='|' read -r entry_session window directory <<<"$entry"
		[[ "$entry_session" == "$session" ]] || continue
		if ((first)); then
			tmux new-session -d -s "$session" -n "$window" -c "$directory"
			first=0
		else
			tmux new-window -t "=$session:" -n "$window" -c "$directory"
		fi
	done
done

exec tmux attach-session -t '=work'
