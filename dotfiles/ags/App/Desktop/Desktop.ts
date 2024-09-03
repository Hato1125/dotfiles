import Gtk from 'gi://Gtk';
import App from 'resource:///com/github/Aylur/ags/app.js';

import { Wallpaper } from '@Lib/Wallpaper';

import Hyprland from "@Service/Hyprland";

import {
  ScreenCorners,
  StatusbarCorners,
} from '@App/Corner/Corner';

import Statusbar from '@App/Desktop/Statusbar/Statusbar';

type desktopWindowType = (monitor: number) => Gtk.Window;
const DESKTOP_WINDOW: desktopWindowType[] = [
  ...ScreenCorners,
  ...StatusbarCorners,
  Statusbar,
];

type popupWindowType = () => Gtk.Window;
const POPUP_WINDOW: popupWindowType[] = [];

function addMonitorDesktopWindows(monitor: number): void {
  for (const window of DESKTOP_WINDOW)
    App.addWindow(window(monitor));
}

function addMonitorPopupWindows(): void {
  for (const window of POPUP_WINDOW)
    App.addWindow(window());
}

function MonitorAdded(disp: object, monitor: number): void {
  addMonitorDesktopWindows(monitor);
}

function MonitorRemoved(disp: object, monitor: number): void {
  for (const window of App.windows) {
    if (window.gdkmonitor === monitor)
      App.removeWindow(window);
  }
}

export default (): void => {
  Wallpaper.SetWallpaper(Wallpaper.GetWallpaper());

  Hyprland.connect('monitor-added', MonitorAdded);
  Hyprland.connect('monitor-removed', MonitorRemoved);

  for (const monitor of Hyprland.monitors)
    addMonitorDesktopWindows(monitor.id);
  addMonitorPopupWindows();
}