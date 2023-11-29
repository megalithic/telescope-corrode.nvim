local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local config = {}

-- TODO actually provide configuration
_TelescopeCorrodeConfig = {
  AND = true,
  permutations = true,
  fd_cmd = { "fd", "--type", "f", "--hidden", "--no-ignore-vcs", "--strip-cwd-prefix" },
  rg_cmd = {
    "rg",
    "--hidden",
    "--no-ignore-vcs",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--trim",
  },
} or _TelescopeCorrodeConfig

config.values = _TelescopeCorrodeConfig

config.setup = function(opts)
  -- TODO maybe merge other keys as well from telescope.config
  local telescope_mappings = require("telescope.config").values.mappings
  for mode, tbl in pairs(telescope_mappings) do
    if not config.values[mode] then
      config.values[mode] = {}
    end
    for key, action in pairs(tbl) do
      if not config.values[mode][key] then
        config.values[mode][key] = action
      end
    end
  end
  config.values = vim.tbl_deep_extend("force", config.values, opts)
end

return config
