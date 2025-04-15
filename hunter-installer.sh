#!/bin/bash

set -e

echo "🛡️  Pixel Services Hunter Installer"
echo "--------------------------------"

read -p "🔁 Enter update frequency in minutes (e.g. 60): " frequency
frequency="${frequency:-60}"

read -p "🚧 Choose iptables chain [DOCKER-USER/INPUT] (default: DOCKER-USER): " chain
chain="${chain:-DOCKER-USER}"

echo "⏳ Setting update frequency to every $frequency minutes"
echo "📦 Using iptables chain: $chain"

curl -fsSL https://raw.githubusercontent.com/pebblehost/hunter/refs/heads/master/block.sh -o /usr/local/bin/block.sh

if ! head -n 1 /usr/local/bin/block.sh | grep -q "^#!/bin/bash"; then
  sed -i '1i#!/bin/bash' /usr/local/bin/block.sh
fi

chmod +x /usr/local/bin/block.sh

sed -i "s/DOCKER-USER/$chain/g" /usr/local/bin/block.sh

cat <<EOF > /etc/systemd/system/blocklist-update.service
[Unit]
Description=Update IP blacklist from remote source
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/block.sh
EOF

# Create systemd timer
cat <<EOF > /etc/systemd/system/blocklist-update.timer
[Unit]
Description=Run IP blacklist updater every $frequency minutes

[Timer]
OnBootSec=5min
OnUnitActiveSec=${frequency}min
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Reload systemd and enable timer
systemctl daemon-reexec || systemctl daemon-reload
systemctl enable --now blocklist-update.timer

echo ""
echo "✅ Installed! Your blacklist updater will now run every $frequency minutes."
echo "🔍 View status: systemctl status blocklist-update.timer"
echo "📄 Logs: journalctl -u blocklist-update.service"
