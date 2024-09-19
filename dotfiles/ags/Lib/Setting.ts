import GLib from 'gi://GLib';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

import { GetReadLink } from './Utils';

export let Settings = {
  theme: {
    wallpaper: Variable(''),
    theme: Variable(''),
  },
  wallpaper: {
    'path': Variable(''),
    'transition_type': Variable('none'),
    'transition_step': Variable(255),
    'transition_duration': Variable(0),
    'transition_fps': Variable(30),
    'transition_angle': Variable(0),
    'transition_pos': Variable('0, 0'),
    'transition_bezier': Variable('0.54, 0.00, 0.34, 3.99'),
    'transition_wave': Variable('0, 0')
  }
}

export class SettingManager {
  static readonly SETTING_DIRE = `${GLib.get_home_dir()}/.config/desktop`;
  static readonly DESKTOP_PATH = GetReadLink(`${this.SETTING_DIRE}/desktop.json`);

  static Init(onChange: () => void): void {
    if (GLib.file_test(this.DESKTOP_PATH, GLib.FileTest.EXISTS)) {
      this.LoadSetting(this.DESKTOP_PATH);
      Utils.monitorFile(this.DESKTOP_PATH, () => {
        onChange();
        this.LoadSetting(this.DESKTOP_PATH);
      });
    }
  }

  static Load(): void {
    if (GLib.file_test(this.DESKTOP_PATH, GLib.FileTest.EXISTS)) {
      this.LoadSetting(this.DESKTOP_PATH);
    }
  }

  static Save(): void {
    const jsonObj = this.JsonToObject(Settings);
    const jsonStr = JSON.stringify(jsonObj, null, 2);
    Utils.writeFile(jsonStr, this.DESKTOP_PATH);
  }

  private static LoadSetting(path: string): void {
    const jsonStr = Utils.readFile(path);
    const jsonObj = JSON.parse(jsonStr);
    Settings = this.JsonToVariable(jsonObj) as typeof Settings;
  }

  private static JsonToVariable(Json: object): object {
    for(const [key, value] of Object.entries(Json)) {
      if (typeof value === 'object')
        this.JsonToVariable(value);
      else
        Json[key] = Variable(value);
    }
    return Json;
  }

  private static JsonToObject(Json: object): object {
    for(const [key, value] of Object.entries(Json)) {
      if (typeof value === 'object' && 'getValue' in value)
        Json[key] = value.getValue();
      else if (typeof value === 'object')
        this.JsonToObject(value);
    }
    return Json;
  }
};