local git = require("plop.git")
local openai = require("plop.openai_client")

-- Mock for git commands
git.execute_git_command = nil

-- Mock tests
describe("git module", function()
    it("should initialize with cwd", function()
        git.init({cwd = "/path/to/repo"})
        -- Add your assertion here
        assert.truthy(true)
    end)

    it("should get staged diff", function()
        -- Mock git command
        git.execute_git_command = function(cmd)
            return "M  src/file.lua\n"
        end
        local diff = git.diff_staged_changes()
        assert.is_string(diff)
        assert.is_not-empty(diff)
    end)

    it("should get uncommitted diff", function()
        -- Mock git command
        git.execute_git_command = function(cmd)
            return "A  newfile.txt\n"
        end
        local diff = git.diff_uncommitted_changes()
        assert.is_string(diff)
        assert.is_not-empty(diff)
    end)
end)

describe("openai module", function()
    it("should initialize", function()
        openai.init({
            base_url = "https://test.com",
            bearer_token = "test-token"
        })
        assert.truthy(true)
    end)
end)
