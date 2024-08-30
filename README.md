# Dotfiles
Small configuration for Hyprland.

# Installation
The installation requires Python3, so please install it in advance.
After cloning the repository, enter the directory and run `install.py`.
When you run `install.py`, the necessary packages are automatically downloaded.
The dot file will be copied.
```bash
git clone https://github.com/Hato1125/dotfiles.git
cd dotfiles
python3 install.py
```

# Packages
When adding a package, change `packages.toml` in the configs directory.
|Property|Explanation|
|:-|:-|
|type|Package type|
|name|package name|
|install|Installation name|
|manager|Package manager to use|

# Dotfiles
When adding a dotfile, change `dotfiles.toml` in the configs directory.
|Property|Explanation|
|:-|:-|
|src|Dot file directory name|
|dest|Destination directory name|