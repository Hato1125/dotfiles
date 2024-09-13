import Gtk from 'gi://Gtk';
import App from 'resource:///com/github/Aylur/ags/app.js';

import Hyprland from "@Service/Hyprland";

export type desktopWindowType = (monitor: number) => Gtk.Window;
export type popupWindowType = () => Gtk.Window;

export class DesktopManager {
  static Init(
    desktopWindows: desktopWindowType[],
    popupWindows: popupWindowType[]
  ): void {
    this.desktopWindows = desktopWindows;
    this.popupWindows = popupWindows;

    for (const monitor of Hyprland.monitors)
      this.addForMonitorDesktopWindows(monitor.id);
    this.addForMonitorPopupWindows();

    Hyprland.connect('monitor-added', (monitor: number) => {
      this.addForMonitorDesktopWindows(monitor);
    });

    Hyprland.connect('monitor-removed', (_: unknown, monitor: number) => {
      for (const window of App.windows) {
        if (window.gdkmonitor === monitor)
          App.removeWindow(window);
      }
    });
  }

  private static addForMonitorDesktopWindows(monitor: number): void {
    for (const window of this.desktopWindows)
      App.addWindow(window(monitor));
  }

  private static addForMonitorPopupWindows(): void {
    for (const window of this.popupWindows)
      App.addWindow(window());
  }

  private static desktopWindows: desktopWindowType[] = [];
  private static popupWindows: popupWindowType[] = [];
}