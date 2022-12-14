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
Plug 'ap/vim-css-color'
Plug 'glepnir/dashboard-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim'
Plug 'jiangmiao/auto-pairs'
Plug '907th/vim-auto-save'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-fugitive'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.0' })
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('prettier/vim-prettier', {
  ['do'] = 'yarn install --frozen-lockfile --production',
  ['for'] = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html' } })

vim.call("plug#end")

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local db = require("dashboard")

vim.g.gruvbox_transparent_bg = 1
vim.cmd("autocmd VimEnter * hi Normal ctermbg=none")
vim.cmd("colo gruvbox")

db.custom_center = {
	{ desc = "Open Project        ", action = "NvimTreeOpen" },
	{ desc = "Find File         ", action = "Telescope find_files", shortcut = "F7" },
	{ desc = "Recent Files      ", action = "Telescope oldfiles", shortcut = "F8" },
	{ desc = "Search Text       ", action = "Telescope live_grep", shortcut = "F9" },
	{ desc = "New File            ", action = ":new" },
	{ desc = "Exit                ", action = ":q"},
}

require'lspconfig'.tsserver.setup{}
-- require'lspconfig'.rls.setup{}

require("nvim-tree").setup({
	filters = {
		dotfiles = false,
		custom = { "^.git$" },
		exclude = { ".env" }
	}
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    disable = { "c", "rust" },
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

vim.g.auto_save = 1
vim.g.airline_powerline_fonts = 1
vim.g.airline_ = 1
vim.g.airline_theme = 'gruvbox'
-- vim.g.airline_theme = 'violet' // for tokyonight theme
vim.g.airline_extensions_tabline = 1

vim.api.nvim_set_keymap("i", "<c-space>", "coc#refresh()", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeOpen<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":NvimTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":Prettier<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F7>", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F8>", ":Telescope oldfiles<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F9>", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Left>", ":tabprevious<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Up>", ":tabfirst<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":tablast<CR>", { noremap = true })
