vim.cmd([[
set encoding=utf-8
set relativenumber
set wildmenu
set tabstop=2
set shiftwidth=2
set mouse=a
set nowrap
set nobackup
set noswapfile
set nohlsearch
set scrolloff=10
set cursorline
set cursorcolumn
hi LineNrAbove guifg=white
hi LineNrBelow guifg=white
autocmd! bufreadpost *.ejs syntax off
]])

local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-fugitive' 
Plug 'ap/vim-css-color'
Plug 'neovim/nvim-lspconfig'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.4' })
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('prettier/vim-prettier', {
  ['do'] = 'yarn install --frozen-lockfile --production',
  ['for'] = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html' } })
Plug 'simrat39/rust-tools.nvim'
Plug('ThePrimeagen/vim-be-good', { ['on'] = 'VimBeGood' })

vim.call("plug#end")

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.g.gruvbox_transparent_bg = 1
vim.cmd("autocmd VimEnter * hi Normal ctermbg=none")
vim.cmd("colo gruvbox")

require("rust-tools").setup()

local lspconfig = require'lspconfig'
lspconfig.tsserver.setup{}

require("nvim-tree").setup({
	filters = {
		dotfiles = false,
		custom = { "^.git$" },
		exclude = { ".env" }
	}
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}

require("telescope").setup({
	pickers = { find_files = { no_ignore = true, hidden = true } },
	defaults = { 
		file_ignore_patterns = { ".git/", "node_modules" },
	}
})

require("tokyonight").setup({
  style = "moon", 
  transparent = true,
  terminal_colors = true, 
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark", 
  },
	sidebars = { "qf", "help" }, 
	day_brightness = 0.3,
	hide_inactive_statusline = false,
	dim_inactive = false,
	lualine_bold = false, 
	on_colors = function(colors) end,
	on_highlights = function(highlights, colors) end,
})

vim.g.airline_powerline_fonts = 1
vim.g.airline_ = 1
vim.g.airline_theme = 'gruvbox'
-- vim.g.airline_theme = 'violet'
vim.g.airline_extensions_tabline = 1

vim.api.nvim_set_keymap("i", "<c-space>", "coc#refresh()", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("n", "<C-c>", ":wa | NvimTreeClose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":wa | NvimTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":wa | NvimTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-m>", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":Telescope oldfiles<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.cmd([[
	autocmd FileType rust nnoremap <silent> <C-s> :silent %! rustfmt<CR>
	autocmd FileType javascript nnoremap <silent> <C-s> :Prettier<CR>
	autocmd FileType cpp setlocal expandtab tabstop=2 shiftwidth=4
]])

