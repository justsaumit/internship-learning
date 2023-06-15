#!/bin/sh

#calert release version
calertver="2.0.6"

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

sudo mkdir /etc/calert

findarch

sudo useradd --no-create-home calert

wget https://github.com/mr-karan/calert/releases/download/v"$calertver"/calert_"$calertver"_linux_"$arch".tar.gz
mkdir calert_"$calertver"_linux_"$arch"
tar -xvf calert_"$calertver"_linux_"$arch".tar.gz -C calert_"$calertver"_linux_"$arch"

cd calert_"$calertver"_linux_"$arch"
sudo cp calert.bin /usr/local/bin/calert
sudo cp config.sample.toml /etc/calert/config.sample
#sudo cp -r calert_"$calertver"_linux_"$arch"/static/message.tmpl /usr/local/bin/calert

wget https://github.com/justsaumit/internship-learning/raw/main/Day16-150623/calert.service

sudo cp calert.service /etc/systemd/system/calert.service

cd ..
rm -rf calert_"$calertver"_linux_"$arch".tar.gz 

sudo chown -R calert:calert /etc/calert
sudo chown calert:calert /usr/local/bin/calert

sudo systemctl daemon-reload
sudo systemctl enable calert
sudo systemctl start calert
sudo systemctl status calert
