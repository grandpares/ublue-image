# Stage 0: Final image base — to get kernel version
FROM ghcr.io/ublue-os/aurora:stable AS runtime-base

# Extract kernel version
RUN echo "KERNEL_VERSION=$(uname -r)" > /kernelver.env


# Stage 1: Builder
FROM quay.io/fedora/fedora:latest as builder

COPY --from=runtime-base /kernelver.env /kernelver.env

RUN source /kernelver.env && \
    dnf -y install dnf-plugins-core && \
    dnf copr enable grandpares/it87-extras && \
    dnf -y install akmods kmodtool kernel-devel-${KERNEL_VERSION} gcc make && \
    dnf -y install akmod-it87-extras && \
    akmods --force --kernels ${KERNEL_VERSION} && \
    rpm2cpio /var/cache/akmods/kmod-it87-extras*.rpm | cpio -idmv

# Stage 2: Final image
FROM ghcr.io/ublue-os/aurora:stable

RUN KERNEL_VERSION=$(uname -r)

# Copy the compiled module
COPY --from=builder /lib/modules/*/extra/it87-extras.ko /usr/lib/modules/${KERNEL_VERSION}/extra/it87-extras.ko

# Recompress and register
RUN xz -9 /usr/lib/modules/${KERNEL_VERSION}/extra/it87-extras.ko && \
    depmod -a ${KERNEL_VERSION}

RUN mkdir -p /var/lib/alternatives && \
    ostree container commit && \
    bootc container lint
    
