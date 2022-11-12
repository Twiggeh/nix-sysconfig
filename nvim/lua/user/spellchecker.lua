local status_ok, spellsitter = pcall(require, "spellsitter")
if not status_ok then
	print("Plugin: spellsitter not found")
	return
end

spellsitter.setup({ enable = true })

