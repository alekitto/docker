ARG DOCKER_VERSION=stable
FROM docker:${DOCKER_VERSION} AS target
FROM alpine AS fetcher

RUN apk add curl

ARG BUILDX_VERSION=0.6.0
RUN curl -L \
  --output /docker-buildx \
  "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"

RUN chmod a+x /docker-buildx

FROM target

RUN apk add bash
COPY --from=fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx
