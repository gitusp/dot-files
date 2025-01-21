return {
  "machakann/vim-sandwich",
  init = function()
    vim.g.sandwich_no_default_key_mappings = 1
    vim.g.operator_sandwich_no_default_key_mappings = 1
  end,
  config = function()
    vim.cmd('runtime macros/sandwich/keymap/surround.vim')
  end,
}
