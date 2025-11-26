#!/bin/bash

set -ouex pipefail

ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
KVERSION="$(rpm -q 'kernel' --queryformat '%{VERSION}')"
KRELEASE="$(rpm -q 'kernel' --queryformat '%{RELEASE}')"

curl -L -O "https://kojipkgs.fedoraproject.org//packages/kernel/${KVERSION}/${KRELEASE}/${ARCH}/kernel-devel-${KERNEL}.rpm"
ls -lh kernel-devel-${KERNEL}.rpm
dnf -y install kernel-devel-${KERNEL}.rpm
dnf -y group install development-tools

git clone https://github.com/grandpares/it87.git
cd it87

make TARGET=$KERNEL clean
make TARGET=$KERNEL modules

if [ -f "/etc/pki/akmods/private/private_key.priv" ]; then
 /usr/src/kernels/$KERNEL/scripts/sign-file \
  sha256 \
  /etc/pki/akmods/private/private_key.priv \
  /etc/pki/akmods/certs/public_key.der \
  it87-extras.ko
fi

xz -C crc32 it87-extras.ko

modinfo "it87-extras.ko.xz" > /dev/null \
|| exit 1

cp it87-extras.ko.xz /it87-extras.ko.xz
