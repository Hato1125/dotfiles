import App from 'resource:///com/github/Aylur/ags/app.js';

import Desktop from '@App/Desktop/Desktop';
import Style from '@App/Style';

import { ColorManager } from '@Lib/Color';
import { WallpaperManager } from '@Lib/Wallpaper';

App.config({
  onConfigParsed: () => {
    ColorManager.Init('/home/hato/neco.png');
    WallpaperManager.Init();
    Desktop();
    Style();
  }
});