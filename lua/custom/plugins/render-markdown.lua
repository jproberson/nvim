require('render-markdown').setup {
  heading = {
    icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
  },
  checkbox = {
    enabled = true,
    unchecked = { icon = '󰄱 ' },
    checked = { icon = '󰄵 ' },
    custom = {
      todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
      partial = { raw = '[~]', rendered = '󰡖 ', highlight = 'RenderMarkdownWarn' },
    },
  },
  link = {
    wiki = { icon = '󱗖 ' },
  },
}
