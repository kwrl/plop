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
local openai = require("openai_client")

--- Initialize the plop module
-- @param options table Optional configuration options
-- @return table The plop module
function plop.init(options)
    if options then
        git.init(options.git)
        openai.init(options.openai)
    end
    return plop
end

--- Create a summary from a git repository
-- @param repo_path string The path to the git repository
-- @return string Summary generated from the repository
function plop.create_staged_summary()
    local diff = git.diff_staged()
    local messages = {
        {
            role = "system",
            content = "Provide a concise summary of the following git diff"
        },
        {
            role = "user",
            content = diff
        }
    };

    local response = openai.chat_completion(
        messages,
        "ministral-3:8b"
    )

    return response
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
