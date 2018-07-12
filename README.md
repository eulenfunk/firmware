# Gluon Buildtool

### A simple tool for templating the gluon site configuration and building firmwares for multiple sites

## Dependencies

Arch Linux:
`sudo pacman -S python python-jinja python-yaml base-devel unzip gawk wget --needed`

Debian-based distributions:
`apt install python3 python3-jinja2 python3-yaml python build-essential gawk unzip libncurses5-dev zlib1g-dev libssl-dev wget`

## How to use

 - Adjust the site template in `template/` and define your sites in `sites.yml`
 - Clone the gluon repository somewhere and check it out to the version you want to build
 - Now call `./make_sites.py` with your gluon directory as parameter
 - Run the generated `./build.sh` to start the build
