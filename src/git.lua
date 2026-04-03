-- git.lua - Git utility functions for plop
-- Copyright (C) 2026 hkaurel
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

local git = {}
local cwd = nil

--- Initialize the git module with options
--- @param options table Configuration options
--- @param options.cwd string Working directory for git commands
function git.init(options)
    if options then
        cwd = options.cwd or "."
    end
end

--- Execute a git command with the configured working directory
--- @param command string The git command to execute
--- @return string The output of the command
local function execute_git_command(command)
    if cwd then
        command = "cd " .. cwd .. " && " .. command
    end
    local handle = io.popen(command)

    local result = handle:read("*a")
    handle:close()
    return result
end

--- Get the diff of all staged changes
--- @return string The diff output of staged changes
function git.diff_staged_changes()
    return execute_git_command("git diff --cached --minimal")
end

--- Get the diff of all uncommitted changes
--- @return string The diff output of uncommitted changes
function git.diff_uncommitted_changes()
    return execute_git_command("git diff --minimal")
end

return git
