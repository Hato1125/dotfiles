import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import Hyprland from '@Service/Hyprland';

export default () => Widget.Label({
  label: Hyprland.active.client.bind('title'),
  truncate: 'end',
  maxWidthChars: 100,
});