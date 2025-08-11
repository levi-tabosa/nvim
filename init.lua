-- Using nvim-tree
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- Basic settings
vim.opt.number = true         -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 2           -- 2 spaces per tab
vim.opt.shiftwidth = 2        -- 2 spaces for indentation
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.mouse = "a"           -- Enable mouse support
vim.opt.termguicolors = true  -- Enable true 24-bit colors
vim.opt.cursorline = true     -- Highlight current line
vim.opt.signcolumn = "yes"    -- Always show sign column
vim.opt.wrap = false          -- Disable line wrapping by default

local map = vim.keymap.set

-- View Toggles and Scrolling
map("n", "<A-z>", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    vim.notify("Word wrap enabled", vim.log.levels.INFO, { title = "View" })
  else
    vim.notify("Word wrap disabled", vim.log.levels.INFO, { title = "View" })
  end
end, { desc = "Toggle word wrap" })

-- Leave terminal mode
map('t', '<C-space>', "<C-\\><C-n><C-w>h", { silent = true })

-- Navigation
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "<leader>pp", function()
  vim.opt.paste = not vim.opt.paste:get()
  if vim.opt.paste:get() then
    vim.notify("Paste mode enabled", vim.log.levels.INFO, { title = "Options" })
  else
    vim.notify("Paste mode disabled", vim.log.levels.INFO, { title = "Options" })
  end
end, { desc = "Toggle paste mode" })

map("n", "<leader>ww", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    vim.notify("Word wrap enabled", vim.log.levels.INFO, { title = "View" })
  else
    vim.notify("Word wrap disabled", vim.log.levels.INFO, { title = "View" })
  end
end, { desc = "Toggle word wrap" })

-- Scroll horizontally with Shift + Mouse Wheel
map({ "n", "v" }, "<S-ScrollWheelDown>", "7zl", { desc = "Scroll right" })
map({ "n", "v" }, "<S-ScrollWheelUp>", "7zh", { desc = "Scroll left" })

-- File operations
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
-- Changed <C-w> to close buffer instead of window/quit
map("n", "<C-w>", ":bdelete<CR>", { desc = "Close buffer (file tab)" })

-- Editing
map('n', '<C-;>', 'gcc', { noremap = false, desc = "Toggle comment line" })
map('v', '<C-;>', 'gc', { noremap = false, desc = "Toggle comment selection" })
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

-- Move between splits with Alt + Arrow keys
map("n", "<A-Left>", "<C-w>h", { desc = "Focus left window" })
map("n", "<A-Right>", "<C-w>l", { desc = "Focus right window" })
map("n", "<A-Up>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<A-Down>", "<C-w>j", { desc = "Focus lower window" })

-- resize splits with Alt + Shift + Arrow
map("n", "<A-S-Left>", "<C-w><", { desc = "Resize split left" })
map("n", "<A-S-Right>", "<C-w>>", { desc = "Resize split right" })
map("n", "<A-S-Up>", "<C-w>+", { desc = "Resize split up" })
map("n", "<A-S-Down>", "<C-w>-", { desc = "Resize split down" })

-- Move between tabs with Ctrl + PageUp/PageDown
map("n", "<C-PageUp>", ":-tabnext<CR>", { desc = "Previous tab" })
map("n", "<C-PageDown>", ":+tabnext<CR>", { desc = "Next tab" })

-- Alternative: Ctrl+Shift+[ / Ctrl+Shift+]
map("n", "<C-S-[>", ":-tabnext<CR>", { desc = "Previous tab" })
map("n", "<C-S-]>", ":+tabnext<CR>", { desc = "Next tab" })

-- Create and close tabs
map("n", "<A-t>", ":tabnew<CR>", { desc = "New tab" })
map("n", "<A-q>", ":tabclose<CR>", { desc = "Close tab" })

-- Start selection in Normal Mode
map('n', '<S-Left>', 'v<Left>')
map('n', '<S-Right>', 'v<Right>')
map('n', '<S-Up>', 'v<Up>')
map('n', '<S-Down>', 'v<Down>')
map('n', '<C-S-Left>', 'v<C-Left>')
map('n', '<C-S-Right>', 'v<C-Right>')

-- Extend selection in Visual Mode
map('v', '<S-Left>', '<Left>')
map('v', '<S-Right>', '<Right>')
map('v', '<S-Up>', '<Up>')
map('v', '<S-Down>', '<Down>')
map('v', '<C-S-Left>', '<C-Left>')
map('v', '<C-S-Right>', '<C-Right>')

