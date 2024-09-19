import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

import Hyprland from '@Service/Hyprland';

const keyLayout = Variable('');

Hyprland.connect('keyboard-layout', (
  _0: unknown,
  _1: unknown,
  layoutName: string
) => {
  keyLayout.setValue(
    layoutName
      .trim()
      .substring(0, 2)
      .toUpperCase()
  );
});

export default () => Widget.Label({
  class_name: 'layout',
  hpack: 'center',
  vpack: 'center',
  label: keyLayout.bind(),
});