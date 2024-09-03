import Battery from '@Service/Battery';
import Symbol from '@Lib/Symbol';

const BatteryIcons: string[] = [
  'battery_0_bar',
  'battery_1_bar',
  'battery_2_bar',
  'battery_3_bar',
  'battery_4_bar',
  'battery_5_bar',
  'battery_6_bar',
  'battery_full',
];

const BatteryChargingIcons: string[] = [
  'battery_charging_full',
  'battery_charging_20',
  'battery_charging_30',
  'battery_charging_50',
  'battery_charging_60',
  'battery_charging_80',
  'battery_charging_90',
  'battery_full',
];

const BatteryIcon = () => Symbol({
  setup: (self: Widget.Label) => self.hook(Battery, () => {
    const useIconSet: string[] = Battery.charging
      ? BatteryChargingIcons
      : BatteryIcons;
    self.angle = 90;
    self.label = useIconSet[Math.floor(Battery.percent / (100 / (useIconSet.length - 1)))];
  })
});

export default () => Battery.available ? BatteryIcon() : null;