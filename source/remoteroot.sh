username="testuser"

echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

apt-get -y update
apt-get -y upgrade

timedatectl set-timezone America/New_York
apt-get -y install ntp
fallocate -l 3G /swapfile
chmod 600 /swapfile
mkswap /swapfile
sh -c "echo '/swapfile none swap sw 0 0' >> /etc/fstab"
sysctl vm.swappiness=10
sh -c "echo 'vm.swappiness=10' >> /etc/sysctl.conf"
sysctl vm.vfs_cache_pressure=30
sh -c 'echo "vm.vfs_cache_pressure=30" >> /etc/sysctl.conf'
apt-get -y install fail2ban

systemctl enable fail2ban

sh -c 'echo "[DEFAULT]" >> /etc/fail2ban/jail.local'
sh -c 'echo "bantime = 7200" >> /etc/fail2ban/jail.local'
sh -c 'echo "findtime = 1200" >> /etc/fail2ban/jail.local'
sh -c 'echo "maxretry = 3" >> /etc/fail2ban/jail.local'
# sh -c 'echo "destemail = <email_addr>" >> /etc/fail2ban/jail.local'
# sh -c 'echo "sendername = security@<vps_name>" >> /etc/fail2ban/jail.local'
sh -c 'echo "banaction = iptables-multiport" >> /etc/fail2ban/jail.local'
sh -c 'echo "mta = sendmail" >> /etc/fail2ban/jail.local'
sh -c 'echo "action = %(banaction)s[name=%(__name__)s, bantime=\"%(bantime)s\", port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"], %(mta)s-whois-lines[name=%(__name__)s, dest=\"%(destemail)s\", logpath=%(logpath)s, chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local'
sh -c 'echo "" >> /etc/fail2ban/jail.local'
sh -c 'echo "[sshd]" >> /etc/fail2ban/jail.local'
sh -c 'echo "enabled = true" >> /etc/fail2ban/jail.local'
sh -c 'echo "" >> /etc/fail2ban/jail.local'
sh -c 'echo "" >> /etc/fail2ban/jail.local'
sh -c 'echo "[sshd-ddos]" >> /etc/fail2ban/jail.local'
sh -c 'echo "enabled = true" >> /etc/fail2ban/jail.local'
sh -c 'echo "" >> /etc/fail2ban/jail.local'
sh -c 'echo "[nginx-http-auth]" >> /etc/fail2ban/jail.local'
sh -c 'echo "enabled = true" >> /etc/fail2ban/jail.local'
systemctl restart fail2ban
