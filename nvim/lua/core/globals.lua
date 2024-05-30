-- print tables
P = function(val)
  print(vim.inspect(val))
  return val
end

-- reload config
RELOAD = function(...)
  return require("plenary.reload").reload(...)
end

-- reload config
R = function(name)
  RELOAD(name)
  return require(name)
end

-- print buffer filetype
B = function()
  return vim.notify(vim.bo.filetype)
end

-- print server capabilities
-- =vim.lsp.get_active_clients()[4].server_capabilities
-- S = function()
--     return vim.lsp.get_active_clients()
-- end
