import GLib from 'gi://GLib';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

import Hyprland from './Service/Hyprland';

import { Settings } from './Setting';

interface Monitor {
  id: number;
  name: string;
}

export enum TransitionType {
  None = 'none',
  Simple = 'simple',
  Fade = 'fade',
  Left = 'left',
  Right = 'right',
  Top = 'top',
  Bottom = 'bottom',
  Center = 'center',
  Outer = 'outer',
  Any = 'any',
  Random = 'random',
  Wipe = 'wipe',
  Wave = 'wave',
  Grow = 'grow',
}

export class Wallpaper {
  constructor(monitorID: number, image: string) {
    if (!GLib.file_test(image, GLib.FileTest.EXISTS))
      throw 'Image does not exist.';

    if (!this.IsSupportExtension(image))
      throw 'This image file is not supported.';

    const monitorInfo = Hyprland.monitors.find((monitor: Monitor) => {
      if (monitor.id === monitorID)
        return monitor;
    });

    if (!monitorInfo)
      throw 'The specified monitor was not found.';

    this.monitor = monitorInfo.name;
    this.scale = monitorInfo.scale;
    this.image = image;
  }

  get Monitor(): string {
    return this.monitor;
  }

  get Image(): string {
    return this.image;
  }

  get Scale(): number {
    return this.scale;
  }

  private IsSupportExtension(image: string): boolean {
    const extension = image
      .toLowerCase()
      .split('.')
      .pop();

    return extension === 'jpeg'
      || extension === 'jpg'
      || extension === 'png'
      || extension === 'gif'
      || extension === 'pnm'
      || extension === 'tga'
      || extension === 'tiff'
      || extension === 'webp'
      || extension === 'bmp'
      || extension === 'farbfeld';
  }

  private monitor: string;
  private image: string;
  private scale: number;
}

export class WallpaperManager {
  static Init(): void {
    if (!this.IsRunningSwwwDaemon()) {
      Utils.exec('swww-daemon');
    }

    this.QueryWallpaper();

    this.transitionType = Settings.wallpaper.transition_type.getValue();
    this.transitionStep = Settings.wallpaper.transition_step.getValue();
    this.transitionDuration = Settings.wallpaper.transition_duration.getValue();
    this.transitionFps = Settings.wallpaper.transition_fps.getValue();
    this.transitionAngle = Settings.wallpaper.transition_angle.getValue();
    this.transitionPos = Settings.wallpaper.transition_pos.getValue();
    this.transitionBezier = Settings.wallpaper.transition_bezier.getValue();
    this.transitionWave = Settings.wallpaper.transition_wave.getValue();
  }

  static Quit(): void {
    if(this.IsRunningSwwwDaemon()) {
      Utils.exec(['pkill', '-15', this.GetProccesIDSwwwDaemon()])
    }

    this.wallpapers = [];
  }

  static SetWallpaper(image: string, monitorID: number = -1): void {
    let outputMonitor: string[] = [];

    if (monitorID !== -1) {
      const monitor = Hyprland.monitors.find((monitor: Monitor) => {
        return monitor.id === monitorID;
      });

      if (!monitor) {
        throw 'The specified monitor was not found.';
      }

      outputMonitor = ['--outputs', monitor.name];
    }

    Utils.exec([
      'swww', 'img', image,
      ...outputMonitor,
      '--transition-type', this.transitionType.toString(),
      '--transition-step', this.transitionStep.toString(),
      '--transition-duration', this.transitionDuration.toString(),
      '--transition-fps', this.transitionFps.toString(),
      '--transition-angle', this.transitionAngle.toString(),
      '--transition-pos', `${this.transitionPos[0]},${this.transitionPos[0]}`,
      '--transition-bezier', `${this.transitionBezier[0]},${this.transitionBezier[1]},${this.transitionBezier[2]},${this.transitionBezier[3]}`,
      '--transition-wave', `${this.transitionWave[0]},${this.transitionWave[1]}`,
    ]);

    this.QueryWallpaper();
  }

  private static IsRunningSwwwDaemon(): boolean {
    return Utils.exec(['pgrep', '-x', 'swww-daemon']).length > 0;
  }

  private static GetProccesIDSwwwDaemon(): string {
    return Utils.exec(['pgrep', '-x', 'swww-daemon']);
  }

  private static QueryWallpaper(): void {
    Utils.exec(['swww', 'query'])
      .split('\n')
      .forEach((str: string) => {
        const info = str
          .split(/(,)/)
          .filter((w: string) => w !== ',')
          .map((w: string) => w.replaceAll(' ', ''));

        this.wallpapers.push(new Wallpaper(0, info[2].split(':')[2]));
      });
  }

  private static wallpapers: Wallpaper[] = [];
  public static monitor: string = '';
  public static image: string = '';
  public static scale: number = 0;
  public static transitionType: TransitionType = TransitionType.None;
  public static transitionStep: number = 255;
  public static transitionDuration: number = 0;
  public static transitionFps: number = 30;
  public static transitionAngle: number = 0;
  public static transitionPos: [number, number] = [0, 0];
  public static transitionBezier: [number, number, number, number] = [.54, 0, .34, 3.99];
  public static transitionWave: [number, number] = [0, 0];
}