-- Secure-by-default privileges.
--
-- Supabase's defaults give the browser roles (anon, and authenticated, which
-- includes anonymous guests) every privilege on every new table, sequence and
-- function in public. With RLS off that means anyone holding the public key can
-- read, change or delete anything. This migration flips the defaults: new
-- objects are closed to the browser roles until a migration grants access on
-- purpose.
--
-- Default privileges apply to objects created AFTER this runs, by the role named
-- in FOR ROLE. Migrations run as postgres, so that is the role we change.
-- This must stay the first migration so every later object is covered.
--
-- service_role and postgres keep their access, so server-side code (Edge
-- Functions, the reviewer, the grading function owner) is unaffected.

-- Tables and sequences created in public.
alter default privileges for role postgres in schema public
  revoke all on tables from anon, authenticated;

alter default privileges for role postgres in schema public
  revoke all on sequences from anon, authenticated;

-- Functions. PostgreSQL's built-in default lets PUBLIC (everyone) execute any
-- new function, and anon/authenticated inherit that. The built-in default is
-- global, so a schema-scoped revoke cannot remove it: it must be revoked
-- without "in schema".
alter default privileges for role postgres
  revoke execute on functions from public;

alter default privileges for role postgres in schema public
  revoke execute on functions from anon, authenticated;
