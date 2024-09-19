import App from 'resource:///com/github/Aylur/ags/app.js';

import Style from '@App/Style';
import Statusbar from '@App/Desktop/Statusbar/Statusbar';
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
    WallpaperManager.Init();
    ColorManager.Init('/home/hato/neco.png');
    DesktopManager.Init(DESKTOP_WINDOWS, POPUP_WINDOWS);
    Style();
  }
});