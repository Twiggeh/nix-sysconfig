local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	print("Could not find treesitter")
	return
end

local function isDisabled(lang, bufnr, module)
	local disabled = vim.api.nvim_buf_line_count(bufnr) > 7000;
	if disabled then 
		print(module .. " is disabled in this buffer.")
	end
		return disabled
end

configs.setup {
	ensure_installed = "all", -- one of "all", or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true,
		disable = function(lang, bufnr)
			return isDisabled(lang, bufnr, "Highlighting")
		end,
		additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		disable = function(lang, bufnr)
			return isDisabled(lang, bufnr, "Incremental Selection")
		end,
	},
	indent = { 
		enable = true,
		disable = function(lang, bufnr)
			return isDisabled(lang, bufnr, "Indentation")
		end,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		disable = function(lang, bufnr)
			return isDisabled(lang, bufnr, "Context Commentstring")
		end,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 9000,
		disable = function(lang, bufnr)
			return isDisabled(lang, bufnr, "Rainbow")
		end,
	},
}
