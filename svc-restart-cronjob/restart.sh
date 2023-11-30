#!/bin/bash

# Define the Kubernetes namespace and label selector for the pods to restart
NAMESPACE="<nginx>"
LABEL_SELECTOR="app=<app label>"  # Customize as needed

# Check if today is the 1st day of the month
if [ "$(date +\%d)" -eq "01" ]; then
  # Get a list of pod names that match the label selector in the specified namespace
  PODS=$(kubectl get pods -n "$NAMESPACE" -l "$LABEL_SELECTOR" -o jsonpath='{.items[*].metadata.name}')

  # Restart each pod
  for POD in $PODS; do
    kubectl delete pod "$POD" -n "$NAMESPACE"
    echo "Restarted pod: $POD"
  done

  # Send a Microsoft Teams notification (replace with your webhook URL)
  TEAMS_WEBHOOK_URL="<teams webhook>"
  MESSAGE="Pods with label selector '$LABEL_SELECTOR' in namespace '$NAMESPACE' have been restarted."
  
  # Use cURL to send a POST request to the Microsoft Teams webhook
  curl -H "Content-Type: application/json" -d '{"text":"'"$MESSAGE"'"}' "$TEAMS_WEBHOOK_URL"
else
  echo "No pods were restarted."
fi
