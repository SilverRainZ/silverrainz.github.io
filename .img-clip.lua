-- Project-specific settings of img-clip.nvim.
--
-- https://github.com/HakonHarnes/img-clip.nvim


local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local function get_images_dir()
  return get_git_root() .. "/_images"
end

local function trim_prefix(s, p)
  return (s:sub(0, #p) == p) and s:sub(#p+1) or s
end

return {
  default = {
    dir_path = get_images_dir, ---@type string | fun(): string
    file_name = "%Y-%m-%d_%H%M%S", ---@type string | fun(): string
    use_absolute_path = true,

    insert_mode_after_paste = false, ---@type boolean | fun(): boolean
  },

  filetypes = {
    rst = {
      template = function(ctx)
        -- Get absolute path which relative to the top source directory.
        file_path = trim_prefix(ctx.file_path, get_git_root())
        return "\n.. image:: " .. file_path .. "\n   " .. ctx.cursor
      end, ---@type string | fun(context: table): string
    },
  },
}
