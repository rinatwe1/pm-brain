#!/bin/bash
# PM Brain — Run agents for a product
# Usage: ./run.sh /path/to/product [agent-name]
# If agent-name omitted, runs all enabled agents

PRODUCT_PATH=$1
AGENT_NAME=$2
PM_BRAIN_PATH="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_YAML="$PRODUCT_PATH/.pm-brain/agents/agents.yaml"
LOG_DIR="$PRODUCT_PATH/.pm-brain/agents/logs"

if [ -z "$PRODUCT_PATH" ]; then
  echo "Usage: ./run.sh /path/to/product [agent-name]"
  exit 1
fi

mkdir -p "$LOG_DIR"

echo "PM Brain — running agents for: $PRODUCT_PATH"
echo "Timestamp: $(date)"
echo "Agent definitions: $PM_BRAIN_PATH/agents/"
echo ""
echo "Note: Each agent runs as a Claude Code invocation."
echo "Make sure Claude Code CLI is available."
echo ""
# TODO: Parse agents.yaml and invoke Claude Code for each enabled agent
# This is the orchestration skeleton — full implementation in Phase 2
echo "Orchestrator skeleton — implement agent invocations here"
