username="testuser"
ip="142.93.248.191"

scp remote.sh $username@$ip:/home/$username/deploy/remote-testapp.sh
ssh -t $username@$ip sh /home/$username/deploy/remote-testapp.sh
