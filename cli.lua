local plop = require("init")

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
            base_url = os.getenv("PLOP_OPENAI_BASEURL"),
            bearer_token = os.getenv("PLOP_OPENAI_BEARERTOKEN")
        }
    })
    local summary = plop.create_staged_summary()
    print(summary)
end

main()
