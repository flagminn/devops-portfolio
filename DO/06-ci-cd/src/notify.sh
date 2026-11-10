#!/bin/bash

BOT_TOKEN="8748160625:AAG82LQX6wA2OJ1dK_Alz3cP72A9KXZQCw0"
CHAT_ID="828632783"

STAGE_NAME=$1
STATUS=$2

if [ "$STATUS" == "success" ]; then
    TEXT="🟢 Stage $STAGE_NAME PASSED!
Project: $CI_PROJECT_NAME
Branch: $CI_COMMIT_REF_NAME
Commit: $CI_COMMIT_SHORT_SHA ($CI_COMMIT_MESSAGE)
Author: $CI_COMMIT_AUTHOR"
else
    TEXT="🔴 Stage $STAGE_NAME FAILED!
Project: $CI_PROJECT_NAME
Branch: $CI_COMMIT_REF_NAME
Commit: $CI_COMMIT_SHORT_SHA ($CI_COMMIT_MESSAGE)
Author: $CI_COMMIT_AUTHOR"
fi

PROXY="socks5://192.168.7.69:12334"

curl -s --max-time 10 -x "$PROXY" -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d "chat_id=${CHAT_ID}" \
    --data-urlencode "text=${TEXT}"