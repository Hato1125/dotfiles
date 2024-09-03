import GLib from 'gi://GLib';
import Gio from 'gi://Gio';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

import { Wallpaper } from '@Lib/Wallpaper';

import {
  PaletteTheme,
  MaterialColor,
} from '@Lib/MaterialColor';

import {
  CSS_DIR,
  MAIN_CSS,
  COLOR_CSS,
} from '@Other/Path';

export default (): void => {
  Utils.writeFile(
    MaterialColor.GetPaletteCss(
      Wallpaper.GetWallpaper(),
      PaletteTheme.Dark
    ),
    COLOR_CSS
  );

  const dir: GLib.File = Gio.File.new_for_path(CSS_DIR);
  const enu: GLib.FileEnumerator = dir.enumerate_children('standard::*', Gio.FileQueryInfoFlags.NONE, null);
  while(true) {
    const info: Gio.FileInfo = enu.next_file(null);
    if (!info)
      break;

    if(info.get_name().endsWith('.css')) {
      let filePath: string = `${CSS_DIR}/${info.get_name()}`;
      if(GLib.file_test(filePath, GLib.FileTest.IS_SYMLINK))
        filePath = GLib.file_read_link(filePath);

      Utils.monitorFile(filePath, () => {
        App.applyCss(MAIN_CSS, true);
      });
    }
  }

  App.applyCss(MAIN_CSS, true);
}