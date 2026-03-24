--

local plop = require("init")

--- Parse command-line arguments
-- @return table The parsed arguments
local function parse_args()
    local args = {}
    for i, arg_value in ipairs(arg) do
        if arg_value == "--repository" or arg_value == "-r" then
            args.repository = arg[i + 1]
        end
    end
    return args
end

--- Main function
local function main()
    local args = parse_args()
    plop.init({
        git = {
            cwd = args.repository
        },
        openai = {
            base_url = "TODO",
            bearer_token = "TODO"
        }
    })
    local summary = plop.create_staged_summary()
    print(summary)
end

main()
