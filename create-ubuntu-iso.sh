#!/bin/bash

ISO_VERSION="22.10"
ISO_URL="https://releases.ubuntu.com/${ISO_VERSION}/ubuntu-${ISO_VERSION}-live-server-amd64.iso"
CONTAINER_NAME="ubuntu-iso-builder"

echo -e "\nDownloading Ubuntu Server ISO"
if [ -f ubuntu-${ISO_VERSION}-live-server-amd64.iso ]; then
  echo "Ubuntu ISO already exists. Continuing..."
else
  wget $ISO_URL
fi

echo -e "\nConfiguring Ubuntu Server ISO"
docker run --name $CONTAINER_NAME -v $(pwd):/build -d ubuntu:kinetic /bin/bash /build/configure-ubuntu-iso.sh

docker logs -f $CONTAINER_NAME

docker rm -f $CONTAINER_NAME

echo -e "Creation of Custom Ubuntu ISO has now completed. Have a nice day."

exit
