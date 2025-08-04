
-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Basic settings
vim.opt.number = true          -- Line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 2            -- 2 spaces per tab
vim.opt.shiftwidth = 2         -- 2 spaces for indentation
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.mouse = "a"            -- Enable mouse support
vim.opt.termguicolors = true   -- Enable true 24-bit colors
vim.opt.cursorline = true      -- Highlight current line
vim.opt.signcolumn = "yes"     -- Always show sign column

-- VS Code-like key mappings
local map = vim.keymap.set

-- Navigation
map("n", "<Up>", "gk", { desc = "Move up (visual lines)" })
map("n", "<Down>", "gj", { desc = "Move down (visual lines)" })
map("n", "<Left>", "h", { desc = "Move left" })
map("n", "<Right>", "l", { desc = "Move right" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- File operations
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
map("n", "<C-w>", ":q<CR>", { desc = "Close window" })

-- Editing
map("i", "<C-z>", "<Esc>ua", { desc = "Undo" })
map("i", "<C-y>", "<Esc><C-r>a", { desc = "Redo" })
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
map("n", "<C-c>", '"+yy', { desc = "Copy line to clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut to clipboard" })
map("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
-- Search/Replace
map("n", "<C-f>", "/", { desc = "Search" })
map("v", "<C-f>", "/", { desc = "Search" })
map("n", "<C-h>", ":%s/", { desc = "Replace" })

-- Window management
map("n", "<C-=>", "<C-w>=", { desc = "Equalize window sizes" })
map("n", "<A-w>", ":vnew<CR>", { desc = "New vertical window" })

-- Install package manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin configuration
require("lazy").setup({
  -- File explorer (VS Code-like sidebar)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local nvim_tree = require("nvim-tree")
      local api = require("nvim-tree.api")

      nvim_tree.setup({
        view = {
          side = "right",
        },
        filters = {
          dotfiles = false,
        },
      })

    vim.keymap.set("n", "<A-b>", function()
        if api.tree.is_visible() then
          if api.tree.is_tree_buf() then
            vim.cmd("wincmd p")
          else
            api.tree.focus()
          end
        else
          api.tree.open({ focus = true })
        end
      end, { desc = "Toggle focus on nvim-tree" })

      map("n", "<C-b>", api.tree.toggle, { desc = "Toggle file explorer"} )
      map("n", "<A-f>", ":NvimTreeFindFile<CR>", { desc = "Focus file explorer" })
    end
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep"  -- Recommended for better search
    },
    config = function()
      local builtin = require("telescope.builtin")
      map("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      map("n", "<C-g>", builtin.live_grep, { desc = "Search in files" })
    end
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = "auto" }
      })
    end
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css"},
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  },

  -- Auto closing brackets/quotes
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
  -- git stuff
  {
    "tpope/vim-fugitive",
    keys = {
      {"<leader>gs", ":Git<CR>", desc = "Status"},
      {"<leader>gd", ":Gdiff<CR>", desc = "Diff"},
      {"<leader>gc", ":Git commit<CR>", desc = "Commit"},
      {"<leader>gp", ":Git push<CR>", desc = "Push"},
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' }
        }
      })
    end
  },
  -- LSP
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v2.x',
    dependencies = {
      {'neovim/nvim-lspconfig'},
      {'hrsh7th/nvim-cmp'}, -- Autocompletion
      {'hrsh7th/cmp-nvim-lsp'}, -- LSP source
      {'L3MON4D3/LuaSnip'}, -- Snippets
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
  -- Zig-specific keymaps
        vim.keymap.set('n', '<leader>zf', function() vim.lsp.buf.formatting() end, {buffer = bufnr, desc = "Format Zig"})
      end)
  -- Configure ZLS specifically
      require('lspconfig').zls.setup({
        cmd = {'zls'},
        filetypes = {'zig'},
        settings = {
          zls = {
            enable_semantic_tokens = true,
            warn_style = true,
            enable_snippets = true,
          }
        },
        single_file_support = true,
      })

      lsp.setup()    
    end
  }, 
  -- VS Code-like icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end
  },

  -- Dracula theme
  {
    "Mofiqul/dracula.nvim",
    config = function()
      vim.cmd.colorscheme("dracula")
    end
  },

  -- Embeded Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float"
      })
    end
  },
})

