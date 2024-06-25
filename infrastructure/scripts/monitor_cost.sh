#!/bin/bash

# Variables
BUDGET=20
CURRENT_COST=0
AZURE_CLIENT_ID=$1
AZURE_CLIENT_SECRET=$2
AZURE_TENANT_ID=$3
AZURE_SUBSCRIPTION_ID=$4
SLACK_WEBHOOK_URL=$5

# Get the current date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)
# Get the first day of the current month in YYYY-MM-DD format
START_OF_MONTH=$(date +%Y-%m-01)

# Log in to Azure using service principal
az login --service-principal -u "$AZURE_CLIENT_ID" -p "$AZURE_CLIENT_SECRET" --tenant "$AZURE_TENANT_ID"

# Construct the query JSON
query=$(cat <<EOF
{
    "type": "ActualCost",
    "timeframe": "Custom",
    "timePeriod": {
        "from": "$START_OF_MONTH",
        "to": "$TODAY"
    },
    "dataset": {
        "granularity": "None",
        "aggregation": {
            "totalCost": {
                "name": "PreTaxCost",
                "function": "Sum"
            }
        }
    }
}
EOF
)

# Run the query and get the current month's cost
CURRENT_COST=$(az rest --method post --url "https://management.azure.com/subscriptions/$AZURE_SUBSCRIPTION_ID/providers/Microsoft.CostManagement/query?api-version=2019-11-01" --body "$query" --output tsv --query "properties.rows[0][0]")

# Check if the current cost exceeds the budget
if [[ -z "$CURRENT_COST" ]]; then
    echo "Error: Failed to retrieve current cost."
    exit 1
fi

if (( $(echo "$CURRENT_COST > $BUDGET" | bc -l) )); then
    echo "Alert: Azure cost has exceeded the budget of $BUDGET. Current cost: $CURRENT_COST"
    # Send a notification to Slack (You need to have SLACK_WEBHOOK_URL configured in your GitHub Secrets)
    PAYLOAD=$( jq -n --arg text "Alert: Azure cost has exceeded the budget of $BUDGET. Current cost: $CURRENT_COST" '{ text: $text }' )
    curl -X POST -H "Content-Type: application/json" -d "$PAYLOAD" "$SLACK_WEBHOOK_URL"
else
    echo "Azure cost is within the budget. Current cost: $CURRENT_COST"
fi
