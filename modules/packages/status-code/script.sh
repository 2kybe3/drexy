#!/usr/bin/env bash

URL="https://www.iana.org/assignments/http-status-codes/http-status-codes-1.csv"
TMP="/tmp/http-status-codes-1.csv"

: "${1?Error: please provide a status code}"

curl "$URL" > "$TMP" 2> /dev/null

duckdb -json -c "SELECT Value, Description, Reference FROM '$TMP' WHERE Value = '$1';" | python3 -c '
import json, sys
data = json.loads(sys.stdin.read().strip())
for row in data:
    print(f"V: {row.get("Value")}, D: {row.get("Description")}, R: {row.get("Reference")}")
'
