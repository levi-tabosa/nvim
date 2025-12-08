vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
local map = vim.keymap.set

-- Mapeamento para buscar texto selecionado com Ctrl+f
map("v", "<C-f>", "y/<C-R>=escape(@\", '/\\')<CR><CR>", { desc = "Search selected text" })

-- Mostra mensagens
map("n", "<leader>mm", ":messages<CR>", { desc = "Show messages" })

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
map({ "x", "n" }, "<C-v>", '"+p', { desc = "Paste from clipboard" })
map("i", "<C-v>", '<Esc>"+p', { desc = "Paste from clipboard" })
map("n", "<C-f>", "/", { desc = "Search" })
map("n", "<C-h>", ":%s/", { desc = "Replace" })
map("n", "<C-S-k>", "dd", { desc = "Delete current line" })
map("i", "<C-S-k>", "<Esc>ddi", { desc = "Delete current line (insert)" })
map("v", "<C-S-k>", "d", { desc = "Delete selection" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("n", "<A-k>", function()
  if vim.fn.line(".") > 1 then
    vim.cmd(":m .-2<CR>==")
  end
end, { desc = "Move line up" })
map("n", "<A-j>", function()
  if vim.fn.line(".") < vim.fn.line("$") then
    vim.cmd(":m .+1<CR>==")
  end
end, { desc = "Move line down" })
map("i", "<A-j>", function()
  if vim.fn.line(".") < vim.fn.line("$") then
    vim.cmd(":m .+1<CR>==gi")
  end
end, { desc = "Move line down (insert)" })
map("i", "<A-k>", function()
  if vim.fn.line(".") > 1 then
    vim.cmd(":m .-2<CR>==gi")
  end
end, { desc = "Move line up (insert)" })

-- Start selection in Normal Mode
map('n', '<S-Left>', 'v<Left>')
map('n', '<S-Right>', 'v<Right>')
map('n', '<S-Up>', 'v<Up>')
map('n', '<S-Down>', 'v<Down>')
map('n', '<C-S-Left>', 'v<C-Left>')
map('n', '<C-S-Right>', 'v<C-Right>')
map('n', '<S-End>', 'v<End>')

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

-- Tab management
map("n", "<C-PageUp>", ":-tabnext<CR>", { desc = "Previous tab" })
map("n", "<C-PageDown>", ":+tabnext<CR>", { desc = "Next tab" })
map("n", "<A-t>", ":tabnew<CR>", { desc = "New tab" })
map("n", "<A-q>", ":tabclose<CR>", { desc = "Close tab" })

-- Split management
map("n", "<C-=>", "<C-w>=", { desc = "Equalize split sizes" })
map("n", "<A-w>", ":vsplit<CR>", { desc = "New vertical split" })
map("n", "<A-S-w>", ":split<CR>", { desc = "New horizontal split" })

-- Move between splits with Alt + Arrow keys
map("n", "<A-Left>", "<C-w>h", { desc = "Focus left window" })
map("n", "<A-Right>", "<C-w>l", { desc = "Focus right window" })
map("n", "<A-Up>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<A-Down>", "<C-w>j", { desc = "Focus lower window" })

-- Resize splits with Alt + Shift + Arrow
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
    if name:match("^user") then
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
  { "Mofiqul/dracula.nvim",        lazy = true },

  -- VSCode dark+ theme
  {
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

  -- Tokyonight
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.o.background = "dark"
    end
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
      })
    end
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.o.background = "dark"
      require("gruvbox").setup({
        contrast = "hard",
      })
    end
  },

  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.o.background = "dark"
    end
  },

  -- OneDark
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker"
      })
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
          git_ignored = false,
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

      map("n", "<A-b>", function()
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
        if buf_ft == "NvimTree" then
          api.tree.close()
          return
        end
        if vim.bo.modified then
          local choice = vim.fn.confirm(
            "Buffer has unsaved changes. Save before closing?",
            "&Yes\n&No\n&Cancel",
            1
          )
          if choice == 1 then
            vim.cmd("write")
          elseif choice == 3 then
            return
          end
        end
        vim.cmd("bdelete")
        if vim.bo.filetype == "NvimTree" then
          api.tree.close()
        end
      end, { desc = "Close buffer with save prompt and auto-close nvim-tree" })
    end
  },

  -- Embedded Terminal
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
        shade_terminals = false,
      })

      function _G.find_project_root(bufnr)
        bufnr = bufnr or 0
        local buf_path = vim.api.nvim_buf_get_name(bufnr)
        if buf_path == "" then
          return vim.fn.getcwd()
        end
        local root_markers = { ".git" }
        local start_dir = vim.fn.fnamemodify(buf_path, ":p:h")
        local project_root = vim.fs.find(root_markers,
          { path = start_dir, upward = true, type = "file_or_dir", limit = 1 })
        if project_root and #project_root > 0 then
          return vim.fn.fnamemodify(project_root[1], ":p:h")
        else
          return start_dir
        end
      end

      _G.project_terminals = {}

      function _G.ToggleProjectTerminal()
        if vim.bo.buftype == 'terminal' then
          local current_term_bufnr = vim.api.nvim_get_current_buf()
          for _, term in pairs(_G.project_terminals) do
            if term and term.bufnr and term.bufnr == current_term_bufnr then
              term:toggle()
              return
            end
          end
          require('toggleterm').toggle(0)
          return
        end

        if vim.bo.buftype ~= "" and vim.bo.buftype ~= "nofile" then
          print("ToggleTerm: Cannot create a terminal for this buffer type.")
          return
        end

        local project_root = _G.find_project_root()
        local term = _G.project_terminals[project_root]

        if term and term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
          term:toggle()
          return
        end

        local Terminal = require("toggleterm.terminal").Terminal
        local new_term = Terminal:new({
          cwd = project_root,
          hidden = true,
          direction = "float",
        })

        _G.project_terminals[project_root] = new_term
        new_term:toggle()
      end

      map('n', '<c-t>', '<cmd>lua _G.ToggleProjectTerminal()<CR>', {
        noremap = true,
        silent = true,
        desc = "Toggle Project-local terminal"
      })

      map('t', '<c-t>', '<C-\\><C-n><cmd>lua _G.ToggleProjectTerminal()<CR>', {
        noremap = true,
        silent = true,
        desc = "Toggle Project-local terminal"
      })
    end,
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
      map("n", "<leader>dd", builtin.diagnostics, { desc = "Show all diagnostics" })
      map("n", "<leader>db", function()
        builtin.diagnostics({ bufnr = 0 })
      end, { desc = "Show buffer diagnostics" })
    end
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
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
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "go", "rust", "c", "zig" },
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

  -- Git stuff
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
          pyright = function()
            require('lspconfig').pyright.setup({
              settings = {
                python = {
                  pythonPath = "/usr/bin/python3",
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                  },
                },
              },
            })
          end,
          zls = function()
            require('lspconfig').zls.setup({
              settings = {
                zls = {
                  zig_lib_path = "/snap/zig/14937/lib",
                }
              }
            })
          end,
          lsp.default_setup,
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

  -- Commenting plugin
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        mappings = {
          basic = false,
          extra = false,
        },
      })

      local api = require('Comment.api')

      map('n', '<leader>cc', function()
        api.toggle.linewise.current()
      end, { desc = 'Toggle comment (linewise)' })

      map('x', '<leader>cc', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = 'Toggle comment (visual)' })

      map('n', '<leader>bb', function()
        api.toggle.blockwise.current()
      end, { desc = 'Toggle comment (block)' })

      map('x', '<leader>bb', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.blockwise(vim.fn.visualmode())
      end, { desc = 'Toggle comment (block visual)' })
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

  -- Lua snippets
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
      vim.g.VM_maps = {
        ['Find Next']       = '<C-d>',
        ['Find Prev']       = '<C-D>',
        ['Find All']        = '<C-L>',
        ['Skip Region']     = '<A-s>',
        ['Remove Region']   = '<A-r>',
        ['Add Cursor Down'] = '<C-S-Down>',
        ['Add Cursor Up']   = '<C-S-Up>',
        ['Comment Line']    = '<leader>cc',
        ['Comment Block']   = '<leader>bb',
      }
      vim.g.VM_actions = {
        ['change'] = 'c',
        ['insert'] = 'i',
        ['append'] = 'a',
      }
    end,
  },

  -- Neoscroll
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({
        easing_function = "quadratic",
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = true,
        cursor_scrolls_alone = true,
        mappings = {}
      })

      local t = {}

      t['<C-Up>'] = function()
        require('neoscroll').scroll(-vim.wo.scroll, { move_cursor = true, duration = 300 })
      end
      t['<C-Down>'] = function()
        require('neoscroll').scroll(vim.wo.scroll, { move_cursor = true, duration = 300 })
      end
      t['<ScrollWheelUp>'] = function()
        require('neoscroll').scroll(-8, { move_cursor = true, duration = 80 })
      end
      t['<ScrollWheelDown>'] = function()
        require('neoscroll').scroll(8, { move_cursor = true, duration = 80 })
      end
      t['<A-ScrollWheelUp>'] = function()
        require('neoscroll').scroll(-17, { move_cursor = true, duration = 80 })
      end
      t['<A-ScrollWheelDown>'] = function()
        require('neoscroll').scroll(17, { move_cursor = true, duration = 80 })
      end

      for key, func in pairs(t) do
        vim.keymap.set({ 'n', 'x' }, key, func, { noremap = true, silent = true })
      end
    end
  },
})

-- Autocommand for formatting
local format_on_save_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.html", "*.css", "*.go", "*.rs", "*.c", "*.zig" },
  callback = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ async = false })
        return
      end
    end
  end,
  group = format_on_save_group,
})
