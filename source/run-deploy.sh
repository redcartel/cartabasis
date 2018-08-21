username="testuser"
ip="142.93.240.71"

scp remote-deploy.sh $username@$ip:/home/$username/deploy/remote-deploy.sh
scp wsgi.py $username@$ip:/home/$username/deploy/wsgi.py
scp myproject.ini $username@$ip:/home/$username/deploy/myproject.ini
ssh -t $username@$ip sh /home/$username/deploy/remote-deploy.sh
