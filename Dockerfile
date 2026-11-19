ARG CADDY_VERSION=alpine

FROM caddy:builder-alpine AS builder

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
