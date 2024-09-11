import GLib from 'gi://GLib';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

import { Info, Error } from '@Lib/Logger';

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

  static Init(image: string): void {
    const color = this.theme === Theme.Dark
      ? this.GenerateColor(image).colors.dark
      : this.GenerateColor(image).colors.light;

    Utils.writeFile(
      this.ConvertCSS(color),
      this.COLOR_CSS_PATH
    );
  }

  static GenerateColor(image: string): Color {
    if (image === '')
      throw 'No wallpaper has been set.';

    if (!GLib.file_test(image, GLib.FileTest.EXISTS))
      throw 'Wallpaper does not exist.';

    try {
      return JSON.parse(
        Utils.exec(['matugen', '-j', 'hex', 'image', image])
      );
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

  private static theme: Theme = Theme.Dark;
}