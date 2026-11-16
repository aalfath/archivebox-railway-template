# ArchiveBox for Railway: the official image, pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM archivebox/archivebox:0.9.77@sha256:f63170551ec48d7aa087c71e2d093156dbf4b4ed8680e2f97f22483e3bc71e55

# Railway-friendly defaults. Every one can be overridden with a service variable.
# - One *.up.railway.app domain can't serve per-snapshot subdomains, so use the
#   single-domain mode that is safe for the admin UI (no JS replay of archived pages).
# - Anonymous visitors may browse the public index and snapshots but can't add URLs.
ENV SERVER_SECURITY_MODE=safe-onedomain-nojsreplay \
    PUBLIC_INDEX=True \
    PUBLIC_SNAPSHOTS=True \
    PUBLIC_ADD_VIEW=False

COPY --chmod=755 start.sh /app/bin/railway_start.sh

# The upstream ENTRYPOINT (dumb-init + docker_entrypoint.sh) fixes /data ownership and
# drops to the archivebox user; it runs this script as that user.
CMD ["bash", "/app/bin/railway_start.sh"]
