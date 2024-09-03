import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import Hyprland from '@Lib/Service/Hyprland';
import Symbol from '@Lib/Symbol';

const MAX_WORKSPACE: number = 6;

const WorkspaceButton = (workspaceId: number) => Widget.Button({
  setup: (self: Widget.Button) => self.hook(Hyprland.active.workspace, () => {
    const isHightLight: boolean = workspaceId >= MAX_WORKSPACE
      ? MAX_WORKSPACE <= Hyprland.active.workspace.id
      : workspaceId === Hyprland.active.workspace.id;
    self.class_name = isHightLight
      ? 'focused'
      : 'unfocused';
  }),
  on_clicked: () => {
    Hyprland.messageAsync(`dispatch workspace ${workspaceId}`)
  },
  child: workspaceId >= MAX_WORKSPACE
    ? Symbol({ symbol: 'more_horiz' })
    : Widget.Label({ label: workspaceId.toString() })
  });

export default () => Widget.Box({
  class_name: 'workspace',
  hexpand: true,
  vertical: false,
  spacing: 6,
  children: [...Array(MAX_WORKSPACE)].map((_, i) => WorkspaceButton(i + 1)),
});