import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export default (self: Widget.Button) => {
  self.connect("button-press-event", () => {
    self.get_style_context().add_class("fade-in");
    self.get_style_context().remove_class("fade-out");
  });
  self.connect('button-release-event', () => {
    self.get_style_context().add_class('fade-out');
    self.get_style_context().remove_class("fade-in");
  });
};