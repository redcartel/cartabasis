import re, json

source = "source/"
destination = "execute/"
filenames = ["run.sh", "run-testapp.sh", "run-deploy.sh", "remoteroot.sh", "remote-testapp.sh", "remote-deploy.sh", "wsgi.py", "myproject.ini"]

username = None
ip = None

with open config.json as file_object:
    values = json.load(file_object)
    username = values['username']
    ip = values['ip']

for filename in filenames:
    with open(source + filename, "r") as inf, open(destination + filename) as outf:
        for line in inf:
            outline = re.replace("^username=.*", "username='"+username+"'", line)
            outline = re.replace("^ip=.*", "ip='"+ip+"'")
            print(outline, end='', file=outf)
