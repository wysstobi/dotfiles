local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

-- sends either all files, or if files are selected, all selected files to qf list
local smart_send_to_qflist = function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 0 then
        -- only send selected
        actions.send_selected_to_qflist(prompt_bufnr)
    else
        -- send all files
        actions.send_to_qflist(prompt_bufnr)
    end
    actions.open_qflist(prompt_bufnr)
end

require('telescope').setup({
  defaults = {
    file_ignore_patterns = { 'elm-stuff', 'node_modules', '.git' },
    mappings = {
      i = {
        ["<C-q>"] = smart_send_to_qflist,  -- für Insert-Modus
      },
      n = {
        ["<C-q>"] = smart_send_to_qflist,  -- für Normal-Modus
      },
    },
  }
})

-- indicates whether hidden files should be shown
local hidden = false

vim.keymap.set('n', '<leader>g', builtin.git_files, {}) -- only looks for files managed by git
vim.keymap.set('n', '<leader>sf', function() builtin.find_files({hidden = hidden}) end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function() builtin.live_grep({hidden = hidden}) end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>hf', function()
  hidden = not hidden
  print("Show hidden files: " .. tostring(hidden))
end, { desc = 'Swap search [H]idden [F]iles' })

vim.keymap.set('n', '<leader>x', function()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc ='[/] Fuzzily search in current buffer' })
