local status_ok, dap = pcall(require, "dap")
if not status_ok then
	print("Couldn't find dap installation")
	return
end

-- Mappings

local opts = { noremap = true, silent = true }

-- KEYMAP("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
KEYMAP("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", opts)
KEYMAP("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", opts)
KEYMAP("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", opts)

KEYMAP("n", "<leader>dp", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
KEYMAP("n", "<leader>dpp", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
KEYMAP("n", "<leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	opts)
KEYMAP("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)

-- Debug Adapters

dap.adapters.chrome = {
	type    = "executable",
	command = "node",
	args    = { os.getenv("HOME") .. "/.config/nvim/dap/vscode-chrome-debug/out/src/chromeDebug.js" }
}

local debug_chrome = {
	-- {
	-- 	name              = 'Attach Chrome',
	-- 	type              = "chrome",
	-- 	request           = "attach",
	-- 	runtimeExecutable = "/usr/bin/google-chrome-stable",
	-- 	cwd               = vim.fn.getcwd(),
	-- 	sourceMaps        = true,
	-- 	protocol          = "inspector",
	-- 	webRoot           = "${workspaceFolder}"
	-- },
	{
		name              = 'Attach Chrome',
		type              = "chrome",
		request           = "attach",
		runtimeExecutable = "/usr/bin/google-chrome-stable",
		outFiles          = { "${workspaceFolder}/dist/public/js/*.js" },
		--program           = "${file}",
		--cwd               = "/mnt/SSD/projects/work/gk/copy_newPlatform/client",
		sourceMaps        = true,
		protocol          = "inspector",
		port              = 9222,
		webRoot           = "/mnt/SSD/projects/work/gk/copy_newPlatform/client",
	}
}

dap.configurations.javascriptreact = debug_chrome
dap.configurations.typescriptreact = debug_chrome

dap.adapters.node2 = {
	type    = "executable",
	command = "node",
	args    = { os.getenv("HOME") .. '/.config/nvim/dap/vscode-node-debug2/out/src/nodeDebug.js' }
}

local node_debug = {
	{
		name       = 'Launch',
		type       = 'node2',
		request    = 'launch',
		program    = '${file}',
		cwd        = vim.fn.getcwd(),
		sourceMaps = true,
		protocol   = 'inspector',
		console    = 'integratedTerminal',
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name      = 'Attach to process',
		type      = 'node2',
		request   = 'attach',
		processId = require 'dap.utils'.pick_process,
	},
}

-- dap.configurations.javascript = node_debug
-- dap.configurations.typescript = node_debug

--Debug UI

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	print("Couldn't find dapui installation")
	return
end

dapui.setup()

-- AutoLaunch UI

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local nvim_dap_virtual_text_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not nvim_dap_virtual_text_ok then
	print("Couldn't find nvim-dap-virtual-text installation")
	return
end

-- Virtual Text

dap_virtual_text.setup({})

-- Local Debug Config

local p_cfg_utils_ok, p_cfg_utils = pcall(require, "projector.config_utils")
if not p_cfg_utils_ok then
	print("Couldn't find projector / projector.config_utils installation")
	return
end

p_cfg_utils.load_dap_configurations()
p_cfg_utils.load_project_configurations()

KEYMAP('n', '<F5>', "<Cmd>lua require'projector'.continue('all')<CR>", { noremap = true })
