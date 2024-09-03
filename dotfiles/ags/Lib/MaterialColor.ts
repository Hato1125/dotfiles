import GLib from "gi://GLib";
import Utils from "resource:///com/github/Aylur/ags/utils.js";

// Decide the name based on the returned JSON
interface Colors {
  background: string;
  error: string;
  error_container: string;
  inverse_primary: string;
  inverse_on_surface: string;
  inverse_surface: string;
  on_background: string;
  on_error: string;
  on_error_container: string;
  on_primary: string;
  on_primary_container: string;
  on_primary_fixed: string;
  on_primary_fixed_variant: string;
  on_secondary: string;
  on_secondary_container: string;
  on_secondary_fixed: string;
  on_secondary_fixed_variant: string;
  on_surface: string;
  on_surface_variant: string;
  on_tertiary: string;
  on_tertiary_container: string;
  on_tertiary_fixed: string;
  on_tertiary_fixed_variant: string;
  primary: string;
  primary_container: string;
  primary_fixed: string;
  primary_fixed_dim: string;
  primary_fixed_variant: string;
  secondary: string;
  secondary_container: string;
  secondary_fixed: string;
  secondary_fixed_dim: string;
  surface: string;
  surface_bright: string;
  surface_container: string;
  surface_container_high: string;
  surface_container_highest: string;
  surface_container_low: string;
  surface_container_lowest: string;
  surface_dim: string;
  surface_variant: string;
  shadow: string;
  scrim: string;
  source_color: string;
  tertiary: string;
  tertiary_container: string;
  tertiary_fixed: string;
  tertiary_fixed_dim: string;
  tertiary_fixed_variant: string;
}

interface Palette {
  colors: {
    dark: Colors;
    light: Colors;
  }
}

export enum PaletteTheme {
  Dark,
  Light,
}

export class MaterialColor {
  static GetPalette(path: string, theme: PaletteTheme): Colors {
    if (!GLib.file_test(path, GLib.FileTest.EXISTS))
      throw 'The specified path does not exist.';

    const response = Utils.exec([
      'matugen',
      '--json', 'hex',
      'image', path,
    ]);

    return theme === PaletteTheme.Dark
      ? JSON.parse(response).colors.dark
      : JSON.parse(response).colors.light;
  }

  static GetPaletteCss(path: string, theme: PaletteTheme): string {
    return Object.entries(this.GetPalette(path, theme))
      .map(([k, v]) => {
        // Since hyphens cannot be used on the interface side,
        // we will convert the underscore here.
        return `@define-color ${k.replaceAll('_', '-')} ${v};`;
      })
      .join('\n');
  }
}