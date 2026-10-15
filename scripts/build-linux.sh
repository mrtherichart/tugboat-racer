#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p out
odin check src
odin build src -out:out/tugboat-racer-linux
echo "Linux binary: out/tugboat-racer-linux"
