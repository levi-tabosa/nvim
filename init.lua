vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- Basic settings
vim.opt.number = true         -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 2           -- 2 spaces per tab
vim.opt.shiftwidth = 2        -- 2 spaces for indentation
vim.opt.scrolloff = 8         -- Keep 8 lines of context above and below the cursor
vim.opt.sidescrolloff = 5     -- Keep 5 columns of context to the left and right
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.mouse = "a"           -- Enable mouse support
vim.opt.termguicolors = true  -- Enable true 24-bit colors
vim.opt.cursorline = true     -- Highlight current line
vim.opt.signcolumn = "yes"    -- Always show sign column
vim.opt.wrap = false          -- Disable line wrapping by default

local map = vim.keymap.set

-- Leave terminal mode
map('t', '<C-space>', "<C-\\><C-n><C-w>h", { silent = true })

-- Word wrap
map("n", "<A-z>", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    vim.notify("Word wrap enabled", vim.log.levels.INFO, { title = "View" })
  else
    vim.notify("Word wrap disabled", vim.log.levels.INFO, { title = "View" })
  end
end, { desc = "Toggle word wrap" })

-- Scroll vertically with Mouse Wheel
map({ "n", "v" }, "<ScrollWheelDown>", "8<C-e>", { desc = "Scroll down" })
map({ "n", "v" }, "<ScrollWheelUp>", "8<C-y>", { desc = "Scroll up" })

-- Scroll horizontally with Shift + Mouse Wheel
map({ "n", "v" }, "<S-ScrollWheelDown>", "12zl", { desc = "Scroll right" })
map({ "n", "v" }, "<S-ScrollWheelUp>", "12zh", { desc = "Scroll left" })

-- File operations
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })

-- Editing
map("i", "<C-z>", "<Esc>ua", { desc = "Undo" })
map("i", "<C-y>", "<Esc><C-r>a", { desc = "Redo" })
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("n", "<C-c>", '"+yy', { desc = "Copy line to clipboard" })
map("x", "<C-c>", '"+y', { desc = "Copy selection to clipboard" })
map("n", "<C-x>", '"+dd', { desc = "Cut line to clipboard" })
map("x", "<C-x>", '"+d', { desc = "Cut line to clipboard" })
map("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
map("x", "<C-v>", '"+p', { desc = "Paste from clipboard" })
map("n", "<C-f>", "/", { desc = "Search" })
map("v", "<C-f>", "/", { desc = "Search" })
map("n", "<C-h>", ":%s/", { desc = "Replace" })
map("n", "<C-S-k>", "dd", { desc = "Delete current line" })
map("i", "<C-S-k>", "<Esc>ddi", { desc = "Delete current line (insert)" })
map("v", "<C-S-k>", "d", { desc = "Delete selection" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down (insert)" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up (insert)" })

-- Start selection in Normal Mode
map('n', '<S-Left>', 'v<Left>')
map('n', '<S-Right>', 'v<Right>')
map('n', '<S-Up>', 'v<Up>')
map('n', '<S-Down>', 'v<Down>')
map('n', '<C-S-Left>', 'v<C-Left>')
map('n', '<C-S-Right>', 'v<C-Right>')

-- Extend selection in Visual Mode
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

map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "<leader>pp", function()
  vim.opt.paste = not vim.opt.paste:get()
  if vim.opt.paste:get() then
    vim.notify("Paste mode enabled", vim.log.levels.INFO, { title = "Options" })
  else
    vim.notify("Paste mode disabled", vim.log.levels.INFO, { title = "Options" })
  end
end, { desc = "Toggle paste mode" })

-- Buffer management
map("n", "<S-PageUp>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-PageDown>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-t>", ":enew<CR>", { desc = "New buffer" })
-- Delete buffer is with file explorer api handle further down the file

map("n", "<C-PageUp>", ":-tabnext<CR>", { desc = "Previous tab" })
map("n", "<C-PageDown>", ":+tabnext<CR>", { desc = "Next tab" })
map("n", "<A-t>", ":tabnew<CR>", { desc = "New tab" })
map("n", "<A-q>", ":tabclose<CR>", { desc = "Close tab" })

-- Window management
map("n", "<C-=>", "<C-w>=", { desc = "Equalize window sizes" })
map("n", "<A-w>", ":wnew<CR>", { desc = "New window" })
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

-- Theme switcher
local themes = { "dracula", "vscode", "tokyonight", "gruvbox", "catppuccin", "carbonfox", "onedark", "default" }
local current_theme = 1

function _G.CycleTheme()
  current_theme = current_theme + 1
  if current_theme > #themes then current_theme = 1 end
  vim.cmd("colorscheme " .. themes[current_theme])
  vim.notify("Theme: " .. themes[current_theme], vim.log.levels.INFO, { title = "Theme Switcher" })
end

-- Reload a Lua module
function _G.ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") then -- or your config namespace
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end

