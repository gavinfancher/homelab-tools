#!/bin/bash
# VM Clone Preparation Script

# Prompt for new hostname
read -p "Enter new hostname: " NEW_HOSTNAME

# Validate hostname is not empty
if [ -z "$NEW_HOSTNAME" ]; then
  echo "Error: Hostname cannot be empty"
  exit 1
fi

echo "Setting hostname to: $NEW_HOSTNAME"

# Set new hostname
sudo hostnamectl set-hostname "$NEW_HOSTNAME"

# Update /etc/hosts with new hostname
sudo sed -i "s/$(hostname)/$(hostname)/g" /etc/hosts

# Regenerate machine-id
echo "Regenerating machine-id..."
sudo rm -f /etc/machine-id
sudo rm -f /var/lib/dbus/machine-id
sudo systemd-machine-id-setup

# Clear Tailscale state to get new identity
echo "Clearing Tailscale state..."
sudo systemctl stop tailscaled
sudo rm -f /var/lib/tailscale/tailscaled.state

# Apply netplan to get new DHCP IP (if using netplan)
echo "Applying network configuration..."
sudo netplan apply

# Restart Tailscale
sudo systemctl start tailscaled

echo ""
echo "VM preparation complete!"
echo "After reboot, run 'sudo tailscale up' to reconnect to Tailscale."
echo "You'll need to approve the new device in Tailscale admin console."
echo ""
echo "Rebooting system in 3 seconds... (Press Ctrl+C to cancel)"
sleep 3

sudo reboot
