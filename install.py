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
      subprocess.run([f'sudo pacman {package}'], shell=True)
    case 'yay':
      subprocess.run([f'yay -S {package}'], shell=True)
    case 'paru':
      subprocess.run([f'paru -S {package}'], shell=True)
    case _:
      raise ValueError('Invalid package manager')

def package_check_install(manager: str, package: str) -> bool:
  result: subprocess.CompletedProcess;
  match manager:
    case 'pacman':
      result = subprocess.run(['pacman', '-Qs', package], shell=False, capture_output=True, text=True)
    case 'yay':
      result = subprocess.run(['yay', '-Qs', package], shell=False, capture_output=True, text=True)
    case 'paru':
      result = subprocess.run(['paru', '-Qs', package], shell=False, capture_output=True, text=True)
    case _:
      raise ValueError('Invalid package manager')
  return len(result.stdout) != 0

def check_and_install_packages(packages: dict):
  for key in packages:
    package = packages[key]
    if not package_check_install(package['manager'], package['name']):
      package_install(package['manager'], package['name'])

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