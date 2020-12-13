#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Flomo
# @raycast.mode compact
# @raycast.packageName Flomo

# Optional parameters:
# @raycast.icon flomo.png
# @raycast.argument1 { "type": "text", "placeholder": "content" }
# @raycast.argument2 { "type": "text", "placeholder": "tag", "optional": true }

# Documentation:
# @raycast.description Create New Flomo
# @raycast.author Xianhe
# @raycast.authorURL https://twitter.com/foyoodo

if ! command -v jq &> /dev/null; then
	echo "jq command is required (https://stedolan.github.io/jq/).";
	exit 1;
fi

url='https://flomoapp.com/iwh/xxx/xxxxx'

if [ $2 ]; then
	content="$1\n\n#$2"
else
	content="$1"
fi

echo -e "$content" > "new-content.txt"

ret_json=$(curl -s -H "Content-Type: application/json" -X POST -d "{\"content\":\"$content\"}" $url | jq '.')

code=$(echo $ret_json | jq '.code')
message=$(echo $ret_json | jq '.message')

if [ "$code" = "0" ]; then
	limter_count=$(echo $ret_json | jq '.limterCount')
	echo "$message $limter_count"
else
	echo $message
fi
