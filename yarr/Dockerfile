ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM
ARG BUILD_ARCH

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set yarr version
ARG YARR_VERSION="v2.5"

# Setup base
# hadolint ignore=DL3003
RUN \
    set -eux \
    \
    && apk add --no-cache \
    nginx=1.24.0-r7 \
    \
    && if [[ "$BUILD_ARCH" = "aarch64" ]]; then ARCH="arm64"; fi \
    && if [[ "$BUILD_ARCH" = "amd64" ]]; then ARCH="amd64"; fi \
    && if [[ "$BUILD_ARCH" = "armhf" ]]; then ARCH="armv7"; fi \
    && if [[ "$BUILD_ARCH" = "armv7" ]]; then ARCH="armv7"; fi \
    \
    && curl -L -o /tmp/yarr.zip "https://github.com/nkanaev/yarr/releases/download/${YARR_VERSION}/yarr_linux_${ARCH}.zip" \
    && unzip /tmp/yarr.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/yarr \
    \
    && rm -f -r /tmp/* \
    /etc/nginx

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Einschmidt" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Einschmidt" \
    org.opencontainers.image.authors="einschmidt" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://google.com" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
