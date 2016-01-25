# Create Vagrant VM in one simple command

Install

```
cd /opt
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
Usage 

```
mkdir ~/Vagrant
cd ~/Vagrant
vgbox [box_name] [ram] [project_name]
```
![screenshot](https://raw.githubusercontent.com/notnull1101/vgbox/master/img/img01.png)
