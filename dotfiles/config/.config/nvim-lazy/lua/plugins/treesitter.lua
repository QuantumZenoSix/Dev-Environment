return {

  -- other plugins here



  -- Add Treesitter plugin

  {

    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    config = function()

      require("nvim-treesitter.configs").setup({

        ensure_installed = { "lua", "python", "javascript", "html", "css" , "c", "bash", "asm", "dockerfile", "json", "nginx","objdump","sql", "svelte", "ssh_config", "tmux", "perl", "markdown", "markdown_inline"}, -- Languages you need

        highlight = {

          enable = true, -- enable treesitter for syntax highlighting

        },

      })

    end,

  },



  -- Optionally, add Treesitter playground (for debugging and exploring)

--  {
--
--    "nvim-treesitter/playground",
--
--    config = function()
--
--      require("nvim-treesitter.configs").setup({
--
--        playground = {
--
--          enable = true,
--
--        },
--
--      })
--
--    end,
--
--  },
--
}


