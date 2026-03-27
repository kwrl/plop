local plop = {}
local git = require("git")
local openai = require("openai_client")

function plop.init(options)
    if options then
        git.init(options.git)
        openai.init(options.openai)
    end
    return plop
end

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

function plop.create_staged_summary(model)
    local diff = git.diff_staged_changes()
    return create_summary(diff, model)
end

function plop.create_uncommitted_summary(model)
    local diff = git.diff_uncommitted_changes()
    return create_summary(diff, model)
end

return plop
