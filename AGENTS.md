# AGENTS.md

This document provides guidelines and commands for agentic coding tools operating in this repository.

## Build/Lint/Test Commands

### Build Commands
- **Build the project**: No build step required for Lua projects.
- **Install dependencies**: Use `luarocks install` for dependencies listed in the rockspec file.

### Lint Commands
- **Lint the code**: Use `luacheck` for static analysis:
  ```bash
  luacheck .
  ```

### Test Commands
- **Run all tests**: No test framework is currently configured. You can use `busted` for testing:
  ```bash
  busted
  ```
- **Run a single test**: Use `busted` with a specific file or test name:
  ```bash
  busted path/to/test_file.lua
  ```

## Rockspec File
- **Rockspec location**: `/home/hkaurel/Code/plop/rockspecs/plop-scm-1.rockspec`
- **Dependencies**: 
  - `lua-cjson >= 1.0.0`
  - `luasocket >= 3.0`

## Code Style Guidelines

### Imports
- **Ordering**: Group imports by type (standard library, third-party, local modules).
- **Spacing**: Use a single blank line between import groups.
- **Example**:
  ```lua
  local io = require("io")
  local luasocket = require("luasocket")
  local git = require("git")
  ```

### Formatting
- **Indentation**: Use 4 spaces for indentation.
- **Line Length**: Keep lines under 120 characters.
- **Spacing**: Use spaces around operators and after commas.
- **Example**:
  ```lua
  local function example(a, b)
      return a + b
  end
  ```

### Types
- **Type Annotations**: Use LuaLS-style comments for type hints:
  ```lua
  --- @param name string
  --- @return number
  local function greet(name)
      return #name
  end
  ```

### Naming Conventions
- **Variables**: Use `snake_case` for variable names.
- **Functions**: Use `snake_case` for function names.
- **Constants**: Use `UPPER_SNAKE_CASE` for constants.
- **Example**:
  ```lua
  local MAX_RETRIES = 3
  local function calculate_total()
      local total = 0
      return total
  end
  ```

### Error Handling
- **Use `pcall`**: For safe function calls that might fail.
- **Check for `nil`**: Always validate inputs and outputs.
- **Example**:
  ```lua
  local success, result = pcall(function()
      return some_function()
  end)
  
  if not success then
      error("Failed to execute function: " .. result)
  end
  ```

### Documentation
- **Function Comments**: Use `---` for documentation comments.
- **Param/Return Tags**: Document parameters and return values.
- **Example**:
  ```lua
  --- Calculate the sum of two numbers
  --- @param a number The first number
  --- @param b number The second number
  --- @return number The sum of a and b
  local function add(a, b)
      return a + b
  end
  ```

### File Structure
- **Header**: Include a license header at the top of each file.
- **Example**:
  ```lua
  -- filename.lua - Description
  -- Copyright (C) 2026 hkaurel
  --
  -- This program is free software: you can redistribute it and/or modify
  -- it under the terms of the GNU General Public License as published by
  -- the Free Software Foundation, either version 3 of the License, or
  -- (at your option) any later version.
  ```

### Git Guidelines
- **Commit Messages**: Use imperative mood (e.g., "Add feature" not "Added feature").
- **Branch Naming**: Use `kebab-case` for branch names (e.g., `feature/new-cli`).
- **Example Commit Message**:
  ```
  Add CLI support and make CWD configurable
  ```

### Testing
- **Test Files**: Place test files in a `tests/` directory.
- **Test Naming**: Use `test_` prefix for test files (e.g., `test_git.lua`).
- **Example Test**:
  ```lua
  local git = require("git")
  
  describe("git module", function()
      it("should return staged diff", function()
          git.set_cwd("/path/to/repo")
          local diff = git.diff_staged()
          assert.is_string(diff)
      end)
  end)
  ```

### Dependencies
- **Rockspec**: Update the rockspec file for new dependencies.
- **Example**:
  ```lua
  dependencies = {
      "luasocket >= 3.0"
  }
  ```

### CLI Guidelines
- **Argument Parsing**: Use simple loops for argument parsing.
- **Help Text**: Provide clear usage instructions.
- **Example**:
  ```lua
  if not args.repository then
      print("Usage: lua cli.lua --repository /path/to/repository")
      os.exit(1)
  end
  ```

### Error Handling in CLI
- **Exit Codes**: Use `os.exit(1)` for errors.
- **User Feedback**: Print clear error messages.
- **Example**:
  ```lua
  if not success then
      print("Error: " .. result)
      os.exit(1)
  end
  ```

### Logging
- **Use `print`**: For simple logging in CLI tools.
- **Verbosity Levels**: Add flags for different log levels (e.g., `--verbose`).
- **Example**:
  ```lua
  if args.verbose then
      print("Debug: " .. debug_info)
  end
  ```

### Security
- **Input Validation**: Always validate user inputs.
- **Avoid `load`**: Prefer `loadstring` with proper sandboxing.
- **Example**:
  ```lua
  if not path:match("^[%w/.-]+$") then
      error("Invalid path")
  end
  ```

### Performance
- **Avoid Global Variables**: Use `local` to limit scope.
- **Reuse Objects**: Avoid creating objects in loops.
- **Example**:
  ```lua
  local buffer = {}
  for i = 1, 100 do
      table.insert(buffer, i)
  end
  ```

### Compatibility
- **Lua Version**: Target Lua 5.1+ for broad compatibility.
- **Feature Checks**: Use `if _VERSION` for version-specific code.
- **Example**:
  ```lua
  if _VERSION == "Lua 5.1" then
      -- Lua 5.1 specific code
  end
  ```

### Tooling
- **EditorConfig**: Use `.editorconfig` for consistent formatting.
- **Example `.editorconfig`**:
  ```ini
  root = true
  
  [*]
  indent_style = space
  indent_size = 4
  end_of_line = lf
  charset = utf-8
  trim_trailing_whitespace = true
  insert_final_newline = true
  ```

### CI/CD
- **GitHub Actions**: Use for automated testing and linting.
- **Example Workflow**:
  ```yaml
  name: CI
  on: [push, pull_request]
  jobs:
      test:
          runs-on: ubuntu-latest
          steps:
              - uses: actions/checkout@v2
              - uses: actions/setup-lua@v1
              - run: luacheck .
              - run: busted
  ```

### Documentation
- **README**: Keep a `README.md` with setup and usage instructions.
- **Example**:
  ```markdown
  # Plop
  
  A tool that uses AI to provide insights and summaries from git repositories.
  
  ## Installation
  
  ```bash
  luarocks install plop
  ```
  ```

### Contributing
- **Pull Requests**: Follow the existing code style.
- **Issue Template**: Use clear and descriptive issue titles.
- **Example Issue**:
  ```markdown
  ### Description
  
  Describe the issue here.
  
  ### Steps to Reproduce
  
  1. Step one
  2. Step two
  ```

### License
- **GPL-3.0**: Ensure all files include the license header.
- **Example**:
  ```lua
  -- Copyright (C) 2026 hkaurel
  -- Licensed under the GNU General Public License v3.0
  ```

### Future Improvements
- **Add More Tests**: Expand test coverage for edge cases.
- **Enhance CLI**: Add more commands and flags.
- **Improve Documentation**: Add more examples and tutorials.

This document serves as a guide for maintaining consistency and quality in the codebase. Adhere to these guidelines to ensure smooth collaboration and maintainability.
