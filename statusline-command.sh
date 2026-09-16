#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# Build progress bar
BAR_WIDTH=20
FILLED=$(( PCT * BAR_WIDTH / 100 ))
EMPTY=$(( BAR_WIDTH - FILLED ))
BAR=$(printf '%0.s█' $(seq 1 $FILLED 2>/dev/null))
BAR+=$(printf '%0.s░' $(seq 1 $EMPTY 2>/dev/null))

# Format cost
COST_FMT=$(printf '$%.2f' "$COST")

echo "[$MODEL] ${BAR} ${PCT}% context | ${COST_FMT}"
