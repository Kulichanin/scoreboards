#!/usr/bin/env bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER"  <<-EOSQL
    CREATE DATABASE demo;
    CREATE USER scoreboards WITH PASSWORD '$SCOREBOARDS_PASSWORD';
EOSQL

gunzip -c /data/demo-20250901-3m.sql.gz | psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d demo <<-EOSQL
    -- Предоставление права на БД demo пользователю scoreboards
	GRANT ALL PRIVILEGES ON DATABASE demo TO scoreboards;
    -- Предоставление прав USAGE и CREATE на схему bookings
    GRANT USAGE, CREATE ON SCHEMA bookings TO scoreboards;
    -- Предоставление ВСЕХ привилегий на ВСЕ существующие таблицы в схеме bookings
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA bookings TO scoreboards;
    -- Предоставление ВСЕХ привилегий на ВСЕ существующие последовательности в схеме bookings
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA bookings TO scoreboards;
    -- Предоставление ВСЕХ привилегий на ВСЕ существующие функции/процедуры в схеме bookings
    GRANT ALL PRIVILEGES ON ALL ROUTINES IN SCHEMA bookings TO scoreboards;
    -- Применение прав по умолчанию для будущих таблиц, созданных текущим пользователем
    ALTER DEFAULT PRIVILEGES IN SCHEMA bookings GRANT ALL PRIVILEGES ON TABLES TO scoreboards;
    -- Применение прав по умолчанию для будущих последовательностей, созданных текущим пользователем
    ALTER DEFAULT PRIVILEGES IN SCHEMA bookings GRANT ALL PRIVILEGES ON SEQUENCES TO scoreboards;
    -- Применение прав по умолчанию для будущих функций/процедур, созданных текущим пользователем
    ALTER DEFAULT PRIVILEGES IN SCHEMA bookings GRANT ALL PRIVILEGES ON ROUTINES TO scoreboards;
EOSQL