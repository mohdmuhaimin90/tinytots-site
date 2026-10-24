# syntax=docker/dockerfile:1
# Unprivileged nginx (listens on 8080, runs as uid 101) — no root at runtime.
FROM nginxinc/nginx-unprivileged:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY site/ /usr/share/nginx/html/
USER root
RUN chown -R 101:101 /usr/share/nginx/html
USER 101
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/healthz >/dev/null || exit 1
