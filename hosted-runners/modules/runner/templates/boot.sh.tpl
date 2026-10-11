#!/bin/bash

# Ensure required packages are installed
dnf install -y docker jq

# Enable and start Docker service
systemctl enable --now docker

QUEUE_URL="${queue_url}"
REGION="${region}"

while true; do
    MESSAGE=$(aws sqs receive-message \
        --queue-url "$QUEUE_URL" \
        --region "$REGION" \
        --wait-time-seconds 20 \
        --max-number-of-messages 1)

    # Check if the message is empty or null
    if [ -z "$MESSAGE" ] || [ "$(echo "$MESSAGE" | jq -r '.Messages // empty')" = "" ]; then
        continue
    fi

    RECEIPT_HANDLE=$(echo "$MESSAGE" | jq -r '.Messages[0].ReceiptHandle')
    BODY=$(echo "$MESSAGE" | jq -r '.Messages[0].Body')
    IMAGE=$(echo "$BODY" | jq -r '.image')
    COMMAND=$(echo "$BODY" | jq -r '.command')

    # Run the Docker container and delete the message from SQS upon success
    if docker run --rm "$IMAGE" sh -c "$COMMAND"; then
        aws sqs delete-message \
            --queue-url "$QUEUE_URL" \
            --region "$REGION" \
            --receipt-handle "$RECEIPT_HANDLE"
    fi
done
