#!/bin/bash

# Simple validation script for Lua snippets
# This script checks basic file structure and syntax

echo "Validating Factorio Lua snippets..."
echo "=========================================="

# Check if snippets directory exists
if [ ! -d "snippets" ]; then
    echo "❌ snippets/ directory not found"
    exit 1
fi

# Count snippet files
snippet_count=$(ls snippets/*.lua 2>/dev/null | wc -l)
echo "📁 Found $snippet_count snippet files"

# Check each snippet file
for file in snippets/*.lua; do
    if [ -f "$file" ]; then
        echo "📄 Checking $(basename "$file")..."
        
        # Check if file has basic structure
        if grep -q "return" "$file"; then
            echo "  ✅ Has return statement"
        else
            echo "  ⚠️  No return statement found"
        fi
        
        # Check if file has documentation
        if grep -q "^---" "$file"; then
            echo "  ✅ Has documentation"
        else
            echo "  ⚠️  No documentation found"
        fi
    fi
done

echo
echo "📋 Project structure validation:"

# Check required files
files_to_check=("README.md" "init.lua" "control.lua" "info.json" ".luacheckrc")
for file in "${files_to_check[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file exists"
    else
        echo "  ❌ $file missing"
    fi
done

# Check required directories
dirs_to_check=("snippets" "examples" "docs" "scripts")
for dir in "${dirs_to_check[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✅ $dir/ directory exists"
    else
        echo "  ❌ $dir/ directory missing"
    fi
done

echo
echo "✅ Validation complete!"
echo "📝 To install luacheck for better validation: brew install luacheck"
echo "🎮 To use as a Factorio mod: copy this directory to your mods folder"
