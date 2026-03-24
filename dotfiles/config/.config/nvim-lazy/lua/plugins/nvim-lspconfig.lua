return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
    },
  },
  -- add perl LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        perlpls = {
          syntax = { enabled = true },
        },
      }
    },
  },
}
