return {
	-- Declare the main LSP configuration plugin
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- Trigger plugin on buffer read or new file
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP autocompletion integration with nvim-cmp
		{ "antosha417/nvim-lsp-file-operations", config = true }, -- Adds file operation commands for LSP
		{ "folke/neodev.nvim", opts = {} }, -- Development environment for Neovim Lua plugins
	},
	config = function()
		-- Import required modules
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap -- Reference to vim keymap for setting keybindings

		-- Create keybindings once an LSP server attaches to a buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true } -- Set options for keybindings scoped to buffer

				-- Define LSP-related keymaps with descriptions
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Get default capabilities including completion support
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Customize diagnostic signs in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type -- Create highlight group name
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" }) -- Define sign with icon and highlight
		end

		-- Ensure required language servers are installed with Mason
		mason_lspconfig.setup({
			ensure_installed = { "lua_ls", "emmet_ls" }, -- Automatically install these servers if missing
		})

		-- List of servers for manual configuration
		local servers = { "lua_ls", "emmet_ls" }

		-- Loop over each server and apply its configuration
		for _, server_name in ipairs(servers) do
			local opts = {
				capabilities = capabilities, -- Attach capabilities to each server
			}

			-- Configure emmet_ls with filetypes
			if server_name == "emmet_ls" then
				opts.filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte", -- Supported file types for emmet
				}
			end

			-- Configure lua_ls with Neovim-specific settings
			if server_name == "lua_ls" then
				opts.settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "require" }, -- Avoid undefined global warnings for vim and require
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Include all runtime files for better completions
							checkThirdParty = false, -- Disable third-party plugin checks for simplicity
						},
						completion = {
							callSnippet = "Replace", -- Adjust snippet handling for Lua
						},
					},
				}
			end

			-- Apply the final configuration to each server
			lspconfig[server_name].setup(opts)
		end
	end,
}
