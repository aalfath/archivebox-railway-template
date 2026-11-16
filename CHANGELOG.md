# Changelog

## 2026-11-16: ArchiveBox 0.9.77

First version built from this repo. Earlier deploys of the template ran the `archivebox/archivebox:0.7.4` image directly and don't follow this repo.

- **Breaking for 0.7.x collections:** 0.9 migrates the `/data` collection on first start and moves the web server to port 5797. Back up `/data` before moving an existing 0.7.4 deploy to this image.
- ArchiveBox 0.9.77, pinned by digest `sha256:f63170551ec48d7aa087c71e2d093156dbf4b4ed8680e2f97f22483e3bc71e55`.
- Health check `/health/`; `BASE_URL` derived from the Railway domain; single-domain security mode `safe-onedomain-nojsreplay`.
- The start script refuses to create a new collection without an admin username and password.
