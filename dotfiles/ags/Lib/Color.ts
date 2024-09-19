import GLib from 'gi://GLib';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

import { Settings } from '@Lib/Setting';

interface Color {
  colors: {
    dark: object,
    light: object,
  }
}

export enum Theme {
  Light,
  Dark,
}

export class ColorManager {
  static readonly COLOR_JSON_DIRE = `${App.configDir}/Css`;
  static readonly COLOR_CSS_PATH = `${this.COLOR_JSON_DIRE}/color.css`;

  static GenerateColorJson(image: string, theme: Theme): object {
    if (image === '')
      throw 'No wallpaper has been set.';

    if (!GLib.file_test(image, GLib.FileTest.EXISTS))
      throw 'Wallpaper does not exist.';

    try {
      const colors = JSON.parse(
        Utils.exec(['matugen', '-j', 'hex', 'image', image])
      );

      if(theme === Theme.Light)
        return colors.colors.light;
      else if(theme === Theme.Dark)
        return colors.colors.dark;
    } catch (_) {
      throw 'Failed to generate color.';
    }
  }

  static ConvertCSS(json: object): string {
    return Object.entries(json)
      .map(([k, v]) => {
        return `@define-color ${k.replaceAll('_', '-')} ${v};`;
      })
      .join('\n');
  }

  static GetTheme(): Theme {
    return Settings.theme.theme.getValue() === 'dark'
      ? Theme.Dark
      : Theme.Light;
  }
}