username="testuser"
ip="142.93.248.209"

scp remote.sh $username@$ip:/home/$username/deploy/remote-deploy.sh
ssh -t $username@$ip sh /home/$username/deploy/remote-deploy.sh

echo "[Unit]"
echo "Description=uWSGI instance to serve myproject"
echo "After=network.target"
echo ""
echo "[Service]"
echo "User=$username"
echo "Group=www-data"
echo "WorkingDirectory=/home/$username/myproject"
echo "Environment='PATH=/home/$username/myproject/myprojectenv/bin'"
echo "ExecStart=/home/$username/myproject/myprojectenv/bin/uwsgi --ini myproject.ini"
