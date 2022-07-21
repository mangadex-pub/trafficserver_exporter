#!/usr/bin/env bash

set -euo pipefail

echo "Starting Apache Traffic Server exporter..."

if [ -z "${ATS_ENDPOINT:-}" ]; then
    echo "ATS_ENDPOINT is not defined (example: http://127.0.0.1/_stats)"
    exit 1
fi

if [ -z "${EXP_PORT:-}" ]; then
    echo "EXP_PORT is not defined (example: 8080)"
    exit 1
fi

echo "Collecting metrics:"
echo "- From: ${ATS_ENDPOINT}"
echo "- Served at: 0.0.0.0:${EXP_PORT}"

exec trafficserver_exporter \
    --endpoint "$ATS_ENDPOINT" \
    --port "$EXP_PORT" \
    --no-procstats \
    --no-ssl-verification
