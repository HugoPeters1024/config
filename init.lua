require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'morhetz/gruvbox'
  use 'arcticicestudio/nord-vim'
  use 'EdenEast/nightfox.nvim'
  use "romainl/Apprentice"
  use "folke/tokyonight.nvim"

  -- Direnv
  use 'direnv/direnv.vim'

  use 'tidalcycles/vim-tidal'


  -- Whitespace
  use {
    'johnfrankmorgan/whitespace.nvim',
    config = function ()
        require('whitespace-nvim').setup({
            -- configuration options and their defaults

            -- `highlight` configures which highlight is used to display
            -- trailing whitespace
            highlight = 'DiffDelete',

            -- `ignored_filetypes` configures which filetypes to ignore when
            -- displaying trailing whitespace
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
        })

        -- remove trailing whitespace with a keybinding
        vim.keymap.set('n', 'tt', require('whitespace-nvim').trim)
    end
  }

  -- Git blame
  use 'f-person/git-blame.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- Git permalink
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Git diffs
  use "sindrets/diffview.nvim"

  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
--      {'rafamadriz/friendly-snippets'},
    }
  }

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function()
      require("fidget").setup {
        -- options
      }
    end,
  }

  use 'tikhomirov/vim-glsl'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-treesitter/nvim-treesitter'
  use 'akinsho/toggleterm.nvim'
  use 'lervag/vimtex'
  use 'mattn/emmet-vim'

  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'isti115/agda.nvim'

  use 'preservim/nerdtree'
  use 'PhilRunninger/nerdtree-buffer-ops'

  use 'lambdalisue/suda.vim'

  use 'github/copilot.vim'
end)

require('mason').setup({
  PATH = "append",
})
require("mason-lspconfig").setup {
    ensure_installed = { "pylsp" },
    automatic_installation = { exclude = { } },
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "latex" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("toggleterm").setup{}
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- strip whitespaces on save
vim.cmd('autocmd BufWritePre * lua require("whitespace-nvim").trim()')

local lsp = require('lsp-zero')

lsp.configure('hls', {
  manageHLS = 'PATH'
})

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = '●', -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = false,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
  ["*"] = true,
}

-- git blame
vim.g.gitblame_enabled = 0

local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', 'gb', ':GitBlameToggle<cr>', bufopts)

-- git linker
require"gitlinker".setup()



local cmp = require('cmp')
lsp.nvim_workspace()
lsp.setup_nvim_cmp({
   mapping = lsp.defaults.cmp_mappings({
     ['<C-J>'] = cmp.mapping(function(fallback)
      vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
     end)
   }),
   sources = {
     {name = 'path'},
     {name = 'nvim_lsp', keyword_length = 1},
     {name = 'buffer', keyword_length = 1},
   },
})
lsp.setup()

-- status of the LSP
require("fidget").setup{}

local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', 'qf', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'qr', vim.lsp.buf.format, bufopts)

require('telescope').load_extension('fzf')
local telescope = require('telescope.builtin')
vim.keymap.set('n', 'ff', telescope.find_files, {})
vim.keymap.set('n', 'fg', telescope.live_grep, {})
vim.keymap.set('n', 'fe', telescope.diagnostics, {})
vim.keymap.set('n', 'fd', telescope.commands, {})


-- shift+R to reload config
-- vim.api.nvim_set_keymap('n', 'R', '<cmd>source ~/.config/nvim/init.lua<CR>', {noremap = true, expr=true})

-- Easy buffer navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap=true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap=true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap=false})
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap=true})

-- Normal mode with jk
vim.keymap.set('i', 'jk', '<Esc>', {noremap=true, silent=true})
--vim.keymap.set('i', '<Esc>', '', {noremap=true})

vim.keymap.set('n', '<F4>', ':colorscheme gruvbox<CR>', {noremap=true})
vim.keymap.set('n', '<F5>', ':colorscheme nordfox<CR>', {noremap=true})
vim.keymap.set('n', '<F6>', ':colorscheme dayfox<CR>', {noremap=true})

vim.api.nvim_exec([[
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
]], false)

-- Terminal
vim.keymap.set('n', '`', ':ToggleTerm direction=horizontal<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '~', ':ToggleTerm direction=float<CR>', {noremap=true, silent=true})

-- NERDTree
vim.keymap.set('n', '<C-q>', ':NERDTreeToggle<CR>', {noremap=true, silent=true})

-- Persistent undo
vim.api.nvim_exec([[
if has('persistent_undo')
  set undofile
  set undodir=$HOME/.vim/undo
  endif
]], false)

vim.keymap.set('n', '<F1>', ':NERDTreeToggle<CR>', {noremap=true, silent=true})

-- Basic settings
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.scrolloff = 8
vim.opt.smarttab = true
pcall(vim.cmd,'set mouse=')
pcall(vim.cmd, 'set ttymouse=')

vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
pcall(vim.cmd, 'colorscheme nordfox')

vim.g.vimtex_compiler_latexmk = {
  options = {'-pdf', '-shell-escape', '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode'}
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

-- Tidal group
vim.api.nvim_exec("let g:tidal_no_mappings = 1", false)
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'tidal',
	group = vim.api.nvim_create_augroup('tidalcycles_only_keymap', { clear = true }),
	callback = function ()
    vim.keymap.set('n', '<S-k>', ":TidalSend<CR>", opts)
    vim.keymap.set('v', '<S-k>', ":TidalSend<CR>", opts)
    vim.keymap.set('n', '<S-o>', ":TidalHush<CR>", opts)
	end,
})

