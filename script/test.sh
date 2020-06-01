#!/bin/bash

[ -z "${CIRCLE_TOKEN_ORCA}" ] && echo "CIRCLE_TOKEN_ORCA can not be empty" && exit 1

echo "Running audit tests..."
jobNumber=$(curl -s -X POST \
    -H "Content-Type:application/json" \
    -d \
    '{ "build_parameters": {
        "CIRCLE_JOB": "audit-itest",
        "K8S_VULNERABILITIES_BRANCH_NAME": "'"${CIRCLE_BRANCH}"'"
    }}' \
    "https://circleci.com/api/v1.1/project/github/Tufin/orca?circle-token=${CIRCLE_TOKEN_ORCA}" | jq -r '.build_num')

echo "Watting for audit test's job number: '${jobNumber}'"
status="na"
for i in $(seq 1 600); do
    job=$(curl -s "https://circleci.com/api/v1.1/project/github/Tufin/orca/${jobNumber}?circle-token=${CIRCLE_TOKEN_ORCA}")
    lifecycle=$(echo "$job" | jq -r '.lifecycle')
    if [[ "${lifecycle}" == "finished" ]]; then
      status=$(echo "$job" | jq -r '.status')
      break
    else
      printf .
    fi
    sleep 1
done

echo ""
echo "Tests completed with status: '$status'"

if [[ "${status}" == "success" ]]; then
  exit 0
else
  exit 1
fi