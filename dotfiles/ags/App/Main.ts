import App from 'resource:///com/github/Aylur/ags/app.js';

import Desktop from '@App/Desktop/Desktop';
import Style from '@App/Style';

App.config({
  onConfigParsed: () => {
    Desktop();
    Style();
  }
});