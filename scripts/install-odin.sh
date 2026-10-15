#!/usr/bin/env bash
set -euo pipefail
version=dev-2026-10
archive="odin-linux-amd64-$version.tar.gz"
dir="${RUNNER_TEMP:-/tmp}/odin-install"
mkdir -p "$dir"
curl -fL --retry 3 "https://github.com/odin-lang/Odin/releases/download/$version/$archive" -o "$dir/$archive"
echo "c3c8b095621fd0c75f7f73e3a0829f1b4d45324225f20ba11ed8dc4da310a8ab  $dir/$archive" | sha256sum -c -
tar -xzf "$dir/$archive" -C "$dir"
exe="$(find "$dir" -type f -name odin -print -quit)"
test -n "$exe"
chmod +x "$exe"
root="$(dirname "$exe")"
echo "$root" >> "$GITHUB_PATH"
echo "ODIN_ROOT=$root" >> "$GITHUB_ENV"
"$exe" version
