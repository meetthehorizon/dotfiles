# Packages

## Pacman

- save manually installed packages by official repository

```bash
comm -23 <(pacman -Qqe | sort) <(pacman -Qqm | sort) > pkglist.txt
```

- installing packages from this file

```bash
sudo pacman -S --needed - < pkglist.txt
```

## Paru

- install [paru](https://github.com/Morganamilo/paru) - AUR manager

```bash
pacman -Qqm > aurlist.txt
```

- installing AUR packages

```bash
paru -S --needed < aurlist.txt
```
# Data
- [Wallpapers](https://drive.google.com/drive/folders/12KrDoukjoMszn7dgkC9bfMmo4S6_p6gc?usp=sharing)

- [Obsidian](https://drive.google.com/file/d/1AiGlgZ17-8KGpIc0yXO-pUyYzzgB9NJi/view?usp=drive_link)