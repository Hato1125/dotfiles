import GLib from 'gi://GLib';

export function GetReadLink(path: string): string {
  if (GLib.file_test(path, GLib.FileTest.IS_SYMLINK))
    return GLib.file_read_link(path);
  return path;
}