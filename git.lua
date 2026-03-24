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

--- Get the diff of all staged changes
-- @return string The diff output of staged changes
function git.diff_staged()
    local handle = io.popen("git diff --cached --minimal")
    local result = handle:read("*a")
    handle:close()
    return result
end

--- Get the diff of all uncommitted changes
-- @return string The diff output of uncommitted changes
function git.diff_uncommitted()
    local handle = io.popen("git diff --minimal")
    local result = handle:read("*a")
    handle:close()
    return result
end

return git