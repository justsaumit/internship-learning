#!/bin/sh

grafanaver="9.5.3"

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

sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_"$grafanaver"_"$arch".deb
sudo dpkg -i grafana_"$grafanaver"_"$arch".deb
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl enable grafana-server.service
