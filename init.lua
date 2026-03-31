local plop = {}
local git = require("git")
local openai = require("openai_client")

--- Initialize the plop module with configuration
--- @param options table Configuration options
--- @param options.git table Git module configuration
--- @param options.openai table OpenAI module configuration
--- @return table The plop module
function plop.init(options)
    if options then
        git.init(options.git)
        openai.init(options.openai)
    end
    return plop
end

--- Create a summary from a diff
--- @param diff string The git diff to summarize
--- @param model string|nil Optional model name
--- @return string The generated summary
local function create_summary(diff, model)
    local messages = {
        {
            role = "system",
            content = "Provide a concise summary of the following diff"
        },
        {
            role = "user",
            content = diff
        }
    };

    local response = openai.chat_completion(
        messages,
        model
    )

    return response
end

--- Create a summary of staged changes
--- @param model string|nil Optional model name
--- @return string The generated summary
function plop.create_staged_summary(model)
    local diff = git.diff_staged_changes()
    return create_summary(diff, model)
end

--- Create a summary of uncommitted changes
--- @param model string|nil Optional model name
--- @return string The generated summary
function plop.create_uncommitted_summary(model)
    local diff = git.diff_uncommitted_changes()
    return create_summary(diff, model)
end

return plop
