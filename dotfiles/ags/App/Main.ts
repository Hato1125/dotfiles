import App from 'resource:///com/github/Aylur/ags/app.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

import Style from '@App/Style';
import Statusbar from '@App/Desktop/Statusbar/Statusbar';
import { SettingManager, Settings } from '@Lib/Setting';
import { ScreenCorners, StatusbarCorners } from '@App/Desktop/Corner/Corner';
import { ColorManager } from '@Lib/Color';
import { WallpaperManager } from '@Lib/Wallpaper';
import { DesktopManager } from '@Lib/Desktop';

const DESKTOP_WINDOWS = [
  Statusbar,
  ...ScreenCorners,
  ...StatusbarCorners
];

const POPUP_WINDOWS = [
];

App.config({
  onConfigParsed: () => {
    const OnChange = () => {
      const json = ColorManager.GenerateColorJson(
        Settings.theme.wallpaper.getValue(),
        ColorManager.GetTheme()
      );

      Utils.writeFile(
        ColorManager.ConvertCSS(json),
        ColorManager.COLOR_CSS_PATH
      );

      WallpaperManager.SetWallpaper(
        Settings.wallpaper.path.getValue()
      );
    }

    SettingManager.Init(OnChange);
    WallpaperManager.Init();
    DesktopManager.Init(DESKTOP_WINDOWS, POPUP_WINDOWS);

    OnChange();
    Style();
  }
});