local function ConvertTSImports()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for i, line in ipairs(lines) do
		if string.find(line, '"@/') then
			local new_line = string.gsub(line, '"@/', '"~/')
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end

		if string.find(line, "'@/") then
			local new_line = string.gsub(line, "'@/", "'~/")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end

vim.keymap.set("n", "<leader>cm", ConvertTSImports)
