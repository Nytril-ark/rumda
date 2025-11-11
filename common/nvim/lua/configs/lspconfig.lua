-- Setup default root markers
vim.lsp.config('*', {
  root_markers = {'.git'},
})

-- Python (pyright)
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { '.git', 'pyproject.toml', 'setup.py' },
  settings = {
    python = {
      analysis = {
        extraPaths = { "." },
      },
    },
  },
})
vim.lsp.enable('pyright')

-- HTML
vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { '.git', 'package.json' },
})
vim.lsp.enable('html')

-- CSS
vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { '.git', 'package.json' },
})
vim.lsp.enable('cssls')

-- C/C++ (clangd)
vim.lsp.config('clangd', {
  cmd = { "clangd", "--completion-style=detailed", "--background-index" },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = { '.git', 'compile_commands.json', '.clangd' },
})
vim.lsp.enable('clangd')

-- LSP Keybindings (when LSP attaches to buffer)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

