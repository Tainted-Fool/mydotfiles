-- Use protected call so we know where error is coming from
local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
	vim.notify("SchemaStore plugin was not found!")
	return
end

return {
	init_options = {
		provideFormatter = false,
	},
	settings = {
		json = {
			schemas = schemastore.json.schemas(),
		},
	},
	setup = {
		commands = {},
	},
}
