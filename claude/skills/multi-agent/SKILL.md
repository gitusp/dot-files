---
name: multi-agent
description: Use when the user asks to run tasks in parallel.
allowed-tools: Bash
---

# Multi-agent parallel execution

## Sub-agent

Use for tasks that complete autonomously (research, code generation, tests, etc.). No special setup needed.

## WezTerm panes

Use for tasks needing ongoing conversation. Don't ask for details before opening panes — open first, then ask if needed.

First, capture own pane ID with `$WEZTERM_PANE` and use `--pane-id` explicitly in all split operations to avoid targeting a wrong window.

Start Claude Code in new panes: `wezterm cli split-pane --pane-id $MY_PANE --right -- claude`

### Layout

Split from top-level panes only, never sub-split a small pane.

- **2**: `split-pane --right`
- **4 (2x2)**: split right -> split right-pane bottom -> split left-pane bottom
- **Other**: aim for a grid. Split the largest pane each time.

After all panes are open, `wezterm cli activate-pane` back to the original pane.

### Submitting input

`wezterm cli send-text --pane-id N --no-paste $'\r'`
