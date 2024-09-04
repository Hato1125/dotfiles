import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import Symbol from '@Lib/Symbol';

const TextContent = (
  symbol: string,
  title: string,
  content: string
) => Widget.Box({
  spacing: 16,
  expand: true,
  vertical: true,
  children: [
    Symbol({
      symbol: symbol
    }),
    Widget.Label({
      hpack: 'center',
      class_name: 'title',
      label: title
    }),
    Widget.Label({
      hpack: 'start',
      class_name: 'content',
      label: content
    }),
  ]
});

const ButtonContent = (
  buttons: Widget.Button[]
) => Widget.Box({
  hpack: 'end',
  vpack: 'end',
  children: buttons
});

export default ({
  symbol = '' as string,
  title = '' as string,
  content = '' as string,
  buttons = [] as Widget.Button[]
}) => Widget.Box({
  class_name: 'dialog',
  hpack: 'center',
  vpack: 'center',
  spacing: 24,
  expand: true,
  vertical: true,
  children: [
    TextContent(
      symbol,
      title,
      content
    ),
    ButtonContent(
      buttons
    )
  ]
});