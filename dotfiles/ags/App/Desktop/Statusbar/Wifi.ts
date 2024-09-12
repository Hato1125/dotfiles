import Network from '@Service/Network';
import Symbol from '@Lib/Symbol';

const WifiIcons: string[] = [
  'signal_wifi_0_bar',
  'network_wifi_1_bar',
  'network_wifi_2_bar',
  'network_wifi_3_bar',
  'signal_wifi_4_bar',
];

export default () => Symbol({
  label: Network.wifi.bind('strength')
    .as((strength: number) => {
      if (strength !== -1 && Network.wifi.enabled) {
        const index = Math.floor(strength / (100 / (WifiIcons.length - 1)))
        return WifiIcons[index];
      }
      return 'signal_wifi_off';
    })
});