#!/usr/bin/env python3

import os
import shutil
import tomllib
import pathlib
import subprocess

PACKAGES_CONFIG_PATH = './configs/packages.toml'
DOTFILES_CONFIG_PATH = './configs/dotfiles.toml'

def print_err(message):
  print(f'\033[32m{message}\033[0m')

def print_success(message):
  print(f'\033[34m{message}\033[0m')

def main():
  print('Install dotfiles...')

  try:
    with open(PACKAGES_CONFIG_PATH, 'rb') as f:
      packages = tomllib.load(f)
      check_and_install_packages(packages)

    with open(DOTFILES_CONFIG_PATH, 'rb') as f:
      dotfiles = tomllib.load(f)
      create_dotfiles_symlinks(dotfiles)
  except Exception as e:
    print_err(f"An error occurred: {e}")

  print_success('Dotfiles installed successfully!')

def package_install(manager: str, package: str):
  try:
    match manager:
      case 'pacman':
        subprocess.run([f'sudo pacman {package}'], shell=True)
      case 'yay':
        subprocess.run([f'yay -S {package}'], shell=True)
      case 'paru':
        subprocess.run([f'paru -S {package}'], shell=True)
      case _:
        raise ValueError('Invalid package manager')
  except subprocess.CalledProcessError as err:
    raise Exception(f'Error while installing package {package}: {err}')

def package_check_install(manager: str, package: str) -> bool:
  try:
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
  except subprocess.CalledProcessError as err:
    raise Exception(f'Error while checking package {package}: {err}')

  return len(result.stdout) != 0

def check_and_install_packages(packages: dict):
  for key in packages:
    package = packages[key]
    try:
      if not package_check_install(package['manager'], package['name']):
        package_install(package['manager'], package['name'])
        if 'command' in package:
          subprocess.run([package['command']], shell=True)
    except ValueError as err:
      print_err(err)
    except Exception as err:
      print_err(err)

def create_symlink(src: pathlib.Path, dest: pathlib.Path):
  try:
    if os.path.exists(dest):
      shutil.rmtree(dest)
    os.mkdir(dest)
    for file in pathlib.Path(src).rglob('*'):
      src_path = file.absolute()
      dest_path = pathlib.Path(dest) / file.relative_to(src)
      if not os.path.exists(dest_path):
        if file.is_dir():
          os.mkdir(dest_path)
        else:
          os.symlink(src_path, dest_path)
  except PermissionError as e:
    print_err(f"Permission error: {e}")
  except OSError as e:
    print_err(f"Error handling file system: {e}")
  except Exception as e:
    print_err(f"An unexpected error occurred: {e}")

def create_dotfiles_symlinks(dotfiles: dict):
  for key in dotfiles:
    dotfile = dotfiles[key]
    src = pathlib.Path('dotfiles') / pathlib.Path(dotfile['src'])
    dest = pathlib.Path(os.environ['HOME']) / pathlib.Path(dotfile['dest'])
    create_symlink(src, dest)

if __name__ == '__main__':
  main()