#!/bin/sh

nodexver="1.6.0"

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

sudo useradd --no-create-home node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/v"$nodexver"/node_exporter-"$nodexver".linux-"$arch".tar.gz
tar xzf node_exporter-"$nodexver".linux-"$arch".tar.gz
sudo cp node_exporter-"$nodexver".linux-"$arch"/node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-"$nodexver".linux-"$arch".tar.gz node_exporter-"$nodexver".linux-"$arch"

wget https://raw.githubusercontent.com/justsaumit/internship-learning/main/Day15-140623/node-exporter.service
sudo cp node-exporter.service /etc/systemd/system/node-exporter.service

sudo systemctl daemon-reload
sudo systemctl enable node-exporter
sudo systemctl start node-exporter
sudo systemctl status node-exporter
