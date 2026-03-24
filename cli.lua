-- cli.lua - Command-line interface for plop
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

local plop = require("init")

--- Parse command-line arguments
-- @return table The parsed arguments
local function parse_args()
    local args = {}
    for i, arg in ipairs(arg) do
        if arg == "--repository" or arg == "-r" then
            args.repository = arg[i + 1]
        end
    end
    return args
end

--- Main function
local function main()
    local args = parse_args()
    
    plop.init({ cwd = args.repository })
    
    local diff = plop.diff_staged()
    print(diff)
end

main()