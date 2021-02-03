ARG BUILD_FROM
###############################################################################
# Build yarr
###############################################################################
FROM "golang:alpine" as build

RUN apk add build-base git; \
  \
  cd /opt; \
  \
  git clone https://github.com/nkanaev/yarr.git; \
  git clone https://github.com/nkanaev/gofeed.git; \
  \
  mv gofeed yarr; \
  \
  cd yarr; \
  \
  make build_linux

###############################################################################
# Build the actual add-on.
###############################################################################
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install basics
RUN set -eux; \
  apk add --no-cache ca-certificates; \
  update-ca-certificates

# Copy yarr build
COPY --from=build /opt/yarr/_output/linux/yarr /usr/local/bin/yarr

# Install yarr
# RUN set -eux; \
#   curl -J -L -o /tmp/yarr.zip "https://github.com/nkanaev/yarr/releases/download/v1.1/yarr-v1.1-linux32.zip"; \
#   unzip /tmp/yarr.zip -d /usr/local/bin ; \
#   rm -rf /tmp/yarr.zip

# Copy root filesystem
COPY rootfs /

# EXPOSE 7070

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
