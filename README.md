# TinyTots Digital — public site

Static marketing site + legal pages (privacy, terms, about) for the worksheet business.
Built to satisfy Meta / TikTok app review requirements: a public HTTPS host serving a real
privacy policy, terms and an app/website home.

## Stack

- Plain HTML + one CSS file. No JavaScript, no build step, no external fonts or CDNs.
- Served by `nginxinc/nginx-unprivileged` (uid 101, port 8080) via Docker.
- Deployed with Coolify on the Oracle VPS behind the Coolify Traefik proxy.

## Files

```
site/index.html      landing (Malay)
site/about.html      who we are
site/privacy.html    privacy policy (English + Malay summary) — Meta app review URL
site/terms.html      terms of sale
site/404.html        not found
site/robots.txt
nginx.conf           security headers, CSP, /healthz, clean URLs
Dockerfile           unprivileged nginx, healthcheck
```

## Local check

```bash
docker build -t tinytots-site:local .
docker run --rm -p 8081:8080 tinytots-site:local
curl -s -o /dev/null -w '%{http_code}\n' http://127.0.0.1:8081/
```

## Deploy

Coolify app `tinytots-site` (project "My first project"). Push to `main` or trigger:

```bash
curl -s -X POST -H "Authorization: Bearer $COOLIFY_API_TOKEN" "$COOLIFY_API_URL/api/v1/deploy?uuid=<app-uuid>"
```

## Content rules

- Prices on the landing page mirror `business/worksheets/worksheets.db` (active products).
- Never add tracking scripts, analytics or third-party embeds without updating `privacy.html`
  and the CSP in `nginx.conf` in the same commit.
- Legal pages need Min's review before they are quoted anywhere as final.
