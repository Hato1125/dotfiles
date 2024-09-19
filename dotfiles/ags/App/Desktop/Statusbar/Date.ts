import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

const date = Variable(new Date(), {
  poll: [1000, () => new Date()]
});

function GetDate(today: Date): string {
  const yyyy = String(today.getFullYear());
  const mm = String(today.getMonth() + 1);
  const dd = String(today.getDate());
  return `${yyyy}/${mm}/${dd}`;
}

function GetTime(today: Date): string {
  const hh = String(today.getHours()).padStart(2, '0');
  const mm = String(today.getMinutes()).padStart(2, '0');
  return `${hh}:${mm}`;
}

export default () => Widget.Box({
  class_name: 'dates',
  vpack: 'center',
  vertical: true,
  hexpand: true,
  children: [
    Widget.Label({
      label: date.bind().as((date: Date) => GetTime(date)),
      hpack: 'end',
      vpack: 'end'
    }),
    Widget.Label({
      label: date.bind().as((date: Date) => GetDate(date)),
      hpack: 'end',
      vpack: 'start'
    }),
  ]
});