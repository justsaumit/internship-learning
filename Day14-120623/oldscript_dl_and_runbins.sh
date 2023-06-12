downloadlatest () {
        if [ "$(uname -p)" == "aarch64" ]
        then
            ar=arm64
            curl -s https://api.github.com/repos/$user/$repo/releases/latest \
            | grep "browser_download_url.*linux-arm64*" \
            | cut -d : -f 2,3 \
            | tr -d \" \
            | wget -i -
        elif [ "$(uname -p)" == "x86_64" ]
        then
            ar=amd64
            curl -s https://api.github.com/repos/$user/$repo/releases/latest \
            | grep "browser_download_url.*linux-amd64*" \
            | cut -d : -f 2,3 \
            | tr -d \" \
            | wget -i -
        elif [ "$(uname -p)" != "aarch64" ]
        then echo "Architecture not recognized"
        fi
}

user=prometheus
repo=prometheus
downloadlatest "$user" "$repo"

repo=node_exporter
downloadlatest "$user" "$repo"

#wget https://github.com/google/cadvisor/releases/download/v0.46.0/cadvisor-v0.46.0-linux-arm64
find . -type f -name "*.tar.gz" -exec sh -c 'mkdir -p "${1%.*}" && tar -xvf "$1" -C "${1%.*}"' sh {} \;

chmod +x cadvisor-v0.46.0-linux-arm64
mkdir bins & find . -type f -executable -exec sh -c 'cp "{}" bins/' \;

sudo apt-get install -y gnupg2 curl
curl https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update
sudo apt-get -y install grafana
sudo systemctl start grafana-server
systemctl status grafana-server
