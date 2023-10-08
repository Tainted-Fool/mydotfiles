-- Use protected call so we know where error is coming from
local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    vim.notify("luasnip plugin was not found!")
    return
end

-- Declare variables
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt -- format string -> (<string>, {..nodes})
local rep = require("luasnip.extras").rep -- repeat a node
local i = ls.insert_node -- a position like $1 -> i(<position>, [default_text])

ls.snippets = {
    -- Snippets available for all filetypes
    all = {ls.parser.parse_snippet("expand", "-- this from the snippet file!")},

    -- Snippets available for lua filetype
    lua = { -- Local function
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"), -- Sample
    s("req", fmt("local {} = require('{}')", {i(1, "default"), rep(1)}))}
}
