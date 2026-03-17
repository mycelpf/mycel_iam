-- Create mycel_iam roles
-- Runs as: mycel_app_db_admin
-- Phase 1, Step 1

-- ============================================================
-- Owner role (non-login) — full access, owns this schema
-- ============================================================
DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'mycel_iam_role') THEN
    CREATE ROLE mycel_iam_role NOLOGIN;
  END IF;
END $$;

ALTER SCHEMA mycel_iam OWNER TO mycel_iam_role;
GRANT ALL PRIVILEGES ON SCHEMA mycel_iam TO mycel_iam_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA mycel_iam TO mycel_iam_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA mycel_iam TO mycel_iam_role;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA mycel_iam TO mycel_iam_role;

-- Future objects inherit full privileges for owner
ALTER DEFAULT PRIVILEGES IN SCHEMA mycel_iam
  GRANT ALL PRIVILEGES ON TABLES TO mycel_iam_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA mycel_iam
  GRANT ALL PRIVILEGES ON SEQUENCES TO mycel_iam_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA mycel_iam
  GRANT ALL PRIVILEGES ON FUNCTIONS TO mycel_iam_role;

-- ============================================================
-- Reader role (non-login) — SELECT only, for downstream modules
-- ============================================================
DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'mycel_iam_reader_role') THEN
    CREATE ROLE mycel_iam_reader_role NOLOGIN;
  END IF;
END $$;

GRANT USAGE ON SCHEMA mycel_iam TO mycel_iam_reader_role;
GRANT SELECT ON ALL TABLES IN SCHEMA mycel_iam TO mycel_iam_reader_role;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA mycel_iam TO mycel_iam_reader_role;

-- Future tables/sequences are also readable
ALTER DEFAULT PRIVILEGES IN SCHEMA mycel_iam
  GRANT SELECT ON TABLES TO mycel_iam_reader_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA mycel_iam
  GRANT SELECT ON SEQUENCES TO mycel_iam_reader_role;
