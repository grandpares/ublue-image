ARG AKMODS_SECRET

# Stage 1: Builder
FROM ghcr.io/ublue-os/aurora:stable as builder
COPY ${AKMODS_SECRET} /etc/pki/akmods/private/private_key.priv
COPY certs/akmods_grandpares.der /etc/pki/akmods/certs/public_key.der
COPY build.sh /tmp/build.sh
RUN /tmp/build.sh

# Stage 2: Final image
FROM ghcr.io/ublue-os/aurora:stable

COPY certs/akmods_grandpares.der /etc/pki/akmods/certs/public_key.der
COPY postbuild.sh /tmp/postbuild.sh

COPY --from=builder /it87-extras.ko.xz /tmp/it87-extras.ko.xz
RUN /tmp/postbuild.sh

RUN mkdir -p /var/lib/alternatives && \
    ostree container commit && \
    bootc container lint
