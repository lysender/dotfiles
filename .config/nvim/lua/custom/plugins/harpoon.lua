return {
	"ThePrimeagen/harpoon",
	name = "harpoon",
	branch = "harpoon2",
	requires = { { "nvim-lua/plenary.nvim" } },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<C-p>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-p>l", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<C-p>1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-p>2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-p>3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-p>4", function()
			harpoon:list():select(4)
		end)
	end,
}
