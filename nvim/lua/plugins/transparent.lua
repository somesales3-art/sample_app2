return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  -- opts ではなく config を使って、設定と有効化をセットで行います
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalSB", -- ← これが重要！(下部ターミナルの背景)
        "SignColumnSB", -- ターミナル横の細いバー
        "StatusLine", -- ステータスライン
        "StatusLineNC",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeWinSeparator",
        "NormalFloat",
        "NvimTreeNormal",
        "ToggleTerm1",
        "ToggleTerm2",
        "ToggleTerm3",
      },
    })
    -- 設定したあとに強制的に有効化
    vim.cmd("TransparentEnable")
  end,
}
