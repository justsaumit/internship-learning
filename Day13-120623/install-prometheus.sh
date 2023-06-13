#!/bin/sh

promver="2.44.0"

findarch () {
    if [ "$(uname -p)" = "aarch64" ] ; then
        arch=arm64
    elif [ "$(uname -p)" = "x86_64" ] ; then
        arch=amd64
    else
        echo "Architecture not recognized"
        exit
    fi
}

sudo useradd --no-create-home prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

findarch

wget https://github.com/prometheus/prometheus/releases/download/v"$promver"/prometheus-"$promver".linux-"$arch".tar.gz
tar -xvf prometheus-"$promver".linux-"$arch".tar.gz
sudo cp prometheus-"$promver".linux-"$arch"/prometheus /usr/local/bin
sudo cp prometheus-"$promver".linux-"$arch"/promtool /usr/local/bin
sudo cp -r prometheus-"$promver".linux-"$arch"/consoles /etc/prometheus/
sudo cp -r prometheus-"$promver".linux-"$arch"/console_libraries /etc/prometheus
sudo cp prometheus-"$promver".linux-"$arch"/promtool /usr/local/bin/

wget https://raw.githubusercontent.com/devops4solutions/prometheus-monitoring/main/prometheus.yml
wget https://raw.githubusercontent.com/devops4solutions/prometheus-monitoring/main/prometheus.service
sudo cp prometheus.yml /etc/prometheus/
sudo cp prometheus.service /etc/systemd/system/prometheus.service

rm -rf prometheus-"$promver".linux-"$arch".tar.gz 

sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
