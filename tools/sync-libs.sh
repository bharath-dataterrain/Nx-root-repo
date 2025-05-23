#!/bin/bash

# Library synchronization script
# Usage: ./tools/sync-libs.sh

set -e  # Exit on any error

MAIN_REPO_URL="https://github.com/bharath-dataterrain/Nx-root-repo.git"
LIB_BRANCH="libs-only"

echo "🔄 Starting library synchronization..."

# Check if main-repo remote exists
if ! git remote | grep -q "main-repo"; then
    echo "➕ Adding main repository as remote..."
    git remote add main-repo $MAIN_REPO_URL
else
    echo "✅ Main repository remote already exists"
fi

# Fetch latest changes from main repo
echo "📥 Fetching changes from main repository..."
git fetch main-repo

# Check if libs directory exists
if [ ! -d "libs" ]; then
    echo "📁 Creating libs directory..."
    mkdir libs
    git add libs
    git commit -m "Initialize libs directory for subtree"
fi

# Pull library changes using subtree
echo "🔀 Merging library changes..."
git subtree pull --prefix=libs main-repo $LIB_BRANCH --squash -m "Sync libraries from main repo"

echo "✅ Library synchronization complete!"
echo "📝 Don't forget to commit any additional changes if needed."