import Audio from '@Service/Audio';
import Symbol from '@Lib/Symbol';

export default () => Symbol({
  setup: (self: ReturnType<typeof Symbol>) => {
    self.hook(Audio.speaker, () => {
      if (Audio.speaker.is_muted)
        self.label = 'volume_off';
      else if (Audio.speaker.volume <= 0)
        self.label = 'volume_mute';
      else if (Audio.speaker.volume > 0)
        self.label = 'volume_up';
    });
  }
});