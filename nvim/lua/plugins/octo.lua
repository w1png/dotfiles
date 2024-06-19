return {
	"pwntester/octo.nvim",
	opts = {
		enable_builtin = true,
		default_to_projects_v2 = true,
		default_merge_method = "squash",
		picker = "telescope",
	},
	config = function()
		require("octo").setup()
	end,
}
