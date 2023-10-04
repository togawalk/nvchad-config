local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "tailwindcss-language-server",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  filters = {
    custom = { 'node_modules' },
  },
  git = {
    enable = true,
    ignore = false,
  },

  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },

    icons = {
      show = {
        file = false,
        git = false,
      },
      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "󰉋",
          empty = "",
          empty_open = "",
          open = "󰉋",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
      },
    },
  },
}

M.colorizer = {
  user_default_options = {
    names = false, -- "Name" codes like Blue or blue
    tailwind = true, -- Enable tailwind colors
    mode = "virtualtext", -- Set the display mode.
  },
}

M.ufo= {
  provider_selector = function(_, ft, _)
    -- INFO some filetypes only allow indent, some only LSP, some only
    -- treesitter. However, ufo only accepts two kinds as priority,
    -- therefore making this function necessary :/
    local lspWithOutFolding =
      { "markdown", "bash", "sh", "bash", "zsh", "css", "html", "python" }
    if vim.tbl_contains(lspWithOutFolding, ft) then return { "treesitter", "indent" } end
    return { "lsp", "indent" }
  end,
  -- open opening the buffer, close these fold kinds
  -- use `:UfoInspect` to get available fold kinds from the LSP
  close_fold_kinds = { "imports" },
  open_fold_hl_timeout = 500,
  fold_virt_text_handler = foldTextFormatter,
}

return M
