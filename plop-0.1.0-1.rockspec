package = "plop"
version = "0.1.0"
source = {
   url = "git://github.com/user/plop.git"
}
description = {
   summary = "A tool that uses AI to provide insights and summaries from git repositories.",
   detailed = [[
A tool that uses AI to provide insights and summaries from git repositories.
   ]],
   homepage = "https://github.com/user/plop",
   license = "GPL-3.0"
}
dependencies = {
   "luasocket >= 3.0"
}
build = {
   type = "builtin",
   modules = {
      plop = "init.lua"
   }
}