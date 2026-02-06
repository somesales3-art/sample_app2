return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "solargraph", -- ここに書いたものが自動で入ります
        -- 他にも入れたいものがあればここに追加
        -- "rubocop",
        -- "html-lsp",
      },
    },
  },
}
