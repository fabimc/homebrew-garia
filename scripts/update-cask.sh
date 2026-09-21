#!/usr/bin/env bash
# Pin Casks/garia.rb to a published Garia GitHub Release.
# Usage: scripts/update-cask.sh [v0.1.0]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CASK="${ROOT}/Casks/garia.rb"
REPO="${GARIA_REPO:-fabimc/garia}"
TAG="${1:-}"

if ! gh release view --repo "${REPO}" >/dev/null 2>&1; then
  echo "No published release on ${REPO} yet. Publish the GitHub Release draft first."
  exit 0
fi

if [[ -z "${TAG}" ]]; then
  TAG="$(gh release view --repo "${REPO}" --json tagName --jq .tagName)"
fi

VERSION="${TAG#v}"
assets="$(gh release view --repo "${REPO}" --json assets --jq '.assets[].name')"
dmg="$(printf '%s\n' "${assets}" | grep -E "^Garia_${VERSION}_universal\\.dmg$" || true)"
if [[ -z "${dmg}" ]]; then
  dmg="$(printf '%s\n' "${assets}" | grep -E '\\.dmg$' | head -n1 || true)"
fi

if [[ -z "${dmg}" ]]; then
  echo "No DMG on ${REPO} ${TAG}." >&2
  printf '%s\n' "${assets}" >&2
  exit 1
fi

url="https://github.com/${REPO}/releases/download/${TAG}/${dmg}"
tmp="$(mktemp)"
trap 'rm -f "${tmp}"' EXIT
curl -fsSL "${url}" -o "${tmp}"
sha="$(shasum -a 256 "${tmp}" | awk '{print $1}')"

python3 - "${CASK}" "${VERSION}" "${sha}" <<'PY'
import pathlib
import re
import sys

path = pathlib.Path(sys.argv[1])
version = sys.argv[2]
sha = sys.argv[3]
text = path.read_text()
text = re.sub(r'^  version ".*"$', f'  version "{version}"', text, count=1, flags=re.M)
text = re.sub(r'^  sha256 .*$', f'  sha256 "{sha}"', text, count=1, flags=re.M)
path.write_text(text)
PY

echo "Pinned ${CASK} to ${VERSION} (${sha})"
echo "URL ${url}"
