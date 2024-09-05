import GLib from 'gi://GLib';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

interface TransitionPos {
  x: number;
  y: number;
}

interface TransitionBezier {
  x1: number;
  y1: number;
  x2: number;
  y2: number;
}

interface TransitionWave {
  x1: number;
  y1: number;
}

interface WallpaperInfo {
  path: string;
  monitor: number;
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
  static IsRunning(): boolean {
    return Utils.exec(
      'ps aux | grep swww-daemon | grep -v grep'
    ).length > 0;
  }

  static Init(): void {
    if(!this.IsRunning())
      Utils.exec('swww-daemon');
  }

  static Kill(): void {
    if(this.IsRunning())
      Utils.exec(['swww', 'kill']);
  }

  static SetWallpaper(path: string, monitor: string | null = null): void {
    if (!GLib.file_test(path, GLib.FileTest.EXISTS))
      throw 'The specified path does not exist.';

    if (!this.CheckExtension(path))
      throw 'Path to unsupported extension.';

    const commands: string[] = [
      'swww', 'img',
      monitor ? `--outputs ${monitor}` : '',
      '--transition_type', this._transitionType,
      '--transition_step', this._transitionStep.toString(),
      '--transition_duration', this._transitionDuration.toString(),
      '--transition_fps', this._transitionFPS.toString(),
      '--transition_angle', this._transitionAngle.toString(),
      '--transition_pos', `${this._transitionPos.x},${this._transitionPos.y}`,
      '--transition_bezier', `${this._transitionBezier.x1},${this._transitionBezier.y1},${this._transitionBezier.x2},${this._transitionBezier.y2}`,
      '--transition_wave', `${this._transitionWave.x1},${this._transitionWave.y1}`,
    ];

    Utils.exec(commands);
  }

  static GetWallpaper(monitor: string | null = null): string {
    const response: string = Utils.exec(['swww', 'query']);
    const infos = response.split('\n').map(info => {
      return info.split(':').map(part => part.trim());
    });

    let info: string[];
    if (monitor) {
      const finfo = infos.find(info => info[0] === monitor);
      if (!finfo)
        return String();
      info = finfo;
    } else {
      info = infos[0];
    }

    const result = info.find(elem => this.CheckExtension(elem));
    return result ? result : String();
  }

  private static CheckExtension(path: string): boolean {
    const lower: string = path.toLowerCase();
    return lower.endsWith('jpeg')
      || lower.endsWith('png')
      || lower.endsWith('gif')
      || lower.endsWith('pnm')
      || lower.endsWith('tga')
      || lower.endsWith('tiff')
      || lower.endsWith('webp')
      || lower.endsWith('bmp')
      || lower.endsWith('farbfeld');
  }

  private static _transitionType: TransitionType = TransitionType.None;
  private static _transitionStep: number = 255;
  private static _transitionDuration: number = 0;
  private static _transitionFPS: number = 30;
  private static _transitionAngle: number = 0;
  private static _transitionPos: TransitionPos = { x: 0, y: 0 };
  private static _transitionBezier: TransitionBezier = {
    x1: 0,
    y1: 0,
    x2: 0,
    y2: 0,
  };
  private static _transitionWave: TransitionWave = { x1: 0, y1: 0 };
}