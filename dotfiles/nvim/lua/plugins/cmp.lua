-- fix for supremaven and blink fighting for text.
-- will not preselect the first option unless you manually select
-- while still allowing for preview, enter selection and inesrting as normal
return {
	"Saghen/blink.cmp",
	opts = {
		completion = {
			list = {
				preselect = false,
			},
		},
	},
}

-- if true then
-- 	return {}
-- end

-- Use <tab> for completion and snippets (supertab)
-- first: disable default <tab> and <s-tab> behavior in LuaSnip

-- local function border(hl_name)
-- 	return {
-- 		{ "╭", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╮", hl_name },
-- 		{ "│", hl_name },
-- 		{ "╯", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╰", hl_name },
-- 		{ "│", hl_name },
-- 	}
-- end

-- return {
-- {
-- 	"L3MON4D3/LuaSnip",
-- 	keys = function()
-- 		return {}
-- 	end,
-- },
-- then: setup supertab in cmp
-- {
-- 	"hrsh7th/nvim-cmp",
-- 	dependencies = {
-- 		"hrsh7th/cmp-emoji",
-- 	},
--
-- 	--    ---@param opts cmp.ConfigSchema
-- 	opts = function(_, opts)
-- 		local has_words_before = function()
-- 			unpack = unpack or table.unpack
-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- 		end
--
-- 		local luasnip = require("luasnip")
-- 		local cmp = require("cmp")
--
-- 		opts.mapping = vim.tbl_extend("force", opts.mapping, {
-- 			["<Tab>"] = cmp.mapping(function(fallback)
-- 				if cmp.visible() then
-- 					cmp.select_next_item()
-- 				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
-- 				-- this way you will only jump inside the snippet region
-- 				elseif luasnip.expand_or_locally_jumpable() then
-- 					luasnip.expand_or_jump()
-- 				-- Not sure why, but need to take this out for it to work..
-- 				elseif has_words_before() then
-- 					cmp.complete()
-- 				else
-- 					fallback()
-- 				end
-- 			end, { "i", "s" }),
-- 			["<S-Tab>"] = cmp.mapping(function(fallback)
-- 				if cmp.visible() then
-- 					cmp.select_prev_item()
-- 				elseif luasnip.jumpable(-1) then
-- 					luasnip.jump(-1)
-- 				else
-- 					fallback()
-- 				end
-- 			end, { "i", "s" }),
-- 		})
--
-- 		-- opts.window = {
-- 		--   completion = cmp.config.window.bordered(),
-- 		--   documentation = cmp.config.window.bordered(),
-- 		-- }
--
-- 		opts.window = {
-- 			completion = {
-- 				side_padding = 1,
-- 				-- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
-- 				scrollbar = false,
-- 				border = border("CmpBorder"),
-- 			},
-- 			documentation = {
-- 				border = border("CmpDocBorder"),
-- 				winhighlight = "Normal:CmpDoc",
-- 			},
-- 		}
--
-- 		opts.sorting = {
-- 			comparators = {
-- 				cmp.config.compare.offset,
-- 				cmp.config.compare.exact,
-- 				cmp.config.compare.sort_text,
-- 				cmp.config.compare.score,
-- 				-- require("cmp-under-comparator").under,
-- 				cmp.config.compare.recently_used,
-- 				cmp.config.compare.kind,
-- 				cmp.config.compare.length,
-- 				cmp.config.compare.order,
-- 			},
-- 		}
-- 	end,
-- },
-- }
