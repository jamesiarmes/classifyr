#!/bin/bash
set -e

# Script to workaround OSX host volume issues.

echo '* Working around permission errors locally by making sure that "postgres" uses the same uid and gid as the host volume'
TARGET_UID=$(stat -c "%u" /var/lib/postgresql/data)
echo '-- Setting postgres user to use uid '$TARGET_UID
usermod -o -u $TARGET_UID postgres || true
TARGET_GID=$(stat -c "%g" /var/lib/postgresql/data)
echo '-- Setting postgres group to use gid '$TARGET_GID
groupmod -o -g $TARGET_GID postgres || true
echo
echo '* Starting postgres'
chown -R postgres:postgres /var/run/postgresql/
docker-entrypoint.sh postgres
