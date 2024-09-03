import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export default ({
  symbol = '',
  ...props
}) => Widget.Label({
  class_name: 'symbol',
  label: symbol,
  ...props
});