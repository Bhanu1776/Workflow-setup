#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Git Clone and Setup Dev Environment
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Git repository URL" }

# Documentation:
# @raycast.description Executes a series of steps from cloning the repo to installing dependencies to opening in vscode
# @raycast.author bhanu1776
# @raycast.authorURL https://raycast.com/bhanu1776

# Exit script if any command fails
set -e

# Directory to clone the repository into
TARGET_DIR=~/Developer/RTS

# Check if repository URL is provided
if [ -z "$1" ]; then
  echo "❌ Error: No Git repository URL provided."
  exit 1
fi

# Create the target directory if it doesn't exist
echo "📁 Creating target directory if it doesn't exist..."
mkdir -p "$TARGET_DIR"

# Change to the target directory
echo "📂 Changing to target directory..."
cd "$TARGET_DIR"

# Clone the repository
echo "🔄 Cloning the repository..."
git clone "$1"

# Extract the repository name from the URL
REPO_NAME=$(basename "$1" .git)

# Change to the repository directory
echo "📂 Changing to the repository directory..."
cd "$REPO_NAME"

# Try to install dependencies with npm
echo "📦 Installing dependencies..."
if ! npm install; then
  echo "⚠️ Initial npm install failed. Retrying with --force..."
  npm install --force
fi

# Open the repository in VS Code
echo "🚀 Opening the repository in VS Code..."
code .


# Open VS Code in fullscreen mode on macOS
echo "🖥️ Opening VS Code in fullscreen mode..."
osascript -e 'tell application "System Events" to keystroke "f" using {command down, control down}' \
          -e 'tell application "Visual Studio Code" to activate' 

echo "✅ Setup complete!"