#!/usr/bin/env bash

# Update a Homebrew formula in this tap to a new release.
# Usage: ./update-version.sh [formula]   (default: ktx)
# The formula's source repo is assumed to be github.com/peledies/<formula>.

set -e

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
default=$(tput sgr0)

NAME="${1:-ktx}"
REPO="peledies/${NAME}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULA_FILE="$SCRIPT_DIR/${NAME}.rb"

echo "${cyan}Homebrew Formula Updater: ${NAME}${default}"
echo "=================================="

if [ ! -f "$FORMULA_FILE" ]; then
    echo "${red}Error: ${NAME}.rb not found in $SCRIPT_DIR${default}"
    exit 1
fi

read -p "${cyan}Enter the new version number (e.g., v0.3.1): ${default}" VERSION_TAG

if [[ ! "$VERSION_TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "${red}Error: Invalid version format. Please use format like: v0.3.1${default}"
    exit 1
fi

echo "${yellow}Updating ${NAME}.rb to version $VERSION_TAG${default}"

TEMP_DIR=$(mktemp -d)
TEMP_FILE="$TEMP_DIR/${NAME}-${VERSION_TAG}.tar.gz"

echo "${cyan}Downloading release from GitHub...${default}"
DOWNLOAD_URL="https://github.com/${REPO}/archive/refs/tags/${VERSION_TAG}.tar.gz"

if curl -fL -o "$TEMP_FILE" "$DOWNLOAD_URL"; then
    echo "${green}Download successful!${default}"
else
    echo "${red}Error: Failed to download release from $DOWNLOAD_URL${default}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "${cyan}Calculating SHA256 checksum...${default}"
NEW_SHA256=$(shasum -a 256 "$TEMP_FILE" | cut -d' ' -f1)
echo "${green}SHA256: $NEW_SHA256${default}"

rm -rf "$TEMP_DIR"

echo "${cyan}Updating ${NAME}.rb file...${default}"

sed -i '' "s|url \"https://github.com/${REPO}/archive/v[0-9]*\.[0-9]*\.[0-9]*\.tar\.gz\"|url \"https://github.com/${REPO}/archive/${VERSION_TAG}.tar.gz\"|" "$FORMULA_FILE"
sed -i '' "s|sha256 \"[a-f0-9]*\"|sha256 \"$NEW_SHA256\"|" "$FORMULA_FILE"
sed -i '' "s|version \"v[0-9]*\.[0-9]*\.[0-9]*\"|version \"$VERSION_TAG\"|" "$FORMULA_FILE"

echo "${green}Successfully updated ${NAME}.rb!${default}"
echo ""
echo "${cyan}Changes made:${default}"
echo "  URL: https://github.com/${REPO}/archive/${VERSION_TAG}.tar.gz"
echo "  SHA256: $NEW_SHA256"
echo "  Version: $VERSION_TAG"
echo ""
echo "${cyan}Next steps:${default}"
echo "1. Review the changes in ${NAME}.rb"
echo "2. Test the formula locally if needed"
echo "3. Commit and push the changes"
echo ""
echo "${green}Done!${default}"
