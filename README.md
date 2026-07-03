# dotfiles-kde-touchegg

Gestos de touchpad estilo macOS para **KDE Plasma (X11)** con [Touchégg](https://github.com/JoseExposito/touchegg) y el conmutador **Flip Switch** de KWin.

Probado en Plasma 5.27, Ubuntu Noble, sesión X11.

## Gestos

| Gesto | Acción |
|-------|--------|
| 3 dedos ↑ | Maximizar / restaurar ventana |
| 3 dedos ↓ | Minimizar ventana |
| 3 dedos ← | Ventana anterior (Flip Switch + Alt+Shift+Tab) |
| 3 dedos → | Ventana siguiente (Flip Switch + Alt+Tab) |
| 3 dedos pinch in | Cerrar ventana |
| 4 dedos ↑/↓ | Cambiar escritorio virtual |
| 4 dedos → | Lanzador de aplicaciones (Super+S) |
| 4 dedos pinch out | Mostrar escritorio |
| 4 dedos pinch in | Vista de actividades (Super+A) |
| 2 dedos tap | Clic derecho |
| 3 dedos tap | Clic medio |
| Pinch 2 dedos (Chrome/Chromium) | Zoom in/out |

El cambio de ventanas con 3 dedos usa `SEND_KEYS` con `repeat=true`: Touchégg mantiene **Alt** durante el gesto y envía **Tab**, igual que el atajo de teclado, para que KWin muestre la animación **Flip Switch** (baraja 3D).

## Requisitos

```bash
sudo apt install touchegg kwin-addons
sudo systemctl enable --now touchegg
```

- Sesión **X11** (Touchégg no funciona en Wayland).
- Usuario en el grupo `input` (habitual en Ubuntu con `touchegg` instalado).

## Instalación

```bash
git clone https://github.com/IRodriguez13/dotfiles-kde-touchegg.git
cd dotfiles-kde-touchegg
chmod +x install.sh
./install.sh
```

O manualmente:

```bash
mkdir -p ~/.config/touchegg
cp config/touchegg/touchegg.conf ~/.config/touchegg/
kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName flipswitch
kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key ShowDesktop false
qdbus org.kde.KWin /KWin reconfigure
pkill touchegg; touchegg &
```

## Verificación

1. Abrí varias ventanas.
2. Mantené **Alt** y pulsá **Tab**: debe aparecer **Flip Switch** (baraja de cartas).
3. Deslizá **3 dedos** horizontalmente: mismo comportamiento.

Si el gesto no muestra Flip Switch pero el teclado sí, reiniciá el cliente Touchégg:

```bash
pkill touchegg && touchegg &
```

## Estructura

```text
config/
  touchegg/touchegg.conf   # Gestos Touchégg
  kde/kwin-tabbox.ini      # Fragmento TabBox (Flip Switch)
install.sh                 # Copia config y aplica TabBox
```

## Notas

- Touchégg **2.0.16+** recomendado; en Wayland usar gestos nativos de Plasma o [InputActions](https://github.com/taj-ny/kwin-gestures) (Plasma 6).
- Tras instalar `kwin-addons`, puede hacer falta `kwin_x11 --replace` o cerrar sesión para cargar Flip Switch.

## Licencia

MIT — ver [LICENSE](LICENSE).
