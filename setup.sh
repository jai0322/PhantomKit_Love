#!/bin/bash

echo "🔧 Instalando dependencias..."
pkg update -y && pkg upgrade -y
pkg install php wget curl unzip -y

echo "⬇️ Descargando ngrok..."
wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
unzip ngrok.zip
chmod +x ngrok

echo "🔐 Para usar ngrok, necesitas un token. Ve a:"
echo "👉 https://dashboard.ngrok.com/get-started"
echo -n "📥 Pega aquí tu token: "
read token
./ngrok authtoken $token

echo "⬇️ Descargando cloudflared..."
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm -O cloudflared
chmod +x cloudflared

echo "✅ Todo listo. Ahora ejecuta:"
echo "bash start.sh"