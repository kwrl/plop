-- plop - A tool that uses AI to provide insights and summaries from git repositories.
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

local plop = {}
local git = require("git")

--- Initialize the plop module
-- @return table The plop module
function plop.init()
    print("plop initialized")
    return plop
end

--- Generate insights from a git repository
-- @param repo_path string The path to the git repository
-- @return string Insights generated from the repository
function plop.generate_insights(repo_path)
    -- Placeholder for AI logic
    return "Insights for repository at " .. repo_path
end

--- Create a summary from a git repository
-- @param repo_path string The path to the git repository
-- @return string Summary generated from the repository
function plop.create_summary(repo_path)
    -- Placeholder for AI logic
    return "Summary for repository at " .. repo_path
end

--- Get the diff of all staged changes
-- @return string The diff output of staged changes
function plop.diff_staged()
    return git.diff_staged()
end

--- Get the diff of all uncommitted changes
-- @return string The diff output of uncommitted changes
function plop.diff_uncommitted()
    return git.diff_uncommitted()
end

return plop