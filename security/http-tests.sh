#!/usr/bin/env bash
set -euo pipefail
base=http://127.0.0.1:3000
for route in / /health /api/products; do
  echo "Testing $route"
  headers=$(curl -fsS -D - -o /dev/null "$base$route")
  grep -qi '^x-content-type-options: nosniff' <<< "$headers"
  grep -qi '^x-frame-options:' <<< "$headers"
  grep -qi '^content-security-policy:' <<< "$headers"
  if grep -qi '^x-powered-by:' <<< "$headers"; then exit 1; fi
done
[[ $(curl -sS -o /dev/null -w '%{http_code}' "$base/invalid") == 404 ]]
[[ $(curl -sS -o /dev/null -w '%{http_code}' -X POST "$base/api/products") == 404 ]]
echo 'HTTP security tests passed'
