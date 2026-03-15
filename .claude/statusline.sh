#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
REMAINING=$(( 100 - PCT ))
INPUT_TOK=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
OUTPUT_TOK=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
DURATION_SEC=$(( DURATION_MS / 1000 ))
HOURS=$(( DURATION_SEC / 3600 ))
MINS=$(( (DURATION_SEC % 3600) / 60 ))
SECS=$(( DURATION_SEC % 60 ))
DURATION_FMT=$(printf '%02dh %02dm %02ds' "$HOURS" "$MINS" "$SECS")

COST_FMT=$(printf '$%.4f' "$COST")

# Build a small progress bar for context usage
BAR_LEN=10
FILLED=$(( PCT * BAR_LEN / 100 ))
EMPTY=$(( BAR_LEN - FILLED ))
BAR=$(printf '%0.s█' $(seq 1 $FILLED 2>/dev/null))
BAR="${BAR}$(printf '%0.s░' $(seq 1 $EMPTY 2>/dev/null))"

echo "${MODEL} | Cost: ${COST_FMT} | Context: ${BAR} ${PCT}% used (${REMAINING}% left) | In: ${INPUT_TOK} Out: ${OUTPUT_TOK} | Duration: ${DURATION_FMT}"
