call plug#begin()

" File tree
Plug 'preservim/nerdtree'

" Fuzzy finding
Plug 'junegunn/fzf'
Plug 'ibhagwan/fzf-lua'

" Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Indentation
Plug 'tpope/vim-sleuth'

" Theme
Plug 'sainnhe/everforest'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Icons. REQUIRES NERD FONT
Plug 'ryanoasis/vim-devicons'

call plug#end()

" C-w is not ergonomic for window controls
nnoremap <Space> <C-w>

" Buffer navigation
nnoremap <space>o :+tabnext<CR>
nnoremap <space>i :-tabnext<CR>
nnoremap <space>d :tabclose<CR>
nnoremap <space>c :tabnew<CR>

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :FZF<CR>

nnoremap <leader>g :call fzf#run(fzf#wrap({'source': 'git ls-files -m'}))<CR>
nnoremap <leader>o :FzfLua lsp_document_symbols<CR>
nnoremap <leader><S-f> :FzfLua live_grep<CR>

nnoremap <leader>d :lua vim.diagnostic.open_float()<CR>

" Find and cd to project root on startup
autocmd VimEnter * silent! lcd %:p:h | silent! lcd `git rev-parse --show-toplevel 2>/dev/null`

" Disable mouse
set mouse=

" Show line numbers
set number

" Show trailing whitespace
set list
set listchars=trail:·,tab:>·

" Strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

let NERDTreeShowHidden=1

" Directory arrows
let g:NERDTreeDirArrowExpandable = "\uf105"
let g:NERDTreeDirArrowCollapsible = "\uf107"

" Add keybind for dumping results to quickfix
lua << EOF
require('fzf-lua').setup({
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    }
  }
})
EOF

" Spellchecking for certain filetypes
autocmd FileType markdown setlocal spell spelllang=en_us

lua << EOF
--vim.lsp.log.set_level 'debug'
local cmp = require('cmp')
cmp.setup({
  sources = {{ name = 'nvim_lsp' }},
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('intelephense', {
  settings = {
    intelephense = {
      completion = {
        -- It's easier for me to type parens and params out myself
        triggerParameterHints = false,
      }
    }
  }
})
vim.lsp.enable('intelephense')

local vue_language_server_path = '/home/max/.nvm/versions/node/v20.19.5/lib/node_modules/@vue/language-server'
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetypes,
}

local ts_ls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
}

-- If you are on most recent `nvim-lspconfig`
local vue_ls_config = {}
-- If you are not on most recent `nvim-lspconfig` or you want to override
-- nvim 0.11 or above
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`

vim.lsp.enable('remark_ls') -- Doesn't really do anything

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
EOF

set signcolumn=yes:2

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '-' },
    untracked    = { text = '?' },
    changedelete = { text = '-' },
    topdelete    = { text = '-' },
  },
  signs_staged = {
    add          = { text = '' },
    change       = { text = '' },
    delete       = { text = '' },
    untracked    = { text = '' },
    changedelete = { text = '' },
    topdelete    = { text = '' },
  },
  -- This is higher than LSP diagnostics
  sign_priority = 20,
}
EOF

noremap ]h :Gitsigns nav_hunk next<CR>
noremap [h :Gitsings nav_hunk prev<CR>
noremap <leader>b :Gitsigns blame<CR>
noremap <leader>h :Gitsigns preview_hunk_inline<CR>
noremap <leader>s :Gitsigns stage_hunk<CR>
noremap <leader>r :Gitsigns reset_hunk<CR>

" Theme stuff
set termguicolors

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'

" For better performance
let g:everforest_better_performance = 1

colorscheme everforest
