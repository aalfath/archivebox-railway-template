# ArchiveBox on Railway

This repo is the source of the [ArchiveBox](https://archivebox.io) template on Railway. It builds the official `archivebox/archivebox` image, pinned by version and digest, with a small start script for Railway.

- **ArchiveBox version:** 0.9.77 (`archivebox/archivebox:0.9.77@sha256:f63170551ec48d7aa087c71e2d093156dbf4b4ed8680e2f97f22483e3bc71e55`)
- **Services:** one, `ArchiveBox`, built from this repo's `Dockerfile`, with a volume at `/data` and a public HTTPS domain.
- **Health check:** `/health/` (answers `OK` without a login).

## What the template sets up

| Variable | Default | What it does |
|---|---|---|
| `ADMIN_USERNAME` | `admin` | Admin account created on the first boot. |
| `ADMIN_PASSWORD` | generated secret | Password for that account. Read it in the service's Variables tab. |
| `PORT` | `5797` | Port the web server listens on; Railway's domain points at it. |

Baked into the image (override any of them with a service variable):

- `BASE_URL` = `https://$RAILWAY_PUBLIC_DOMAIN`, set by `start.sh` when you haven't set it yourself.
- `SERVER_SECURITY_MODE=safe-onedomain-nojsreplay`: one Railway domain can't serve a subdomain per snapshot, so archived pages are shown without replaying their JavaScript, which keeps the admin UI safe.
- `PUBLIC_INDEX=True`, `PUBLIC_SNAPSHOTS=True`, `PUBLIC_ADD_VIEW=False`: anyone can browse the archive, only logged-in users can add URLs. Set the first two to `False` for a private archive.

`start.sh` refuses to start a new collection without `ADMIN_USERNAME` and `ADMIN_PASSWORD`, so the instance can't be claimed by the first visitor.

## How updates reach deployers

Railway offers an "update available" notice to everyone who deployed the template when this repo's `main` branch changes. Each change is listed in [CHANGELOG.md](CHANGELOG.md), with breaking changes first. Back up the `/data` volume before applying an update: ArchiveBox migrates the collection on start.

## Running it yourself

```sh
docker build -t archivebox-railway .
docker run -p 5797:5797 -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=change-me -v archivebox-data:/data archivebox-railway
```

ArchiveBox's own documentation: [Docker](https://github.com/ArchiveBox/ArchiveBox/wiki/Docker), [configuration](https://github.com/ArchiveBox/ArchiveBox/wiki/Configuration), [security](https://github.com/ArchiveBox/ArchiveBox/wiki/Security-Overview).
