vim.cmd([[
set encoding=utf-8
set relativenumber
set wildmenu
set tabstop=2
set shiftwidth=2
set number
set expandtab
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

Plug 'mrcjkb/rustaceanvim'
Plug('ThePrimeagen/harpoon', { ['branch'] = 'harpoon2' })
Plug 'lvimuser/lsp-inlayhints.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-fugitive' 
Plug 'neovim/nvim-lspconfig'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.4' })
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('prettier/vim-prettier', {
  ['for'] = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html' } })
Plug('neoclide/coc.nvim', { ['build'] = { ['unix'] = 'yarn install --frozen-lockfile' } })
-- Plug 'lukas-reineke/indent-blankline.nvim'

vim.call("plug#end")

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("colo gruvbox")

vim.g.gruvbox_transparent_bg = 1
vim.cmd("autocmd VimEnter * hi Normal ctermbg=none")

vim.g.rustaceanvim = {
  inlay_hints = {
    highlight = "NonText",
  },
  server = {
    on_attach = function(client, bufnr) 
      client.server_capabilities.semanticTokensProvider = nil 
      vim.api.nvim_set_keymap("n", "<C-n>", ":RustLsp hover actions<CR>", { noremap = true })
      local inlayhints = require("lsp-inlayhints"); -- resenje samo dok se ne prebacim na nvim 0.10 koji ima native inlay hints
      inlayhints.setup()
      inlayhints.on_attach(client, bufnr)
      inlayhints.show()
    end,
  },
}

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

local harpoon = require("harpoon")
harpoon.setup()

vim.g.airline_powerline_fonts = 1
vim.g.airline_ = 1
vim.g.airline_theme = 'gruvbox'
vim.g.airline_extensions_tabline = 1

vim.api.nvim_set_keymap("i", "<c-space>", "coc#refresh()", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("n", "<C-c>", ":wa | NvimTreeClose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":wa | NvimTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-m>", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":Telescope oldfiles<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.keymap.set("n", "<C-a>", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-j>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<S-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<S-n>", function() harpoon:list():next() end)

vim.cmd([[
  autocmd FileType rust nnoremap <silent> <C-s> :silent %! rustfmt<CR>
  autocmd FileType javascript nnoremap <silent> <C-s> :Prettier<CR>
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=4
  hi DiffAdd cterm=NONE ctermbg=NONE
  hi DiffChange cterm=NONE ctermbg=NONE
  hi DiffDelete cterm=NONE ctermbg=NONE
  hi DiffText cterm=NONE ctermbg=NONE 
  hi SignColumn cterm=NONE ctermbg=NONE 
]])
