\connect postgres;

DO
$$
    BEGIN
        IF NOT EXISTS (
                SELECT FROM pg_catalog.pg_roles
                WHERE  rolname = 'iam') THEN
            CREATE USER iam PASSWORD 'iam' VALID UNTIL 'INFINITY';
        END IF;

        EXECUTE format('GRANT iam to %I', current_user );
    END
$$;

SELECT 'CREATE DATABASE iam'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'iam')\gexec
GRANT ALL ON DATABASE iam TO iam;

\connect iam;

CREATE SCHEMA IF NOT EXISTS iam AUTHORIZATION iam;
GRANT ALL ON SCHEMA iam TO iam;

DO $$ BEGIN EXECUTE format('GRANT ALL ON SCHEMA iam TO %I', current_user ); END $$; -- Replace -> GRANT ALL ON SCHEMA iam TO postgres;

ALTER DEFAULT PRIVILEGES FOR ROLE iam IN SCHEMA iam GRANT ALL ON FUNCTIONS TO iam;

ALTER ROLE iam SET default_tablespace = pg_default;
ALTER ROLE iam SET search_path TO iam;
