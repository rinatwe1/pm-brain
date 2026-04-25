#!/bin/bash
# PM Brain Orchestrator Setup
# Sets up LaunchAgent to run agents on schedule for a product
# Usage: ./setup.sh /path/to/product

PRODUCT_PATH=$1
PM_BRAIN_PATH="$(cd "$(dirname "$0")/.." && pwd)"

if [ -z "$PRODUCT_PATH" ]; then
  echo "Usage: ./setup.sh /path/to/your-product"
  exit 1
fi

if [ ! -f "$PRODUCT_PATH/.pm-brain/agents/agents.yaml" ]; then
  echo "Error: No .pm-brain/agents/agents.yaml found in $PRODUCT_PATH"
  echo "Run /brain-init first"
  exit 1
fi

echo "PM Brain orchestrator setup for: $PRODUCT_PATH"
echo "Agent definitions: $PM_BRAIN_PATH/agents/"
echo ""
echo "To run agents manually:"
echo "  $PM_BRAIN_PATH/orchestrator/run.sh $PRODUCT_PATH"
echo ""
echo "To set up automatic scheduling (LaunchAgent), run:"
echo "  $PM_BRAIN_PATH/orchestrator/install-launchagent.sh $PRODUCT_PATH"
