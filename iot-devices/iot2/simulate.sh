#!/bin/sh
set -e

echo "[*] Setting weak passwords"
echo "root:123456" | chpasswd
adduser -D -H -G users admin
echo "admin:admin" | chpasswd

echo "[*] Installing required packages"
apk update
apk add busybox-extras

echo "[*] Enabling and starting Telnet server (via busybox)"
# Ensure /etc/inittab enables telnet on tty
if ! grep -q "telnetd" /etc/inittab; then
  echo "::respawn:/usr/sbin/telnetd -F" >> /etc/inittab
fi

# Restart init to launch telnetd
kill -HUP 1

echo "[*] Disabling firewall (if any) to simulate insecure default settings"
if command -v iptables >/dev/null 2>&1; then
  iptables -F
fi

echo "[*] IoT device setup complete!"
echo "Credentials: root / 123456   |   admin / admin"
echo "Service running: Telnet (via busybox)"
