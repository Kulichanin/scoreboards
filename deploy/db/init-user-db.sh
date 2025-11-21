#!/usr/bin/env bash
set -e

gunzip -c demo-20250901-3m.sql.gz | psql -U postgres