return {
  {
    "vim-perl/vim-perl",
    lazy = true,
    ft = "perl",
    build = "make clean carp dancer highlight-all-pragmas moose test-more try-tiny",
  },
}
