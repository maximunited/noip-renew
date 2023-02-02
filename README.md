[![Docker Image CI](https://github.com/maximunited/noip-renew/actions/workflows/docker-image.yml/badge.svg)](https://github.com/maximunited/noip-renew/actions/workflows/docker-image.yml)

# Script to auto renew/confirm noip.com free hosts

[noip.com](https://www.noip.com/) free hosts expire every month.
This script auto clicks web pages to renew the hosts,
using Python/Selenium with Chrome headless mode.

NOTE: this is an up-to-date fork of loblab/noip-renew repository as it seems it's not anymore actively developed, I'll try to keep this fork up to date and working as much as possible. Feel free to contribute!

- Platform: Debian/Ubuntu/Raspbian/Arch Linux, no GUI needed (tested on Debian 9.x/10.x/Arch Linux); python 3.6+
- Ref: [Technical explanation for the code (Chinese)](http://www.jianshu.com/p/3c8196175147)
- Created: 11/04/2017
- Updated: 02/02/2023
- Original Author: [loblab](https://github.com/loblab)
- Fork Mantainer: [maximunited](https://github.com/maximunited)
- Contributors: [neothematrix](https://github.com/neothematrix), [IDemixI](https://github.com/IDemixI), [Angel0ffDeath](https://github.com/Angel0ffDeath), [benyjr](https://github.com/benyjr)

![noip.com hosts](https://raw.githubusercontent.com/maximunited/noip-renew/master/screenshot.png)

## Usage

1. Clone this repository to the device you will be running it from (`git clone https://github.com/maximunited/noip-renew.git`)
2. Run setup.sh and set your noip.com account information
3. Run noip-renew-USERNAME command

Check confirmed records from multiple log files:

``` bash
grep -h Confirmed *.log | grep -v ": 0" | sort
```
## Usage with Docker

For docker users, run the following:
```sh
echo 'add username here' > ${SECRETSDIR}/noip_username
echo 'add password here' | base64 > ${SECRETSDIR}/noip_password
debug_lvl=2
docker build -t maximunited/selenium:debian .
echo -e "$(crontab -l)"$'\n'"12  3  *  *  1,3,5  docker run --network host maximunited/selenium:debian "${SECRETSDIR}/noip_username" "${SECRETSDIR}/noip_password" ${debug_lvl}" | crontab -
```
NOTE: with newer versions of ChromeDriver (>v99) you might need to increase the shm size of the container otherwise ChromeDriver will crash and throw an exception. To do it, you can just add the "--shm-size="512m" flag to the docker run command.

## Usage with Docker Compose

Refer to the sample [docker-compose-sample.yml](https://github.com/maximunited/noip-renew/blob/master/docker-compose-sample.yml)

## Remarks

The script is not designed to renew/update the dynamic DNS records, but only to renew the hostnames expiring every 30 days due to the free tier.
Check [noip.com documentation](https://www.noip.com/integrate) for that purpose.
Most wireless routers support noip.com. For more information, check [here](https://www.noip.com/support/knowledgebase/what-devices-support-no-ips-dynamic-dns-update-service/).
You can also check [DNS-O-Matic](https://dnsomatic.com/) to update multiple noip.com DNS records.
