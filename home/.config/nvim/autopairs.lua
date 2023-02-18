local autopairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

autopairs.setup({
    map_cr = false,
    check_ts = true,
    disable_filetype = { "TelescopePrompt" , "vim" },
})

-- Rust: Vec<u32>, Option<Result<String>>, <T: AsRef<String>>
local basic_rules = require('nvim-autopairs.rules.basic')
autopairs.add_rule(
    basic_rules.bracket_creator(autopairs.config)("<", ">", "rust")
        :with_pair(cond.before_regex("%w"))
)

-- Integrate with coc.nvim
_G.MUtils= {}

MUtils.completion_confirm=function()
    if vim.fn["coc#pum#visible"]() ~= 0  then
        return vim.fn["coc#pum#confirm"]()
    else
        return autopairs.autopairs_cr()
    end
end

vim.api.nvim_set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
