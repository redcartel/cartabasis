#! /bin/sh

ip="142.93.240.71"
username="testuser"

# CREATE USER

echo "=========== USER CREATION +============="
ssh root@$ip useradd -m -s /bin/bash $username
ssh root@$ip cat /dev/null > ~/.bash_history && history -c && exit
ssh root@$ip mkdir /home/$username/.ssh
scp ~/.ssh/id_rsa.pub root@$ip:/home/$username/.ssh/authorized_keys
ssh root@$ip chown -R $username:$username /home/$username/.ssh 
ssh root@$ip chmod 700 /home/$username/.ssh
ssh root@$ip chmod 644 /home/$username/.ssh/authorized_keys
ssh root@$ip usermod -aG sudo $username
ssh $username@$ip mkdir /home/$username/deploy
scp remoteroot.sh root@$ip:/root/remoteroot.sh
ssh root@$ip sh /root/remoteroot.sh
