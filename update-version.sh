#!/usr/bin/env bash

# Script to update the ktx.rb Homebrew formula with a new version
# This script will:
# 1. Prompt for the new version number
# 2. Download the release from GitHub
# 3. Calculate the SHA256 checksum
# 4. Update the ktx.rb file with the new URL, SHA256, and version

set -e

# Colors for output
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
default=$(tput sgr0)

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULA_FILE="$SCRIPT_DIR/ktx.rb"

echo "${cyan}KTX Homebrew Formula Updater${default}"
echo "=================================="

# Check if ktx.rb exists
if [ ! -f "$FORMULA_FILE" ]; then
    echo "${red}Error: ktx.rb not found in $SCRIPT_DIR${default}"
    exit 1
fi

# Prompt for version
read -p "${cyan}Enter the new version number (e.g., v0.3.1): ${default}" NEW_VERSION

# Validate version format
if [[ ! "$NEW_VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "${red}Error: Invalid version format. Please use format like: v0.3.1${default}"
    exit 1
fi

# Add 'v' prefix for the tag
VERSION_TAG="${NEW_VERSION}"

echo "${yellow}Updating ktx.rb to version $VERSION_TAG${default}"

# Create temporary directory for download
TEMP_DIR=$(mktemp -d)
TEMP_FILE="$TEMP_DIR/ktx-${NEW_VERSION}.tar.gz"

echo "${cyan}Downloading release from GitHub...${default}"
DOWNLOAD_URL="https://github.com/peledies/ktx/archive/refs/tags/${VERSION_TAG}.tar.gz"

if curl -L -o "$TEMP_FILE" "$DOWNLOAD_URL"; then
    echo "${green}Download successful!${default}"
else
    echo "${red}Error: Failed to download release from $DOWNLOAD_URL${default}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Calculate SHA256 checksum
echo "${cyan}Calculating SHA256 checksum...${default}"
NEW_SHA256=$(shasum -a 256 "$TEMP_FILE" | cut -d' ' -f1)
echo "${green}SHA256: $NEW_SHA256${default}"

# Clean up temporary file
rm -rf "$TEMP_DIR"

# Update the ktx.rb file
echo "${cyan}Updating ktx.rb file...${default}"

# Update URL
sed -i '' "s|url \"https://github.com/peledies/ktx/archive/v[0-9]*\.[0-9]*\.[0-9]*\.tar\.gz\"|url \"https://github.com/peledies/ktx/archive/${VERSION_TAG}.tar.gz\"|" "$FORMULA_FILE"

# Update SHA256
sed -i '' "s|sha256 \"[a-f0-9]*\"|sha256 \"$NEW_SHA256\"|" "$FORMULA_FILE"

# Update version
sed -i '' "s|version \"v[0-9]*\.[0-9]*\.[0-9]*\"|version \"$VERSION_TAG\"|" "$FORMULA_FILE"

echo "${green}Successfully updated ktx.rb!${default}"
echo ""
echo "${cyan}Changes made:${default}"
echo "  URL: https://github.com/peledies/ktx/archive/${VERSION_TAG}.tar.gz"
echo "  SHA256: $NEW_SHA256"
echo "  Version: $VERSION_TAG"
echo ""
echo "${cyan}Next steps:${default}"
echo "1. Review the changes in ktx.rb"
echo "2. Test the formula locally if needed"
echo "3. Commit and push the changes"
echo ""
echo "${green}Done!${default}"
