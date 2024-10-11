return {
	"NTBBloodbath/color-converter.nvim",
	config = function()
		local function to_hsl()
			require("color-converter").to_hsl()
			local current_line = vim.api.nvim_get_current_line()
			local new_line = current_line:gsub("hsl%((%d+),%s*([%d%.]+)%%,%s*([%d%.]+)%%%)", "%1 %2%% %3%%")
			vim.api.nvim_set_current_line(new_line)
		end

		vim.keymap.set("n", "<leader>cc", to_hsl, { desc = "Convert HSL to Hex" })
	end,
}
