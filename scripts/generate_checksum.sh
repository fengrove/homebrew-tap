#!/bin/bash

REPO_OWNER="fengrove"
REPO_NAME="fengrove"
FILE1="mangrove-darwin-x86_64.tar.gz"
FILE2="packages.tar.gz"


set -u

set -o pipefail

if [ $# -eq 0 ]; then
  echo "Error: No version argument provided." >&2
  echo "Usage: $0 <version>" >&2
  echo "Example: $0 v0.0.23" >&2
  exit 1
fi

VERSION="$1"

BASE_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}/releases/download/${VERSION}"

echo "Calculating SHA-256 checksums for version: ${VERSION}"
echo "---"

# Function to download and calculate checksum for a given file
# Usage: get_checksum <filename>
get_checksum() {
  local file_name="$1"
  local url="${BASE_URL}/${file_name}"

  echo "Fetching checksum for: ${file_name}"
  echo "URL: ${url}"

  if ! curl -fsL "${url}" | shasum -a 256; then
    echo "Error: Failed to download or calculate checksum for ${file_name}." >&2
    echo "Please check the version ('${VERSION}'), filename, and your network connection." >&2
    return 1 # Indicate failure
  fi
  return 0 # Indicate success
}

get_checksum "${FILE1}"
FILE1_EXIT_STATUS=$?

echo

get_checksum "${FILE2}"
FILE2_EXIT_STATUS=$?

echo "---"

if [ ${FILE1_EXIT_STATUS} -ne 0 ] || [ ${FILE2_EXIT_STATUS} -ne 0 ]; then
  echo "Checksum calculation finished with errors."
  exit 1 # Exit with a non-zero status to indicate failure
else
  echo "Checksum calculation complete."
  exit 0 # Exit successfully
fi
