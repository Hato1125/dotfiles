local active_popup = nil

-- Build the derived-side (children) as display nodes.
local function build_down(nodes)
  local out = {}
  for _, n in ipairs(nodes or {}) do
    table.insert(out, { name = n.name, children = build_down(n.children) })
  end
  return out
end

-- Invert the base-side (parents) so the topmost ancestor becomes a display
-- root and the chain nests downward toward `display` (the type under cursor).
local function build_up(src, display)
  if not src.parents or #src.parents == 0 then
    return { display }
  end
  local roots = {}
  for _, p in ipairs(src.parents) do
    local p_display = { name = p.name, children = { display } }
    for _, root in ipairs(build_up(p, p_display)) do
      table.insert(roots, root)
    end
  end
  return roots
end

local function render_tree(nodes, prefix, is_root, out)
  local count = #nodes
  for i, node in ipairs(nodes) do
    local last = i == count
    local line, child_prefix
    if is_root then
      line = node.name
      child_prefix = ''
    else
      line = prefix .. (last and '└ ' or '├ ') .. node.name
      child_prefix = prefix .. (last and '  ' or '│ ')
    end
    table.insert(out, line)
    render_tree(node.children, child_prefix, false, out)
  end
end

-- Returns the hierarchy tree lines for a clangd TypeHierarchyItem, or nil when
-- the type has neither bases nor derived types.
local function hierarchy_lines(item)
  local has_parents = item.parents and #item.parents > 0
  local has_children = item.children and #item.children > 0
  if not has_parents and not has_children then
    return nil
  end

  local self_display = { name = item.name, children = build_down(item.children) }
  local roots = build_up(item, self_display)

  local lines = {}
  render_tree(roots, '', true, lines)

  local max_lines = 15
  if #lines > max_lines then
    lines = vim.list_slice(lines, 1, max_lines)
    lines[max_lines] = '…'
  end
  return lines
end

local function pad(line, width, fill)
  local w = vim.fn.strdisplaywidth(line)
  if w < width then
    return line .. string.rep(fill, width - w)
  end
  return line
end

local function show_popup(size, alignment, tree)
  local Popup = require('nui.popup')
  local Table = require('nui.table')

  if active_popup then
    active_popup:unmount()
  end

  local data = {
    { label = 'Size', value = ' ' .. size .. ' byte' },
    { label = 'Alignment', value = ' ' .. alignment .. ' byte' },
  }
  local label_width = #'Alignment' + 1
  local value_width = 0
  for _, row in ipairs(data) do
    value_width = math.max(value_width, vim.fn.strdisplaywidth(row.value) + 1)
  end

  local popup = Popup {
    relative = 'cursor',
    position = { row = 1, col = 0 },
    size = { width = 1, height = 1 },
    enter = false,
    focusable = false,
    border = {
      style = 'rounded',
    },
    win_options = {
      winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder',
    },
  }
  popup:mount()
  active_popup = popup

  local table_view = Table {
    ns_id = 'CppClassInfo',
    bufnr = popup.bufnr,
    columns = {
      { accessor_key = 'label', min_width = label_width },
      { accessor_key = 'value', min_width = value_width },
    },
    data = data,
  }
  table_view:render()

  -- strip the outer table border so the popup border is the only frame
  local raw = vim.api.nvim_buf_get_lines(popup.bufnr, 0, -1, false)
  local function without_outer_border(line)
    return vim.fn.strcharpart(line, 1, vim.fn.strchars(line) - 2)
  end
  local table_lines = {}
  for i = 2, #raw - 1 do
    if i % 2 == 0 then
      table.insert(table_lines, ' ' .. without_outer_border(raw[i]) .. ' ')
    else
      table.insert(table_lines, '─' .. without_outer_border(raw[i]) .. '─')
    end
  end

  local tree_lines = {}
  if tree then
    for _, line in ipairs(tree) do
      table.insert(tree_lines, ' ' .. line)
    end
  end

  -- reconcile widths: pad every line (and the separators) to the widest one
  local width = 0
  for _, line in ipairs(table_lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  for _, line in ipairs(tree_lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end

  local rendered = {}
  for i, line in ipairs(table_lines) do
    table.insert(rendered, pad(line, width, i % 2 == 0 and '─' or ' '))
  end
  if #tree_lines > 0 then
    table.insert(rendered, string.rep('─', width))
    for _, line in ipairs(tree_lines) do
      table.insert(rendered, pad(line, width, ' '))
    end
  end

  vim.api.nvim_win_set_config(popup.winid, { width = width, height = #rendered })

  vim.bo[popup.bufnr].modifiable = true
  vim.bo[popup.bufnr].readonly = false
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, rendered)
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

local function request_hierarchy(client, buf, callback)
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  params.resolve = 5
  params.direction = 2 -- both super- and subtypes
  local ok = client:request('textDocument/typeHierarchy', params, function(err, result)
    if err or type(result) ~= 'table' then
      callback(nil)
      return
    end
    callback(hierarchy_lines(result))
  end, buf)
  if not ok then
    callback(nil)
  end
end

local function request_info(ev)
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

    local plain = result.contents.value:gsub('[%*_`]', '')
    local size = plain:match('Size:%s*(%d+)%s*bytes?')
    local alignment = plain:match('[Aa]lignment:?%s*(%d+)%s*bytes?')
    if not (size and alignment) then
      return
    end

    request_hierarchy(client, ev.buf, function(tree)
      show_popup(size, alignment, tree)
    end)
  end, ev.buf)
end

return {
  setup = function()
    vim.api.nvim_create_autocmd('CursorHold', {
      group = vim.api.nvim_create_augroup('CppClassInfoHover', { clear = true }),
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
      callback = request_info,
    })
  end,
}
