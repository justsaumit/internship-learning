#!/bin/sh

bbexver="0.24.0"

findarch () {
    if [ "$(uname -p)" = "aarch64" ] ; then
        arch=arm64
        echo $arch
    elif [ "$(uname -p)" = "x86_64" ] ; then
        arch=amd64
    else
        echo "Architecture not recognized"
        exit
    fi
}

findarch

sudo useradd --no-create-home blackbox_exporter
mkdir /etc/blackbox_exporter

wget https://github.com/prometheus/blackbox_exporter/releases/download/v"$bbexver"/blackbox_exporter-"$bbexver".linux-"$arch".tar.gz
tar xzf blackbox_exporter-"$bbexver".linux-"$arch".tar.gz
sudo cp blackbox_exporter-"$bbexver".linux-"$arch"/blackbox_exporter /usr/local/bin/blackbox_exporter
rm -rf blackbox_exporter-"$bbexver".linux-"$arch".tar.gz blackbox_exporter-"$bbexver".linux-"$arch"

wget https://raw.githubusercontent.com/justsaumit/internship-learning/main/Day26-290623/blackbox.yml
sudo mv blackbox_exporter-"$bbexver".linux-"$arch"/blackbox.yml /etc/blackbox_exporter/blackbox.yml
wget https://raw.githubusercontent.com/justsaumit/internship-learning/main/Day26-290623/blackbox_exporter.service
sudo mv blackbox_exporter.service /etc/systemd/system/blackbox_exporter.service

sudo systemctl daemon-reload
sudo systemctl enable blackbox_exporter
sudo systemctl start blackbox_exporter
sudo systemctl status blackbox_exporter
