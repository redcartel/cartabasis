import re, json

source = "source/"
destination = "execute/"
filenames = ["run.sh", "run-testapp.sh", "run-deploy.sh", "remoteroot.sh", "remote-testapp.sh", "remote-deploy.sh", "wsgi.py", "myproject.ini", "test.txt"]

username = None
ip = None

with open("config.json", "r") as file_object:
    values = json.load(file_object)
    username = values['username']
    ip = values['ip']

for filename in filenames:
    with open(source + filename, "r") as inf, open(destination + filename, "w") as outf:
        for line in inf:
            if re.search("^username=.*", line):
                outline = re.sub("^username=.*", "username='"+username+"'", line)
            elif re.search("^ip=.*", line):
                outline = re.sub("^ip=.*", "ip='"+ip+"'", line)
            else:
                outline = line
            print(outline, end='', file=outf)
