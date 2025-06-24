# Stage 1: Builder
FROM ghcr.io/ublue-os/aurora:stable as builder
COPY build.sh /tmp/build.sh
RUN /tmp/build.sh

# Stage 2: Final image
FROM ghcr.io/ublue-os/aurora:stable

COPY postbuild.sh /tmp/postbuild.sh

COPY --from=builder /it87-extras.ko.xz /tmp/it87-extras.ko.xz
RUN /tmp/postbuild.sh

RUN mkdir -p /var/lib/alternatives && \
    ostree container commit && \
    bootc container lint
