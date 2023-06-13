#!/bin/sh

alertmanagerver="0.25.0"


findarch () {
    if [ "$(uname -p)" = "aarch64" ] ; then
        arch=arm64
	    echo $arch
    elif [ "$(uname -p)" = "x86_64" ] ; then
        arch=amd64
	    echo $arch
    else
        echo "Architecture not recognized"
        exit
    fi
}

findarch

sudo useradd --no-create-home alertmanager
sudo mkdir /etc/alertmanager
sudo mkdir /var/lib/alertmanager

wget https://github.com/prometheus/alertmanager/releases/download/v"$alertmanagerver"/alertmanager-"$alertmanagerver".linux-"$arch".tar.gz
tar xzf alertmanager-"$alertmanagerver".linux-"$arch".tar.gz

cd alertmanager-"$alertmanagerver".linux-"$arch"
sudo cp amtool alertmanager /usr/local/bin

sudo cp alertmanager.yml /etc/alertmanager
wget https://github.com/justsaumit/internship-learning/raw/main/Day14-130623/alertmanager.service
sudo cp alertmanager.service /etc/systemd/system/

cd ..
rm -rf alertmanager-"$alertmanagerver".linux-"$arch".tar.gz


sudo mkdir -p /data/alertmanager
sudo chown alertmanager:alertmanager /usr/local/bin/amtool /usr/local/bin/alertmanager
sudo chown alertmanager:alertmanager /etc/alertmanager
sudo chown -R alertmanager:alertmanager /data/alertmanager /etc/alertmanager/*
sudo chown -R alertmanager:alertmanager /var/lib/alertmanager


sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager
sudo systemctl status alertmanager
