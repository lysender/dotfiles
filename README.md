# dotfiles

Various Linux configuration files.

## Sample macOS tmux workspaces

`.tmux.conf` and `scripts/tmux-workspaces.sh` provide a sample layout for
Ghostty or another terminal. The script contains personal project names and
paths: review and remove or replace them before sharing this repository.

Install tmux and manually place or link `.tmux.conf` at `~/.tmux.conf`. Edit
the workspace entries in the script to match your directories, then run it
from a terminal outside tmux:

```sh
bash scripts/tmux-workspaces.sh
```

The script creates missing `work`, `personal`, `misc`, and `watch` sessions
and attaches to `work`. It leaves existing sessions untouched and checks
directories before creating missing sessions. Each window starts a login zsh
shell; runner and watch windows do not launch commands automatically. Detach
and reconnect without losing running processes with `tmux attach -t work`.
After a reboot, rerun the script to recreate the layout; running programs are
not restored.

The configuration keeps tmux's default prefix: press **Ctrl+b**, release it,
then press the next key:

| Key | Action |
| --- | --- |
| `s` | Choose a session or window |
| `w` | Choose a window |
| `p` / `n` | Previous / next window |
| `0`–`9` | Select window by number |
| `c` / `,` | Create / rename window |
| `%` / `"` | Split left-right / top-bottom |
| Arrow keys | Move between panes |
| `d` | Detach |

Ghostty font and theme settings are separate from tmux and are not configured
by these files.
