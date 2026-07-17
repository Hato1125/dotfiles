local active_popup = nil

local function show_popup(kind, name, size, alignment)
  local Popup = require('nui.popup')
  local Table = require('nui.table')

  if active_popup then
    active_popup:unmount()
  end

  local size_text = size .. 'byte'
  local alignment_text = alignment .. 'byte'
  local label_width = #'Alignment' + 1
  local title_width = #kind + 1 + #name
  local value_width = math.max(
    #size_text + 1,
    #alignment_text + 1,
    title_width - label_width - 1
  )
  local content_width = label_width + value_width + 1

  local popup = Popup({
    relative = 'cursor',
    position = { row = 1, col = 0 },
    size = { width = content_width + 2, height = 5 },
    enter = false,
    focusable = false,
    border = {
      style = 'rounded',
    },
    win_options = {
      winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder',
    },
  })
  popup:mount()
  active_popup = popup

  local table_view = Table {
    ns_id = 'CppClassLayout',
    bufnr = popup.bufnr,
    columns = {
      { accessor_key = 'label', min_width = label_width },
      { accessor_key = 'value', min_width = value_width },
    },
    data = {
      { label = 'Size', value = ' ' .. size_text },
      { label = 'Alignment', value = ' ' .. alignment_text },
    },
  }
  table_view:render()

  local lines = vim.api.nvim_buf_get_lines(popup.bufnr, 0, -1, false)
  local function without_outer_border(line)
    return vim.fn.strcharpart(line, 1, vim.fn.strchars(line) - 2)
  end
  local function full_width_separator(line)
    return '─' .. without_outer_border(line) .. '─'
  end
  local rendered = {
    ' ' .. kind .. ' ' .. name,
    full_width_separator(lines[1]),
    ' ' .. without_outer_border(lines[2]) .. ' ',
    full_width_separator(lines[3]),
    ' ' .. without_outer_border(lines[4]) .. ' ',
  }

  vim.bo[popup.bufnr].modifiable = true
  vim.bo[popup.bufnr].readonly = false
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, rendered)
  vim.api.nvim_buf_add_highlight(
    popup.bufnr,
    -1,
    '@markup.strong',
    0,
    #kind + 2,
    -1
  )
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].readonly = true

  vim.api.nvim_create_autocmd({
    'CursorMoved',
    'CursorMovedI',
    'InsertEnter',
    'BufLeave',
  }, {
    buffer = vim.api.nvim_get_current_buf(),
    once = true,
    callback = function()
      if active_popup == popup then
        active_popup = nil
      end
      popup:unmount()
    end,
  })
end

local function request_layout(ev)
    local supported_filetypes = {
        c = true,
        cpp = true,
    }
    if not supported_filetypes[vim.bo[ev.buf].filetype] then
        return
    end

    local ok, node = pcall(vim.treesitter.get_node, { bufnr = ev.buf })
    if not ok or not node then
        return
    end

    local parent = node:parent()
    local record_types = {
        class_specifier = true,
        struct_specifier = true,
        union_specifier = true,
    }
    if not parent or not record_types[parent:type()] then
        return
    end

    local names = parent:field('name')
    if not names[1] or names[1]:id() ~= node:id() then
        return
    end

    local client = vim.iter(vim.lsp.get_clients({ bufnr = ev.buf }))
        :find(function(item) return item.name == 'clangd' end)
    if not client then
        return
    end

    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    client:request('textDocument/hover', params, function(_, result)
        if not result or type(result.contents) ~= 'table'
            or type(result.contents.value) ~= 'string' then
            return
        end

        local value = result.contents.value
        local kind, name = value:match('^###%s+(%w+)%s+`([^`]+)`')
        if not kind then
            kind, name = value:match('^###%s+(%w+)%s+([^\n]+)')
        end

        local plain = value:gsub('[%*_`]', '')
        local size = plain:match('Size:%s*(%d+)%s*bytes?')
        local alignment = plain:match('[Aa]lignment:?%s*(%d+)%s*bytes?')
        if kind and name and size and alignment then
            show_popup(kind, vim.trim(name), size, alignment)
        end
    end, ev.buf)
end

return {
  setup = function ()
    vim.api.nvim_create_autocmd('CursorHold', {
      group = vim.api.nvim_create_augroup('CppClassLayoutHover', { clear = true }),
      pattern = {
        '*.c',
        '*.h',
        '*.cc',
        '*.hh',
        '*.cpp',
        '*.hpp',
        '*.cxx',
        '*.hxx',
      },
      callback = request_layout,
    })
  end
}
