import Battery from '@Service/Battery';
import {
  Symbol,
  GetIcon,
} from '@Lib/Symbol';

const NORMAL_ICONS: string[] = [
  'battery_0_bar',
  'battery_1_bar',
  'battery_2_bar',
  'battery_3_bar',
  'battery_4_bar',
  'battery_5_bar',
  'battery_6_bar',
  'battery_full',
];

const CHARGING_ICONS: string[] = [
  'battery_charging_full',
  'battery_charging_20',
  'battery_charging_30',
  'battery_charging_50',
  'battery_charging_60',
  'battery_charging_80',
  'battery_charging_90',
  'battery_full',
];

export default () => Symbol({
  setup: (self: ReturnType<typeof Symbol>) =>
    self.hook(Battery, () =>
      self.label = GetIcon(
        Battery.percent,
        Battery.charging ? CHARGING_ICONS : NORMAL_ICONS
      )
    ),
  angle: 90,
});