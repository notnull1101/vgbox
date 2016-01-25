# Create Vagrant VM in one simple command

Install
```
cd /opt
```
```
sudo git clone https://github.com/notnull1101/vgbox.git
```

Edit `vgbox/vgbox.sh`
```
sudo vi vgbox/vgbox.sh
APPDIR='/opt/vgbox/'
```

```
sudo ln -s /opt/vgbox/vgbox.sh /usr/local/bin/vgbox
```
Run on project
```
vgbox [box_name] [ram] [project_name]
```



