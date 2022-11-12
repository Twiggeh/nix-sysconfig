local status_ok, cinnamon = pcall(require, "cinnamon")
if not status_ok then
	print("couldn\'t find cinnamon")
	return
end

cinnamon.setup {
  extra_keymaps = true,
  scroll_limit = 100,
}
