import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import Title from './Title';
import Workspace from './Workspace';
import KeyLayout from './KeyLayout';
import Volume from './Volume';
import Battery from './Battery';
import Wifi from './Wifi';
import Date from './Date';

// TODO: Make it possible to switch up and down in the future.
enum StatusbarAnchor {
  Top,
  Bottom,
}

function GetAnchor(anchor: StatusbarAnchor): string[] {
  switch(anchor) {
    case StatusbarAnchor.Top:
      return ['top', 'left', 'right'];
    case StatusbarAnchor.Bottom:
      return ['bottom', 'left', 'right'];
  }
}

const StartLayout = () => Widget.Box({
  class_name: 'start',
  hpack: 'start',
  children: [
    Title(),
  ]
});

const CenterLayout = () => Widget.Box({
  class_name: 'center',
  hpack: 'center',
  children: [
    Workspace(),
  ]
});

const EndLayout = () => Widget.Box({
  class_name: 'end',
  hpack: 'end',
  spacing: 32,
  children: [
    Widget.Box({
      spacing: 20,
      children: [
        KeyLayout(),
        Volume(),
        Battery(),
        Wifi()
      ]
    }),
    Date(),
  ]
});

const Layout = () => Widget.CenterBox({
  startWidget: StartLayout(),
  centerWidget: CenterLayout(),
  endWidget: EndLayout(),
});

export default (monitor: number) => Widget.Window({
  monitor: monitor,
  name: `statusbar-${monitor}`,
  class_name: 'statusbar',
  exclusivity: 'exclusive',
  layer: 'top',
  anchor: GetAnchor(StatusbarAnchor.Top),
  child: Layout(),
});