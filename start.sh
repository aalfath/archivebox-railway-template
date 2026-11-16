#!/bin/bash
# Start ArchiveBox on Railway's PORT (5797 when unset). `--init` creates or migrates the
# collection in /data, and creates the admin from ADMIN_USERNAME / ADMIN_PASSWORD on
# the first boot.
set -euo pipefail

# Railway provides RAILWAY_PUBLIC_DOMAIN; ArchiveBox needs its public URL for links and CSRF.
if [[ -z "${BASE_URL:-}" && -n "${RAILWAY_PUBLIC_DOMAIN:-}" ]]; then
    export BASE_URL="https://${RAILWAY_PUBLIC_DOMAIN}"
fi

# Never come up without an admin on a public URL: the first-run wizard would let any
# visitor claim the instance. The template generates ADMIN_PASSWORD; this guards edits.
if [[ ! -f /data/index.sqlite3 && ( -z "${ADMIN_USERNAME:-}" || -z "${ADMIN_PASSWORD:-}" ) ]]; then
    echo "[X] Set ADMIN_USERNAME and ADMIN_PASSWORD before the first boot." >&2
    exit 1
fi

exec archivebox server --init "0.0.0.0:${PORT:-5797}"
