# Commands used today


## Sending local redash docker images to bhaiya
### Storing docker image names in names.txt
```bash
docker ps --format "{{.Names}}" > names.txt
```

### Tagging multiple docker images with user id on dockerhub by using for loop in bash
```bash
for i in {1..7} ; do docker tag $(cat names.txt | sed -n "$i"p) <uid>/$(cat names.txt | sed -n "$i"p); done
```

### Pushing multiple docker images on docker hub (It'd be tedious to wait for 1 upload then comeback and type the next id so just use simple for loop for Automation)
```bash
for i in {1..7} ; do docker push <uid>/$(cat names.txt | sed -n "$i"p) ; done
```

## Update Release without updating mysql

### Connecting to VPN for AWS EC2 access using openvpn with the provided openvpn config file
```bash
openvpn saumit.ovpn
```

### rename the provided ssh key to default value
```bash
mv Downloads/smtp-ssh .ssh/id_rsa
```

### SSH Into Testing EC2 Instance running Ubuntu 16.04
```bash
ssh ubuntu@ec2-<IP>.ap-south-1.compute.amazonaws.com
```


## Setting up Netdata for docker monitoring
### Restart all images
```bash
docker restart $(docker ps -q)
```

## Setting up grafana for docker monitoring

```bash
mkdir grafana
```
```bash
cd grafana
```
```bash
vim docker-compose.yml
```
```bash
docker-compose -f docker-compose.yml up -d
```
```bash
vim prometheus.yml 
```

```bash
docker-compose up -f docker-compose.yml --build --force-recreate
```
