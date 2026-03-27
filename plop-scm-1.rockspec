package = "plop"
version = "1.0-1"
source = {
    url = "./plop-scm-1.src.rock"
}
description = {
    summary = "Plop is an AI-powered tool for generating insights and summaries from git repositories",
    homepage = "",
    license = "GPL-3.0"
}
dependencies = {
    "lua-cjson >= 1.0.0",
    "luasocket >= 3.0"
}
build = {
    type = "builtin",
    modules = {
        ["plop"] = "init.lua",
        ["plop.git"] = "git.lua",
        ["plop.openai_client"] = "openai_client.lua"
    }
}
