import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import Hyprland from '@Lib/Service/Hyprland';
import Symbol from '@Lib/Symbol';

const MAX_WORKSPACE = 6;

const WorkspaceButton = (workspaceId: number) => Widget.Button({
  setup: (self: ReturnType<typeof Widget.Button>) => {
    self.hook(Hyprland.active.workspace, () =>
      self.class_name = Hyprland.active.workspace.id === workspaceId
        ? 'focused'
        : 'unfocused'
    );
  },
  on_clicked: () => {
    Hyprland.messageAsync(`dispatch workspace ${workspaceId}`);
  },
  child: Widget.Label({
    label: workspaceId.toString()
  })
});

const WorkspaceMore = () => Widget.Button({
  setup: (self: ReturnType<typeof Widget.Button>) => {
    self.hook(Hyprland.active.workspace, () => {
      if (Hyprland.active.workspace.id >= MAX_WORKSPACE) {
        self.class_name = 'focused';
        self.child.class_name = '';
        self.child.label = Hyprland.active.workspace.id >= 100
          ? '99+'
          : Hyprland.active.workspace.id.toString();
      } else {
        self.class_name = 'unfocused';
        self.child.class_name = 'symbol';
        self.child.label = 'more_horiz';
      }
    });
  },
  on_clicked: () => {
    const warpId = Hyprland.active.workspace.id > MAX_WORKSPACE
      ? Hyprland.active.workspace.id
      : MAX_WORKSPACE;
    Hyprland.messageAsync(`dispatch workspace ${warpId}`)
  },
  child: Symbol({
    symbol: 'more_horiz'
  })
});

const Layout = () => {
  return [...Array(MAX_WORKSPACE)].map((_: unknown, i: number) => {
    return i >= MAX_WORKSPACE - 1
      ? WorkspaceMore()
      : WorkspaceButton(i + 1);
  });
}

export default () => Widget.Box({
  class_name: 'workspace',
  spacing: 6,
  hexpand: true,
  vertical: false,
  children: Layout(),
});