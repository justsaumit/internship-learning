#Commands Used
##Docker Desktop install

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```
```bash
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
```bash
echo   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
```
```bash
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```bash
sudo apt-get update
```
```bash
sudo apt-get install ./docker-desktop-4.20.1-amd64.deb 
```

## Docker commands

### Docker build
```bash
docker build -t <image-name> .
```

### Docker build for arm64
``` bash
docker build --platform linux/arm64 -t <image-name> . --no-cache
```
### Docker tag/rename
```bash
docker tag <image_name>:<original_tag> <docker-reponame>/<image_name>:<version no.> or $(date +%Y%m%d)
```
By default tag is set to `latest`
