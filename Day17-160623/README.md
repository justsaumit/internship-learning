# Commands Used

## Expose only the public directory via NGINX Reverse Proxy
```bash
vim /etc/nginx/sites-available/phpsite
```
```bash
ln -s /etc/nginx/sites-available/phpsite /etc/nginx/sites-enabled/
```
```bash
vim /etc/nginx/sites-available/phpsite
```
```bash
cat /etc/nginx/sites-available/phpsite
```
```bash
diff -r . ~/php/phpDEV
```
## Version updates along with dependencies
```bash
vimdiff composer.json ~/php/phpDEV/composer.json
```
```bash
composer update
```
