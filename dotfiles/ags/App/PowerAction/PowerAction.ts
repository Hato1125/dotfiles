import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

import Dialog from '@Lib/Dialog';


export enum PowerActionType {
  Shutdown,
  Restart,
  Sleep,
  Logout,
}

const POWER_ACTION_NAME: string = 'shutdown';
const POWER_ACTION_CONTENT: string[] = [
  `
The data you are working on will be deleted.
Please save and shut down.
  `,
  `
The data you are working on will be deleted.
Please save and shut down.
  `,
  `
The data you are working on will not be lost during sleep.
  `,
  `
The data you are working on will be deleted.
Please save and shut down.
  `,
];
const POWER_ACTION_LAMBDA: Function[] = [
  () => { Utils.exec('shutdown now') },
  () => { Utils.exec('reboot') },
  () => { Utils.exec('systemctl suspend') },
  () => { Utils.exec('pkill -KILL -u $USER') },
]

const PowerActionContent = Variable(POWER_ACTION_CONTENT[0]);
let PowerActionLambda = POWER_ACTION_LAMBDA[0];

export function Open(action: PowerActionType): void {
  PowerActionContent.setValue(POWER_ACTION_CONTENT[action]);
  PowerActionLambda = POWER_ACTION_LAMBDA[action];
  App.openWindow(POWER_ACTION_NAME);
}

export function Close(): void {
  App.closeWindow(POWER_ACTION_NAME);
}

const Scrim = () => Widget.Box({
  class_name: 'scrim',
});

const PowerActionDialog = () => Dialog({
  symbol: 'power',
  title: 'Are you sure?',
  content: PowerActionContent.bind(),
  buttons: [
    Widget.Button({
      child: Widget.Label({
        label: 'Cancel'
      }),
      on_clicked: Close
    }),
    Widget.Button({
      child: Widget.Label({
        label: 'Ok'
      }),
      on_clicked: PowerActionLambda
    })
  ]
});

const Layout = () => Widget.Overlay({
  overlays: [
    Scrim(),
    PowerActionDialog(),
  ]
});

export default () => Widget.Window({
  name: `shutdown`,
  class_name: 'shutdown',
  exclusivity: 'ignore',
  layer: 'overlay',
  anchor: ['top', 'bottom', 'left', 'right'],
  child: Layout()
});