import Gtk from 'gi://Gtk';
import Cairo from 'gi://Cairo';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const Lang = imports.lang;

function DrawTopLeft(round: number, cr: Cairo.Context) {
  cr.arc(round, round, round, Math.PI, 3 * Math.PI / 2);
  cr.lineTo(0, 0);
}

function DrawTopRight(round: number, cr: Cairo.Context) {
  cr.arc(0, round, round, 3 * Math.PI / 2, 2 * Math.PI);
  cr.lineTo(round, 0);
}

function DrawBottomLeft(round: number, cr: Cairo.Context) {
  cr.arc(round, 0, round, Math.PI / 2, Math.PI);
  cr.lineTo(0, round);
}

function DrawBottomRight(round: number, cr: Cairo.Context) {
  cr.arc(0, 0, round, 0, Math.PI / 2);
  cr.lineTo(round, round);
}

const DrawingCorner = (
  name: string,
  vPack: string,
  hPack: string,
  drawing: (round: number, cr: Cairo.Context) => void
) => Widget.DrawingArea({
  class_name: name,
  vpack: vPack,
  hpack: hPack,
  setup: (self: ReturnType<typeof Widget.DrawingArea>) => {
    const c = self.get_style_context().get_property('background-color', Gtk.StateFlags.NORMAL);
    const r = self.get_style_context().get_property('border-radius', Gtk.StateFlags.NORMAL);
    self.set_size_request(r, r);
    self.connect('draw', Lang.bind(self, (_: unknown, cr: Cairo.Context) => {
      const c = self.get_style_context().get_property('background-color', Gtk.StateFlags.NORMAL);
      const r = self.get_style_context().get_property('border-radius', Gtk.StateFlags.NORMAL);
      self.set_size_request(r, r);
      drawing(r, cr);
      cr.closePath();
      cr.setSourceRGBA(c.red, c.green, c.blue, c.alpha);
      cr.fill();
    }));
  }
});

const CornerWindow = (
  monitor: number,
  layer: string,
  exclusivity: string,
  anchor: string[],
  corner: Widget.DrawingArea
) => Widget.Window({
  monitor,
  layer,
  exclusivity,
  anchor,
  name: `${anchor[0]}${anchor[1]}${monitor}${exclusivity}`,
  child: corner
});

const StatusbarTopLeftCorner = (monitor: number) => CornerWindow(
  monitor,
  'top',
  'normal',
  ['top', 'left'],
  DrawingCorner('statusbar-corner', 'start', 'start', DrawTopLeft)
);

const StatusbarTopRightCorner = (monitor: number) => CornerWindow(
  monitor,
  'top',
  'normal',
  ['top', 'right'],
  DrawingCorner('statusbar-corner', 'start', 'end', DrawTopRight)
);

const ScreenTopLeftCorner = (monitor: number) => CornerWindow(
  monitor,
  'overlay',
  'ignore',
  ['top', 'left'],
  DrawingCorner('screen-corner', 'start', 'start', DrawTopLeft)
);

const ScreenTopRightCorner = (monitor: number) => CornerWindow(
  monitor,
  'overlay',
  'ignore',
  ['top', 'right'],
  DrawingCorner('screen-corner', 'start', 'end', DrawTopRight)
);

const ScreenBottomLeftCorner = (monitor: number) => CornerWindow(
  monitor,
  'overlay',
  'ignore',
  ['bottom', 'left'],
  DrawingCorner('screen-corner', 'end', 'start', DrawBottomLeft)
);

const ScreenBottomRightCorner = (monitor: number) => CornerWindow(
  monitor,
  'overlay',
  'ignore',
  ['bottom', 'right'],
  DrawingCorner('screen-corner', 'end', 'end', DrawBottomRight)
);

type CornerType = (monitor: number) => Widget.Window;

export const StatusbarCorners: CornerType[] = [
  StatusbarTopLeftCorner,
  StatusbarTopRightCorner,
];

export const ScreenCorners: CornerType[] = [
  ScreenTopLeftCorner,
  ScreenTopRightCorner,
  ScreenBottomLeftCorner,
  ScreenBottomRightCorner,
];