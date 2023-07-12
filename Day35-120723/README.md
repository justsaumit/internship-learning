# Commands Used
## Install Node.js Version 18 on Ubuntu 22.04
To work with React web applications and perform testing locally, the default version of Node.js available in the Ubuntu 22.04 apt repositories might be outdated. So in order to install Node.js version 18, follow these steps:
1. Use curl to run a bashscript which adds the NodeSource repository and set up Node.js version 18:
``` bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
```
2. Once the repo is added, install Node.js version 18 by running the following command:
``` bash
sudo apt install -y nodejs
```
**Before:** 
``` bash 
$ node -v
v12.22.9
```
``` bash 
$ npm -v
Command 'npm' not found, but can be installed with:
sudo apt install npm
```
Note that npm is not bundled with Node.js and needs to be installed separately. It is not recommended to install npm independently since in order to run properly it will pul alot of dependencies. Better way is to install an updated version of nodejs.

**After:**
``` bash 
$ node -v
v18.16.1
```
``` bash 
$ npm -v
9.5.1
```
