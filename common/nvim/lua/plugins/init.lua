return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
-- discord presence
-- {'andweeb/presence.nvim', lazy = false, },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
	--
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    },


  -- {
  --   "sphamba/smear-cursor.nvim",
  --   lazy = false,
  --   opts = {
  --     never_draw_over_target = true,
  --
  --     -- Smear cursor when switching buffers or windows.
  --     smear_between_buffers = true,
  --
  --     -- Smear cursor when moving within line or to neighbor lines.
  --     -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
  --     smear_between_neighbor_lines = true,
  --
  --     -- Draw the smear in buffer space instead of screen space when scrolling
  --     scroll_buffer_space = true,
  --
  --     -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
  --     -- Smears and particles will look a lot less blocky.
  --     legacy_computing_symbols_support = true,
  --
  --     -- Smear cursor in insert mode.
  --     -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
  --     smear_insert_mode = false,
  --
  --     gradient_exponent = 0,
  --     particles_enabled = false,
  --     particle_spread = 1,
  --     particles_per_second = 100,
  --     particles_per_length = 100,
  --     particle_max_lifetime = 1000,
  --     particle_damping = 0.1,
  --     particle_gravity = 100,
  --   },
  -- },



    {
      "karb94/neoscroll.nvim",
      event = "VeryLazy",
      config = function()
        require("neoscroll").setup({
          hide_cursor = true,
          stop_eof = true,
          respect_scrolloff = true,
          cursor_scrolls_alone = true,
          easing_function = "sine", 
          -- Easing options: nil (default), linear, quadratic, cubic, quartic, quintic, circular, sine
          -- nil - Default (linear-ish)
          -- "linear" - Constant speed (robotic)
          -- "quadratic" - Slow start/end, fast middle (smooth)
          -- "cubic" - More pronounced slow start/end
          -- "quartic" - Even more pronounced
          -- "quintic" - Very smooth
          -- "circular" - Circular motion feel
          -- "sine" - Sine wave motion
        })
        
        -- Smooth movement mappings
        local t = {}
        
        -- j/k keys
        -- t['j'] = {'scroll', {0.05, 'true', '150'}}     -- CHANGED: Last number is duration (ms)
        -- t['k'] = {'scroll', {-0.05, 'true', '150'}}
        --
        -- -- Arrow keys (ADDED)
        -- t['<Down>'] = {'scroll', {0.2, 'true', '150'}}
        -- t['<Up>'] = {'scroll', {-0.2, 'true', '150'}}
        
        -- Optional: Add Ctrl+d/u for page scrolling
        t['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '250'}}
        t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
        
        -- Optional: Add zz, zt, zb for centering
        t['zz'] = {'zz', {'150'}}
        t['zt'] = {'zt', {'150'}}
        t['zb'] = {'zb', {'150'}}
        
        -- require('neoscroll.config').set_mappings(t)
      end,
    },



    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

      
	  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require'cmp'
      local luasnip = require'luasnip'

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        }),
      })
    end,
  },
}
