import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export function GetIcon(percent: number, array: string[]): string {
  return array[Math.floor(percent / (100 / (array.length - 1)))];
}

export function Symbol({
  symbol = '',
  ...props
}): ReturnType<typeof Widget.Label> {
  return Widget.Label({
    class_name: 'symbol',
    hpack: 'center',
    vpack: 'center',
    single_line_mode: true,
    label: symbol,
    ...props
  });
}

export default Symbol;