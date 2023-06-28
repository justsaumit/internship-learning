# Commands used

## Get container IP (helped with os-ticket issue)
``` bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-name>
```

## Make changes in docker image
### Enter docker container via interactive mode
``` bash
docker exec -it osticket sh
```
``` sh
cd /var/www/html/include/
```
``` sh
find . -name "*footer*"
```
``` sh
grep -nr "Log In" .
```
### Capture the current state of docker container using Docker commit
``` bash
docker commit 123.xyz.ecr.ap-south-1.amazonaws.com/osticket-new:latest
```
### Tag - rename to match the repository name but different tag
``` bash
docker tag 123.xyz.ecr.ap-south-1.amazonaws.com/osticket-new:latest 123.xyz.ecr.ap-south-1.amazonaws.com/osticket:clean
```
### Push - push the newer docker image to ECR repo
```bash
docker push  123.xyz.ecr.ap-south-1.amazonaws.com/osticket:clean
```
