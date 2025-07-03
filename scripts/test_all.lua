#!/usr/bin/env lua

--[[
Test script for all Lua snippets
This script can be used to validate syntax and basic functionality
Run with: lua scripts/test_all.lua
--]]

local function test_snippet(snippet_path)
    print("Testing " .. snippet_path .. "...")
    
    local success, result = pcall(dofile, snippet_path)
    
    if success then
        print("✓ " .. snippet_path .. " - Syntax OK")
        return true
    else
        print("✗ " .. snippet_path .. " - Error: " .. result)
        return false
    end
end

local function get_snippet_files()
    local snippets = {}
    local handle = io.popen("ls snippets/*.lua 2>/dev/null")
    
    if handle then
        for file in handle:lines() do
            table.insert(snippets, file)
        end
        handle:close()
    end
    
    return snippets
end

local function main()
    print("Running syntax tests for all snippets...")
    print(string.rep("-", 40))
    
    local snippets = get_snippet_files()
    local passed = 0
    local total = #snippets
    
    for _, snippet in ipairs(snippets) do
        if test_snippet(snippet) then
            passed = passed + 1
        end
    end
    
    print(string.rep("-", 40))
    print(string.format("Results: %d/%d tests passed", passed, total))
    
    if passed == total then
        print("All tests passed! ✓")
        os.exit(0)
    else
        print("Some tests failed! ✗")
        os.exit(1)
    end
end

main()
