-- Create mycel_iam login user
-- Runs as: mycel_app_db_admin
-- Phase 1, Step 2

-- Module login user
DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'mycel_iam_db_user') THEN
    CREATE ROLE mycel_iam_db_user LOGIN PASSWORD 'iam_dev_password';
  END IF;
END $$;

-- Grant owner role (full access to own schema)
GRANT mycel_iam_role TO mycel_iam_db_user;
