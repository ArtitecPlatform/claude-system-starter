# Terminal layout — what a session looks like

Nothing exotic: stock **macOS Terminal.app** (profile: "Clear Dark"), plain zsh, no prompt framework. All the "layout" lives in Claude Code's own TUI settings, so it reproduces on any terminal emulator.

## The screen

```
┌──────────────────────────────────────────────────────────────────────────────┐
│ ✻ Claude Code                                          ~/Code/my-web-app     │  ← fullscreen TUI
│                                                                              │
│  CAVEMAN MODE ACTIVE — level: full                                           │  ← caveman plugin SessionStart hook
│  You have superpowers.                                                       │  ← superpowers plugin SessionStart hook
│                                                                              │
│  > /status                                                                   │
│                                                                              │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                              │
│  PROJECT: my-web-app                                                         │
│  GIT     Branch: feature/onboarding   Changes: 3 modified   Remote: 2 ahead  │
│  CRITIC  Last run: 2026-09-10   Score: 7/10   Open: 1 critical  2 warnings   │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                              │
│                                                                              │
│  Branch clean. Critique 7/10, one critical open. Run /critique before main.  │  ← caveman-style reply
│                                                                              │
│                                                                              │
│ > █                                                                          │  ← prompt
├──────────────────────────────────────────────────────────────────────────────┤
│ [Opus] ████████░░░░░░░░░░░░ 42% context | $1.87                              │  ← status line
└──────────────────────────────────────────────────────────────────────────────┘
```

## Where each part comes from

| Element | Setting | File |
|---|---|---|
| Fullscreen TUI (alt-screen, no scrollback bleed) | `"tui": "fullscreen"` | `settings.json` |
| Dark, color-blind-safe theme | `"theme": "dark-daltonized"` | `settings.json` (also mirrored in `~/.claude.json`) |
| Status line: model · context bar · cost | `"statusLine": {"type":"command","command":"bash ~/.claude/statusline-command.sh"}` | `settings.json` + `statusline-command.sh` |
| "CAVEMAN MODE ACTIVE" banner | caveman plugin SessionStart hook | plugin |
| "You have superpowers" banner | superpowers plugin SessionStart hook | plugin |
| Push notification when a long task finishes | `"agentPushNotifEnabled": true` | `settings.json` |
| High reasoning effort by default | `"effortLevel": "high"` | `settings.json` |

## Status line script
`statusline-command.sh` reads the JSON Claude pipes to it and prints one line:

```
[<model>] <20-char bar> <used%> context | $<session cost>
```

- Needs `jq` (`brew install jq`).
- The bar fills as context is consumed — when it passes ~80 % it's time to let auto-compact run or start a fresh session.
- Cost shows $0.00 on subscription plans; it's meaningful on API billing.

Want git branch in it too? Add before the final `echo`:
```bash
BRANCH=$(git -C "$(echo "$input" | jq -r '.cwd // "."')" branch --show-current 2>/dev/null)
echo "[$MODEL] ${BAR} ${PCT}% context | ${COST_FMT}${BRANCH:+ | $BRANCH}"
```

## Shell (`~/.zshrc`) — minimal
```zsh
export PATH="$HOME/.local/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
autoload -Uz compinit && compinit
```
No oh-my-zsh, no powerlevel10k — the Claude status line carries the state, the shell prompt stays quiet.

## Keys worth knowing
| Key | Does |
|---|---|
| `Shift+Tab` | cycle permission mode (default → acceptEdits → plan) |
| `Esc` | interrupt the current turn |
| `Ctrl+]` | reopen the most recent Artifact |
| `/caveman` · `normal mode` | terse replies on / off |
| `/status` `/sync` `/push` `/critique` | the daily loop |
| `! <cmd>` | run a shell command inline, output lands in the conversation |
| `/config` | change theme, model, TUI mode interactively |

## Reproduce on another emulator
iTerm2 / Ghostty / Warp all work; the only requirements are 256-color + a Nerd-Font-free monospace face (the bar uses plain block characters). Set the emulator to dark background; `dark-daltonized` assumes it.
