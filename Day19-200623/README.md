Commands used:
# Resolve the error `Cannot connect to the Docker daemon at unix:///home/saumit/.docker/desktop/docker.sock. Is the docker daemon running?` by
```bash
v ~/.docker ~/.docker2
```
OR
``` bash
rm -rf ~/.docker
```

# Building Docker images for ARM64 on AMD64/x86_64 host
## 1. Installing QEMU and binfmt module
```bash
sudo apt-get update && sudo apt-get install -y --no-install-recommends qemu-user-static binfmt-support
```
## 2. Register qemu-arm with binfmt module.
update-binfmts --enable qemu-arm
update-binfmts --display qemu-arm

### If compiled from source, make sure that the qemu-arm-static binary is under /usr/bin/ directory of your system. Check using the following command
``` bash
which qemu-arm-static
```
should display
``` 
/usr/bin/qemu-arm-static
```
If not copy manually to the /usr/bin directory

## 3. Copy qemu-arm-static to Your Working Directory
``` bash
cp /usr/bin/qemu-arm-static .
```

## 4. Modify the Dockerfile
### Add this line of code, which makes a copy of qemu-arm-static binary to your docker image, below the "FROM" instruction in you Dockerfile.
``` bash
COPY qemu-arm-static /usr/bin/qemu-arm-static 
```

## 5. Build Docker Image with the Modified Dockerfile
```bash
docker build -t <your-image-name> .
```


# Run ARM Containers on x86 Hosts
## Run ARM Images with by mounting the volume with qemu-arm-static binary.
```bash
docker run -it --name <container-name> -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static <arm-image>
```
