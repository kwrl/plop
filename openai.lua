-- openai.lua - OpenAI API integration for plop
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

local openai = {}
local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson")

local base_url = nil
local bearer_token = nil

--- Initialize the OpenAI module
-- @param options table Configuration options
-- @param options.base_url string The base URL for the OpenAI API
-- @param options.bearer_token string The bearer token for authentication
function openai.init(options)
    if options and options.base_url then
        base_url = options.base_url
    end
    if options and options.bearer_token then
        bearer_token = options.bearer_token
    end
end

--- Perform a chat completion request
-- @param messages table The list of messages for the chat completion
-- @param model string The model to use for the chat completion
-- @return table The response from the OpenAI API
function openai.chat_completion(messages, model)
    if not base_url or not bearer_token then
        error("OpenAI module not initialized. Call openai.init() first.")
    end
    
    local request_body = json.encode({
        model = model or "gpt-3.5-turbo",
        messages = messages
    })
    
    local response_body = {}
    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. bearer_token
    }
    
    local url = base_url .. "/v1/chat/completions"
    local success, status_code = http.request({
        url = url,
        method = "POST",
        headers = headers,
        source = ltn12.source.string(request_body),
        sink = ltn12.sink.table(response_body)
    })
    
    if not success then
        error("Failed to perform chat completion: " .. (status_code or "unknown error"))
    end
    
    local response = table.concat(response_body)
    return json.decode(response)
end

return openai