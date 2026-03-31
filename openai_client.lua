local io = require("io")
local cjson = require("cjson")
local http = require("socket.http")
local ltn12 = require("ltn12")

local openai = {}

local base_url = nil
local bearer_token = nil
local default_model = nil

--- Initialize the OpenAI client with configuration options
--- @param options table Configuration options
--- @param options.base_url string Base URL for the OpenAI API
--- @param options.bearer_token string Bearer token for authentication
--- @param options.default_model string Default model to use
function openai.init(options)
    base_url = options.base_url or "https://api.openai.com"
    bearer_token = options.bearer_token or "THIS_IS_CLEARLY_NOT_VALID"
    default_model = options.default_model or "ministral-3:8b"
end

--- Get chat completions from OpenAI
--- @param messages table Array of message objects with role and content
--- @param model string|nil Optional model name, defaults to default_model
--- @return string The chat completion response content
function openai.chat_completion(messages, model)
    if not base_url or not bearer_token then
        error("OpenAI module not initialized. Call openai.init() first.")
    end
    local request_body = {
        model = model or default_model,
        messages = messages
    }
    local request_json = cjson.encode(request_body)
    local url = base_url .. "/v1/chat/completions"

    local response_body_raw = {}

    http.request {
        method = "POST",
        url = url,
        source = ltn12.source.string(request_json),
        headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. bearer_token,
            ["Content-Length"] = tostring(#request_json)
        },
        sink = ltn12.sink.table(response_body_raw)
    }

    local response_body = cjson.decode(table.concat(response_body_raw))

    return response_body.choices[1].message.content
end

return openai
