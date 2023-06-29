# Commands used

## Docker cleanup

### Kill all running containers.
``` bash
docker kill $(docker ps -q)
```
### Delete all stopped containers.
``` bash
printf "\n&gt;&gt;&gt; Deleting stopped containers\n\n" &amp;&amp; docker rm $(docker ps -a -q)
```
### Delete all untagged images.
``` bash
printf "\n&gt;&gt;&gt; Deleting untagged images\n\n" &amp;&amp; docker rmi $(docker images -q -f dangling=true)
```
### Delete all images.
``` bash
printf "\n&gt;&gt;&gt; Deleting untagged images\n\n" &amp;&amp; docker rmi $(docker images -q)
```
### Delete all volumes.
``` bash
printf "\n&gt;&gt;&gt; Deleting volumes\n\n" &amp;&amp; docker volume rm $(docker volume ls -q)
```
### Remove all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes.
``` bash
printf "\n&gt;&gt;&gt; Deleting unused containers, networks, images and volumes\n\n" &amp;&amp; docker system prune -a --volumes
```

##Completely uninstall docker engine from debian/ubuntu based system

### Find installed packages relating to docker
``` bash
dpkg -l | grep -i docker
```
### Purge and Auto Remove Docker packages
``` bash
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin
```
### delete remaining files and groups
```bash
sudo rm -rf /var/lib/docker /etc/docker
sudo rm -rf /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
```