-- Keymap to reload config
map("n", "<leader>rr", ":lua ReloadConfig()<CR>", { desc = "Reload config" })
map("n", "<C-k>t", ":lua CycleTheme()<CR>", { desc = "Cycle themes" })

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
  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },

  {
    -- VSCode dark+ theme
    "Mofiqul/vscode.nvim",
    config = function()
      vim.o.background = "dark"
      require("vscode").setup({
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = true,
      })
    end
  },

  -- Tokyonight (has "storm", "night", "moon" variants, all dark)
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.o.background = "dark"
    end
  },

  -- Catppuccin (choose "mocha" for dark high contrast)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
      })
    end
  },

  -- Gruvbox high contrast dark
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.o.background = "dark"
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or ""
      })
    end
  },

  -- Nightfox theme pack (includes "carbonfox" = high contrast dark)
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.o.background = "dark"
    end
  },

  -- OneDark Pro (Atom/VSCode inspired)
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker" -- "dark", "darker", "cool", "deep", "warm", "warmer"
      })
    end
  }, -- File explorer
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
        update_focused_file = {
          enable = true,
          update_root = true,
          ignore_list = {},
        },
        respect_buf_cwd = true,
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
      map("n", "<S-w>", function()
        local buf_ft = vim.bo.filetype

        -- If in nvim-tree, just close it
        if buf_ft == "NvimTree" then
          api.tree.close()
          return
        end

        -- If buffer is modified, prompt user
        if vim.bo.modified then
          local choice = vim.fn.confirm(
            "Buffer has unsaved changes. Save before closing?",
            "&Yes\n&No\n&Cancel",
            1
          )

          if choice == 1 then
            vim.cmd("write") -- Save
          elseif choice == 3 then
            return           -- Cancel
          end
          -- choice == 2 means "No" → just close without saving
        end

        -- Close the current buffer
        vim.cmd("bdelete")

        -- If focus ends up on nvim-tree, close it too
        if vim.bo.filetype == "NvimTree" then
          api.tree.close()
        end
      end, { desc = "Close buffer with save prompt and auto-close nvim-tree" })
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
          theme = "dracula", -- Match our theme
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
      { 'onsails/lspkind.nvim' },
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls', 'pyright', 'ts_ls', 'jdtls', 'rust_analyzer', 'clangd', 'zls',
        },
        handlers = {
          lsp.default_setup,

          -- It will be called *instead* of the default one.
          zls = function()
            local lspconfig = require('lspconfig')
            lspconfig.zls.setup({
              settings = {
                zls = {
                  zig_lib_path = "/snap/zig/14937/lib",
                }
              }
            })
          end,
        }
      })

      local cmp = require('cmp')
      local lspkind = require('lspkind')

      lsp.setup_nvim_cmp({
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = '...',
            menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
            })
          })
        },
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
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = false,
        direction = "float",
        float_opts = {
          border = 'curved',
          winblend = 3,
        },
        close_on_exit = true,
      })

      -- This will store our terminals, keyed by the code buffer's number
      _G.buffer_terminals = {}

      function _G.ToggleBufferTerminal()
        if vim.bo.buftype == 'terminal' then
          local current_term_bufnr = vim.api.nvim_get_current_buf()
          local found_term = nil

          for _, term in pairs(_G.buffer_terminals) do
            if term and term.bufnr == current_term_bufnr then
              found_term = term
              break
            end
          end

          if found_term then
            found_term:toggle()
          else
            -- Fallback
            require('toggleterm').toggle(0)
          end
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()

        -- Prevent creating terminals for special buffers
        if vim.bo[bufnr].buftype ~= "" then
          print("ToggleTerm: Cannot create a terminal for this buffer type.")
          return
        end

        local term = _G.buffer_terminals[bufnr]

        if term then
          term:toggle()
        else
          local new_term = require("toggleterm.terminal").Terminal:new({
            -- We use the code buffer's number
            count = bufnr,
            hidden = true,
            direction = "float",
            on_close = function(t)
              -- Remove the terminal from table
              _G.buffer_terminals[t.count] = nil
            end,
          })

          new_term:toggle()
          _G.buffer_terminals[bufnr] = new_term
        end
      end

      vim.keymap.set('n', '<c-t>', '<cmd>lua _G.ToggleBufferTerminal()<CR>', {
        noremap = true,
        silent = true,
        desc = "Toggle buffer-local terminal"
      })

      vim.keymap.set('t', '<c-t>', '<C-\\><C-n><cmd>lua _G.ToggleBufferTerminal()<CR>', {
        noremap = true,
        silent = true,
        desc = "Toggle buffer-local terminal"
      })

      vim.api.nvim_create_autocmd("BufDelete", {
        pattern = "*",
        callback = function(args)
          local term = _G.buffer_terminals[args.buf]
          if term and term:is_open() then
            term:close()
          end
        end
      })
    end,
  },

  -- Commenting plugin
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        -- Create a custom mapping
        mappings = {
          basic = true, -- enable default mappings (gc, gb)
          extra = true, -- enable extra mappings (g<, g>, etc.)
        },
        -- Add a custom keymap for toggling
        toggler = {
          line = '<C-;>',    -- Maps 'gcc' to <C-;>
          block = '<C-A-;>', -- Example for block comments
        },
      })
    end,
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
        ['Find Next']       = '<C-d>',
        ['Find Prev']       = '<C-D>',
        ['Find All']        = '<C-L>',
        ['Skip Region']     = '<A-s>',
        ['Remove Region']   = '<A-r>',
        ['Add Cursor Down'] = '<C-Down>',
        ['Add Cursor Up']   = '<C-Up>',
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
