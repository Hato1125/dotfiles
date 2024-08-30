#!/usr/bin/env python3

import os
import shutil
import tomllib
import pathlib
import subprocess

PACKAGES_CONFIG_PATH = './configs/packages.toml'
DOTFILES_CONFIG_PATH = './configs/dotfiles.toml'

def main():
  with open(PACKAGES_CONFIG_PATH, 'rb') as f:
    packages = tomllib.load(f)
    check_and_install_packages(packages)

  with open(DOTFILES_CONFIG_PATH, 'rb') as f:
    dotfiles = tomllib.load(f)
    create_dotfiles_symlinks(dotfiles)

def package_install(manager: str, package: str):
  match manager:
    case 'pacman':
      subprocess.run(f'sudo pacman {package}', shell=True)
    case 'yay':
      subprocess.run(f'yay -S {package}', shell=True)
    case 'paru':
      subprocess.run(f'paru -S {package}', shell=True)
    case _:
      raise ValueError('Invalid package manager')

def check_and_install_packages(packages: dict):
  for key in packages:
    package = packages[key]
    if package['type'] == 'font':
      result = subprocess.run(f'fc-list "{package['font']}"', shell=False)
      if result is None:
        package_install(package['manager'], package['name'])
    elif package['type'] == 'tool':
      if shutil.which(package['name']) is None:
        package_install(package['manager'], package['install'])
    else:
      raise ValueError('Invalid package type')

def create_symlink(src: pathlib.Path, dest: pathlib.Path):
  if not os.path.exists(dest):
    os.mkdir(dest)
  for file in pathlib.Path(src).rglob('*'):
    src_path = file.absolute()
    dest_path = pathlib.Path(dest) / file.relative_to(src)
    if not os.path.exists(dest_path):
      if file.is_dir():
        os.mkdir(dest_path)
      else:
        os.symlink(src_path, dest_path)

def create_dotfiles_symlinks(dotfiles: dict):
  for key in dotfiles:
    dotfile = dotfiles[key]
    src = pathlib.Path('dotfiles') / pathlib.Path(dotfile['src'])
    dest = pathlib.Path(os.environ['HOME']) / pathlib.Path(dotfile['dest'])
    create_symlink(src, dest)

if __name__ == '__main__':
  main()