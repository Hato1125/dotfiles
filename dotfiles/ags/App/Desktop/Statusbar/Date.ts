import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

const date = Variable('', {
  poll: [1000, () => new Date()]
});

function getDate(today: Date): string {
  const year = today.getFullYear();
  const month = today.getMonth() + 1;
  const date = today.getDate();
  return `${year}/${month}/${date}`;
}

function getTime(today: Date): string {
  const hourse = String(today.getHours()).padStart(2, '0');
  const minutes = String(today.getMinutes()).padStart(2, '0');
  return `${hourse}:${minutes}`;
}

export default () => Widget.Box({
  class_name: 'dates',
  vpack: 'center',
  vertical: true,
  hexpand: true,
  children: [
    Widget.Label({
      label: date.bind().as((today: Date) => getTime(today)),
      hpack: 'end',
      vpack: 'end'
    }),
    Widget.Label({
      label: date.bind().as((today: Date) => getDate(today)),
      hpack: 'end',
      vpack: 'start'
    }),
  ]
});