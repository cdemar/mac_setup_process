return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		-- We don't directly call lazy.status here, as its API for 'loaded' isn't
		-- meant for direct function calls like this in a string concat.
		-- Instead, we'll ensure lazy.nvim is properly set up to give us stats.

		-- Your ASCII Art Header
		dashboard.section.header.val = {
			"                                                       ",
			"   ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓  ",
			"   ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒  ",
			"  ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░  ",
			"  ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██   ",
			"  ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒  ",
			"  ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░  ",
			"  ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░  ",
			"     ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░     ",
			"           ░    ░  ░    ░ ░        ░   ░         ░     ",
			"                                  ░                    ",
		}

		-- Display Neovim stats
		-- Use pcall to safely attempt to get lazy.nvim status,
		-- or provide a fallback if lazy.nvim isn't fully loaded or available yet.
		local lazy_stats_str = ""
		local ok, lazy_status = pcall(require, "lazy.status")
		if ok and lazy_status and type(lazy_status) == "table" and lazy_status.loaded and lazy_status.total then
			lazy_stats_str = lazy_status.loaded() .. " / " .. lazy_status.total() .. " plugins loaded"
		else
			lazy_stats_str = "Plugin stats not available"
		end

		dashboard.section.footer.val = {
			" ",
			" " .. lazy_stats_str,
		}

		-- Menu Buttons
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰱼  Find File", ":Telescope find_files <CR>"),
			dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
			dashboard.button("g", "  Find Word", ":Telescope live_grep <CR>"),
			dashboard.button("s", "󰁯  Restore Session", ":SessionRestore <CR>"),
			dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
		}

		-- Set the theme
		alpha.setup(dashboard.opts)

		-- Disable folding on the alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
