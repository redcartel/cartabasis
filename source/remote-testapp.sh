#! /bin/sh

sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow 5000
sudo ufw enable

sudo apt-get install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
sudo apt-get install -y python3-venv

mkdir ~/myproject
cd ~/myproject
python3.6 -m venv myprojectenv

myprojectenv/bin/pip install wheel
myprojectenv/bin/pip install uwsgi flask

rm -f ~/myproject/myproject.py
echo "from flask import Flask" > ~/myproject/myproject.py
echo "app = Flask(__name__)" >> ~/myproject/myproject.py
echo "@app.route('/')" >> ~/myproject/myproject.py
echo "def hello():" >> ~/myproject/myproject.py
echo "    return('<b>Test Project</b>')" >> ~/myproject/myproject.py
echo "if __name__ == '__main__':" >> ~/myproject/myproject.py
echo "    app.run(host='0.0.0.0')" >> ~/myproject/myproject.py

myprojectenv/bin/python myproject.py
