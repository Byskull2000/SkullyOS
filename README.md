# caelestia-dots (fork personal)

Mi configuración de escritorio para Hyprland + Quickshell, basada en
[caelestia-dots](https://github.com/caelestia-dots) ([shell](https://github.com/caelestia-dots/shell),
[cli](https://github.com/caelestia-dots/cli)) con retoques propios.

## Qué incluye

- `hypr/` — configuración de Hyprland (animaciones, keybinds, reglas, gaps, scheme de colores, etc.)
- `quickshell/caelestia/` — el shell (barra, popouts, notificaciones, etc.) en QML
- `caelestia/` — configuración del CLI de caelestia (`shell.json`, vars de Hyprland)

## Requisitos

- [Hyprland](https://hyprland.org)
- [Quickshell](https://quickshell.outfoxxed.me)
- `caelestia-cli` (AUR): `paru -S caelestia-cli`
- Fuentes e íconos que use el tema (Material Symbols, etc. — ver `caelestia-cli` para instalación automática de dependencias)

## Instalación

```bash
git clone <URL-DE-ESTE-REPO> ~/caelestia-dots
cd ~/caelestia-dots
./install.sh
```

El script crea symlinks de `hypr/`, `caelestia/` y `quickshell/caelestia/` hacia
tu `~/.config`, haciendo backup de lo que ya tengas ahí.

## ⚠️ Monitores

`hypr/monitors.conf`, `hypr/monitors.lua` y `caelestia/monitors/*` están
generados por [nwg-displays](https://github.com/nwg-piotr/nwg-displays) para
**mi** hardware (un panel eDP-1 + un HDMI-A-1). Si tenés otra configuración de
monitores, regenerá esos archivos con `nwg-displays` después de instalar —
si no, Hyprland puede arrancar con una disposición que no te sirve.

## Licencia

GPL-3.0, igual que el proyecto original (ver `quickshell/caelestia/LICENSE`).