-- Start selection from Insert Mode
map('i', '<S-Left>', '<Esc>v<Left>')
map('i', '<S-Right>', '<Esc>v<Right>')
map('i', '<S-Up>', '<Esc>v<Up>')
map('i', '<S-Down>', '<Esc>v<Down>')
map('i', '<C-S-Left>', '<Esc>v<C-Left>')
map('i', '<C-S-Right>', '<Esc>v<C-Right>')

-- Note: The Vim motions for word-wise movement are 'b' (back) and 'w' (forward).
-- The <C-Left> and <C-Right> keycodes might not work in all terminals.
-- If you have issues, you can use the more portable vim motions like this:
-- map({'n', 'v', 'i'}, '<C-S-Left>', '<Esc>vb') -- Start/extend selection one word back
-- map({'n', 'v', 'i'}, '<C-S-Right>', '<Esc>vw') -- Start/extend selection one word forward
-- You would need to separate them by mode as done above for the best experience.

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
  -- Dracula theme
  {
    "Mofiqul/dracula.nvim",
    priority = 1000, -- Make sure theme is loaded first
    config = function()
      vim.cmd.colorscheme("dracula")
    end
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local api = require("nvim-tree.api")
      require("nvim-tree").setup({
        view = {
          side = "right",
        },
        filters = {
          dotfiles = false,
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
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

      map("n", "<C-b>", api.tree.toggle, { desc = "Toggle file explorer" })
      map("n", "<A-f>", ":NvimTreeFindFile<CR>", { desc = "Focus file explorer" })
    end
  },

  -- Web Dev icons
  { "nvim-tree/nvim-web-devicons", lazy = true, priority = 100 },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
    config = function()
      local builtin = require("telescope.builtin")
      map("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      map("n", "<leader>f", builtin.live_grep, { desc = "Search in files (Grep)" })
      map("n", "<leader>b", builtin.buffers, { desc = "Find open buffers (files)" })
      map("n", "<leader>h", builtin.help_tags, { desc = "Find help tags" })
    end
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula-nvim", -- Match our theme
          icons_enabled = true,
          component_separators = '|',
          section_separators = '',
        }
      })
    end
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "go", "rust", "c", "zig", },
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  },

  -- Auto closing brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end
  },

  -- git stuff
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs = { add = { text = '│' }, change = { text = '│' }, delete = { text = '_' } }
      })
    end
  },

  -- LSP
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v2.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        -- Add more LSP keymaps here
        map('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
        map('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
        map('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
        map('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {
          -- ADDED zls
          'lua_ls',
          'pyright',
          'ts_ls',
          'jdtls',
          'rust_analyzer',
          'clangd',
          'zls',
        },
        handlers = { lsp.default_setup }
      })

      -- Configure the Lua server
      lsp.configure('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Configure cmp keymaps
      local cmp = require('cmp')
      lsp.setup_nvim_cmp({
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        })
      })

      lsp.setup()
    end
  },
  -- Embeded Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-t>]],
        direction = "float"
      })
    end
  },

  -- Commenting plugin
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
  },

  -- File tabs (bufferline)
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = "*",
    opts = {
      options = {
        mode = "buffers",
        show_buffer_close_icons = false,
        show_close_icon = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        }
      }
    }
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  -- Project management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
      require("telescope").load_extension("projects")
      map("n", "<leader>p", "<cmd>Telescope projects<CR>", { desc = "Find Projects" })
    end
  },
  -- Multi-Cursor Editing
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    init = function()
      -- Set the keymaps before the plugin loads
      vim.g.VM_maps = {
        ['Find Next'] = '<C-d>',
        ['Find Prev'] = '<C-a>',
        ['Find All'] = '<C-S-l>',
        ['Skip Region'] = '<C-x>',   -- Press Ctrl+D, then Ctrl+X to skip the current match and go to the next
        ['Remove Region'] = '<C-b>', -- Press Ctrl+D, then Ctrl+B to remove the last added cursor
        ['Add Cursor Down'] = '<C-A-Down>',
        ['Add Cursor Up'] = '<C-A-Up>',
      }
      -- Optional: Use 'i' and 'a' to enter insert mode at the start/end of selections
      vim.g.VM_actions = {
        ['change'] = 'c',
        ['insert'] = 'i',
        ['append'] = 'a',
      }
    end,
  },
})

local format_on_save_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
  group = format_on_save_group,
})
