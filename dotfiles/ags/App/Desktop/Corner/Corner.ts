import Gtk from 'gi://Gtk';
import Gdk from 'gi://Gdk';
import Cairo from 'gi://Cairo';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

const Lang = imports.lang;

function DrawTopLeft(color: Gdk.RGBA, round: number, cr: Cairo.Context) {
  cr.arc(round, round, round, Math.PI, 3 * Math.PI / 2);
  cr.lineTo(0, 0);
  cr.closePath();
  cr.setSourceRGBA(color.red, color.green, color.blue, color.alpha);
  cr.fill();
}

function DrawTopRight(color: Gdk.RGBA, round: number, cr: Cairo.Context) {
  cr.arc(0, round, round, 3 * Math.PI / 2, 2 * Math.PI);
  cr.lineTo(round, 0);
  cr.closePath();
  cr.setSourceRGBA(color.red, color.green, color.blue, color.alpha);
  cr.fill();
}

function DrawBottomLeft(color: Gdk.RGBA, round: number, cr: Cairo.Context) {
  cr.arc(round, 0, round, Math.PI / 2, Math.PI);
  cr.lineTo(0, round);
  cr.closePath();
  cr.setSourceRGBA(color.red, color.green, color.blue, color.alpha);
  cr.fill();
}

function DrawBottomRight(color: Gdk.RGBA, round: number, cr: Cairo.Context) {
  cr.arc(0, 0, round, 0, Math.PI / 2);
  cr.lineTo(round, round);
  cr.closePath();
  cr.setSourceRGBA(color.red, color.green, color.blue, color.alpha);
  cr.fill();
}

const DrawingCorner = (
  name: string,
  vPack: string,
  hPack: string,
  drawing: (color: Gdk.RGBA, round: number, cr: Cairo.Context) => void
) => Widget.DrawingArea({
  class_name: name,
  vpack: vPack,
  hpack: hPack,
  setup: (self: Widget.DrawingArea) => {
    const c = self.get_style_context().get_property('background-color', Gtk.StateFlags.NORMAL);
    const r = self.get_style_context().get_property('border-radius', Gtk.StateFlags.NORMAL);
    self.set_size_request(r, r);
    self.connect('draw', Lang.bind(self, (_, cr: Cairo.Context) => {
      const c = self.get_style_context().get_property('background-color', Gtk.StateFlags.NORMAL);
      const r = self.get_style_context().get_property('border-radius', Gtk.StateFlags.NORMAL);
      self.set_size_request(r, r);
      drawing(c, r, cr);
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