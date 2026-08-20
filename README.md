# SkullyOS — caelestia-dots (fork personal)

Mi configuración de escritorio para Hyprland + Quickshell, basada en
[caelestia-dots](https://github.com/caelestia-dots) ([shell](https://github.com/caelestia-dots/shell),
[cli](https://github.com/caelestia-dots/cli)) con retoques propios, pensada para
[CachyOS](https://cachyos.org).

## Qué incluye

- `hypr/` — configuración de Hyprland (animaciones, keybinds, reglas, gaps, scheme de colores, etc.)
- `quickshell/caelestia/` — el shell (barra, popouts, notificaciones, etc.) en QML
- `caelestia/` — configuración del CLI de caelestia (`shell.json`, vars de Hyprland)
- `install.sh` — script que enlaza (symlink) todo lo anterior a `~/.config`

## Guía completa: de instalar CachyOS a tener el escritorio andando

Esta guía asume una instalación limpia de CachyOS en una PC/notebook con GPU
compatible con Wayland (Intel, AMD o NVIDIA con drivers propietarios recientes).

### 1. Descargar e instalar CachyOS

1. Descargá la ISO desde [cachyos.org/download](https://cachyos.org/download/).
   Elegí la edición **KDE Plasma (Desktop)** o **Minimal** — cualquiera sirve,
   Hyprland se agrega después como sesión aparte.
2. Grabá la ISO a un USB booteable (desde Linux, reemplazá `/dev/sdX` por tu
   pendrive real, revisá con `lsblk` antes de correr esto):

   ```bash
   sudo dd if=cachyos-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
   ```

   En Windows podés usar [Rufus](https://rufus.ie) o [Ventoy](https://ventoy.net).
3. Bootear desde el USB y correr el instalador gráfico (Calamares):
   partición de disco, usuario, zona horaria, kernel (`linux-cachyos` es una
   buena opción por defecto), y confirmar instalación.
4. Reiniciar, sacar el USB y entrar al sistema recién instalado.

### 2. Primer arranque: actualizar el sistema

```bash
sudo pacman -Syu
```

CachyOS ya trae habilitados sus propios repos (`cachyos`, `cachyos-extra`,
`cachyos-core`) además de los oficiales de Arch (`core`, `extra`, `multilib`),
así que no hace falta tocar `/etc/pacman.conf`.

### 3. Verificar/instalar un AUR helper

CachyOS suele traer **paru** preinstalado. Confirmalo con:

```bash
paru --version
```

Si no lo tenés, instalalo así:

```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
```

### 4. Instalar Hyprland y utilidades base

```bash
sudo pacman -S --needed hyprland nwg-displays
```

`hyprland` es el compositor/window manager. `nwg-displays` se usa más
adelante para generar la configuración de monitores.

### 5. Instalar el shell de Caelestia (Quickshell + CLI)

Con `paru -S caelestia-shell` alcanza: trae como dependencias `caelestia-cli`,
`quickshell-git` y todo lo que el shell necesita (fuentes, íconos, utilidades
de captura/portapapeles, sensores, etc.).

```bash
paru -S caelestia-shell
```

Esto instala automáticamente, entre otros: `quickshell-git`, `caelestia-cli`,
`ttf-material-symbols-variable`, `ttf-rubik-vf`, `ttf-cascadia-code-nerd`,
`fuzzel`, `dart-sass`, `cliphist`, `grim`, `slurp`, `swappy`,
`power-profiles-daemon`, `networkmanager`, `brightnessctl`, `ddcutil`,
`libcava`, `libqalculate`, `fish`, entre otras dependencias.

> No hace falta usar la configuración por defecto que trae `caelestia-shell`:
> en el siguiente paso la vamos a reemplazar por la de este repo.

### 6. Clonar este repositorio

```bash
git clone https://github.com/Byskull2000/SkullyOS.git ~/caelestia-dots
cd ~/caelestia-dots
```

### 7. Instalar los dotfiles

```bash
./install.sh
```

El script crea symlinks de `hypr/`, `caelestia/` y `quickshell/caelestia/`
hacia tu `~/.config`, haciendo backup automático (en
`~/.config/caelestia-dots-backup-<fecha>/`) de cualquier configuración previa
que ya tuvieras ahí.

### 8. ⚠️ Ajustar la configuración de monitores

`hypr/monitors.conf`, `hypr/monitors.lua` y `caelestia/monitors/*` están
generados con [nwg-displays](https://github.com/nwg-piotr/nwg-displays) para
**mi** hardware (un panel `eDP-1` + un `HDMI-A-1`). Si tenés otra disposición
de pantallas, regenerá esos archivos después de instalar:

1. Abrí una sesión de Hyprland (ver paso siguiente) o iniciá Hyprland desde
   una tty con `Hyprland`.
2. Corré `nwg-displays` y acomodá tus monitores desde la interfaz gráfica.
3. Guardá — esto sobreescribe los archivos generados para que coincidan con
   tu hardware.

Si te saltás este paso con un hardware distinto al mío, Hyprland puede
arrancar con una disposición de monitores que no te sirve.

### 9. Iniciar sesión en Hyprland

1. Cerrá sesión (o reiniciá).
2. En la pantalla de login (SDDM/plasmalogin/GDM, según lo que hayas elegido
   al instalar CachyOS), buscá el ícono de selección de sesión (suele estar
   abajo a la izquierda o al lado del usuario) y elegí **Hyprland**.
3. Iniciá sesión normalmente. Hyprland debería levantar el shell de Caelestia
   automáticamente (ver `hypr/hyprland/execs.lua`).

Si por algún motivo el shell no arranca solo, podés lanzarlo a mano con:

```bash
caelestia shell
```

### 10. Post-instalación

- Para aplicar cambios después de editar algo del repo, reiniciá Hyprland
  (`Super` + tecla de logout, según tus keybinds en `hypr/hyprland/keybinds.lua`)
  o simplemente recargá el shell con `caelestia shell`.
- Para actualizar el fork: `cd ~/caelestia-dots && git pull` (los symlinks ya
  apuntan a esta carpeta, no hace falta correr `install.sh` de nuevo salvo que
  se hayan agregado carpetas nuevas).

## Requisitos (resumen)

- [CachyOS](https://cachyos.org) (o cualquier base Arch)
- [Hyprland](https://hyprland.org) (`pacman -S hyprland`)
- [Quickshell](https://quickshell.outfoxxed.me) (`quickshell-git`, vía AUR)
- `caelestia-shell` / `caelestia-cli` (AUR): `paru -S caelestia-shell`
- Fuentes e íconos del tema (Material Symbols, Rubik, Cascadia Code Nerd Font)
  — se instalan solas como dependencias de `caelestia-shell`

## Licencia

GPL-3.0, igual que el proyecto original (ver `quickshell/caelestia/LICENSE`).
