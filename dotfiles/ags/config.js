import GLib from "gi://GLib";

let outputPath = '/tmp/ags/main.js';
let targetPath = `${App.configDir}/App/Main.ts`;

// The target file may be a symbolic link,
// so check it and set the link destination path.
if(!GLib.file_test(targetPath, GLib.FileTest.IS_SYMLINK))
  targetPath = GLib.file_read_link(targetPath);

await Utils.execAsync([
  'bun', 'build', targetPath,
  '--outfile', outputPath,
  '--external', 'resource://*',
  '--external', 'gi://*',
  '--external', 'file://*',
]).catch(err => {
  console.error('An error occurred during build.');
  console.error('Error details below:');
  console.error(err);
  App.quit();
});

await import(`file://${outputPath}`);