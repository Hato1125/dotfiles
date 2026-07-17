local function make_float(ev)
  local win = vim.api.nvim_get_current_win()

  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(ev.buf) or not vim.api.nvim_win_is_valid(win) then
      return
    end

    local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
    local content_width = 0
    for _, line in ipairs(lines) do
      content_width = math.max(content_width, vim.fn.strdisplaywidth(line))
    end

    local width = math.min(math.max(content_width + 2, 20), vim.o.columns - 4)
    local height = math.min(math.max(#lines, 1), vim.o.lines - 4, 15)
    vim.api.nvim_win_set_config(win, {
      relative = 'editor',
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      width = width,
      height = height,
      border = 'rounded',
      style = 'minimal',
      focusable = true,
      title = ' Type Hierarchy ',
      title_pos = 'center',
    })
    vim.wo[win].winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder'

    vim.keymap.set('n', 'q', function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end, { buffer = ev.buf, desc = 'Close type hierarchy' })
  end)
end

return {
  setup = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('CppTypeHierarchyFloat', { clear = true }),
      pattern = 'ClangdTypeHierarchy',
      callback = make_float,
    })
  end,
}
