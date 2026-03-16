-- ===========================================================
--  init-scripts/01_create_student.sql
--  Runs automatically on first DB startup.
--  Creates a dedicated student user in FREEPDB1.
-- ===========================================================

-- Connect to the pluggable database (students should use this, not CDB$ROOT)
ALTER SESSION SET CONTAINER = FREEPDB1;

-- Create a practice user
CREATE USER student IDENTIFIED BY Student123!
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

-- Grants needed for typical learning exercises
GRANT CONNECT, RESOURCE TO student;
GRANT CREATE VIEW, CREATE SEQUENCE, CREATE SYNONYM TO student;
GRANT CREATE PROCEDURE, CREATE TRIGGER TO student;

-- Allow SQL Developer Web login for this user
GRANT ORDS_ADMINISTRATOR_ROLE TO student;
BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled             => TRUE,
    p_schema              => 'STUDENT',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'student',
    p_auto_rest_auth      => FALSE
  );
  COMMIT;
END;
/

PROMPT >>> Student user created. Login: student / Student123!
