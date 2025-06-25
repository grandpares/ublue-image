#!/bin/bash

set -ouex pipefail

KERNEL="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

mkdir -p /usr/lib/modules/${KERNEL}/extra/it87-extras
cp /tmp/it87-extras.ko.xz /usr/lib/modules/${KERNEL}/extra/it87-extras/it87-extras.ko.xz
depmod -a ${KERNEL}

install -Dm644 /tmp/certs/public_key.der   /etc/pki/akmods/certs/public_key.der
