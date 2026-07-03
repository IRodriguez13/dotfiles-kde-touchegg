#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOUCHEGG_DEST="${XDG_CONFIG_HOME:-$HOME/.config}/touchegg"
KWINRC="${XDG_CONFIG_HOME:-$HOME/.config}/kwinrc"

mkdir -p "$TOUCHEGG_DEST"

if [[ -f "$TOUCHEGG_DEST/touchegg.conf" ]]; then
    cp -a "$TOUCHEGG_DEST/touchegg.conf" "$TOUCHEGG_DEST/touchegg.conf.bak.$(date +%Y%m%d%H%M%S)"
fi

cp "$ROOT/config/touchegg/touchegg.conf" "$TOUCHEGG_DEST/touchegg.conf"

if command -v kwriteconfig5 >/dev/null 2>&1; then
    kwriteconfig5 --file "$KWINRC" --group TabBox --key LayoutName flipswitch
    kwriteconfig5 --file "$KWINRC" --group TabBox --key ShowDesktop false
    if command -v qdbus >/dev/null 2>&1; then
        qdbus org.kde.KWin /KWin reconfigure >/dev/null 2>&1 || true
    fi
fi

pkill touchegg 2>/dev/null || true
sleep 0.5
if systemctl is-active --quiet touchegg 2>/dev/null; then
    sudo systemctl restart touchegg 2>/dev/null || true
fi
touchegg >/dev/null 2>&1 &

echo "Instalado:"
echo "  $TOUCHEGG_DEST/touchegg.conf"
echo "  TabBox LayoutName=flipswitch en $KWINRC"
echo ""
echo "Dependencias: touchegg, kwin-addons (Flip Switch), sesión X11 + KDE Plasma."
