return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- add files to harpoon and quick access them
    -- when harpoon has been opened using ctrl+e files can be manipulated as if it were a normal file opened in vim
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    local harpoon = require("harpoon")
    
    harpoon.setup({
        menu = {
            width = vim.api.nvim_win_get_width(0) - 80,
        }
    })
    
    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    
    vim.keymap.set("n", "<C-q>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
  end
}
