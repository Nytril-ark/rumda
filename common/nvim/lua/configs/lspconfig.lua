local lspconfig = require('lspconfig')

-- Get NvChad's default on_attach and capabilities if available
local status, nvchad_lsp = pcall(require, "nvchad.configs.lspconfig")
local on_attach = status and nvchad_lsp.on_attach or function() end
local capabilities = status and nvchad_lsp.capabilities or vim.lsp.protocol.make_client_capabilities()

-- Python (pyright)
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py'),
  settings = {
    python = {
      analysis = {
        extraPaths = { "." },
      },
    },
  },
})

-- HTML
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_dir = lspconfig.util.root_pattern('.git', 'package.json'),
})

-- CSS
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_dir = lspconfig.util.root_pattern('.git', 'package.json'),
})

-- Force line comments for C/C++ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.bo.commentstring = '// %s'
  end,
})

-- C/C++ (clangd)
lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "clangd", "--completion-style=detailed", "--background-index" },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_dir = lspconfig.util.root_pattern('.git', 'compile_commands.json', '.clangd'),
})

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
