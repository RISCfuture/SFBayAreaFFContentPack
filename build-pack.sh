#!/usr/bin/env bash
# Builds the ForeFlight content pack zip.
#
# Usage: build-pack.sh OUTPUT_ZIP
#
# Validates the navdata, then zips a generated manifest.json with byop/ and
# navdata/ under a single folder named after the pack. The manifest version
# is the build time, so ForeFlight replaces an installed pack with any
# rebuild. See https://foreflight.com/support/content-packs/ for the spec.

set -euo pipefail

readonly PACK_NAME="San Francisco Bay Area Content Pack"
readonly PACK_ABBREV="SFBayArea"
readonly ORGANIZATION="SF Flyers"

usage() {
  echo "usage: $0 OUTPUT_ZIP" >&2
  exit 64
}

validate_navdata() {
  local csv
  for csv in navdata/*.csv; do
    awk -F, '
      NF != 4 { printf "%s:%d: expected 4 fields, got %d\n", FILENAME, FNR, NF; bad = 1 }
      $3 !~ /^-?[0-9]+(\.[0-9]+)?$/ || $4 !~ /^-?[0-9]+(\.[0-9]+)?$/ {
        printf "%s:%d: non-numeric coordinates\n", FILENAME, FNR; bad = 1
      }
      seen[$1]++ { printf "%s:%d: duplicate ID %s\n", FILENAME, FNR, $1; bad = 1 }
      END { exit bad }
    ' "$csv"
  done
}

write_manifest() {
  jq -n \
    --arg name "$PACK_NAME" \
    --arg abbreviation "$PACK_ABBREV" \
    --argjson version "$(date -u +%s)" \
    --arg organizationName "$ORGANIZATION" \
    '{name: $name, abbreviation: $abbreviation, version: $version, organizationName: $organizationName}'
}

stage_pack() {
  local pack_root="$1/$PACK_NAME"
  mkdir -p -- "$pack_root"
  write_manifest > "$pack_root/manifest.json"
  cp -R byop navdata "$pack_root/"
}

main() {
  [ $# -eq 1 ] || usage

  local output_path
  output_path="$(cd -- "$(dirname -- "$1")" && pwd)/$(basename -- "$1")"

  cd -- "$(dirname -- "$0")"
  validate_navdata

  STAGING=$(mktemp -d)
  trap 'rm -rf -- "$STAGING"' EXIT

  stage_pack "$STAGING"

  rm -f -- "$output_path"
  (cd -- "$STAGING" && zip -qrX "$output_path" "$PACK_NAME")
  echo "Built $output_path"
}

main "$@"
