import Network from '@Service/Network';
import {
  Symbol,
  GetIcon,
} from '@Lib/Symbol';

const WIFI_ICONS: string[] = [
  'signal_wifi_0_bar',
  'network_wifi_1_bar',
  'network_wifi_2_bar',
  'network_wifi_3_bar',
  'signal_wifi_4_bar',
];

export default () => Symbol({
  setup: (self: ReturnType<typeof Symbol>) =>
    self.hook(Network, () =>
      self.label = Network.wifi.enabled && Network.wifi.strength !== -1
        ? GetIcon(Network.wifi.strength, WIFI_ICONS)
        : 'signal_wifi_off'
    )
});