echo "Disabling Ports"

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 5679
sudo ufw allow 80
sudo ufw allow 443

sudo ufw enable

sudo ufw status verbose
