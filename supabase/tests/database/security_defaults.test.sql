-- Guard test: the browser roles (anon, and authenticated, which includes guests)
-- must never get more access than we deliberately grant.
-- Run with: npm run db:test
--
-- Everything here runs in a transaction that is rolled back, so the probe
-- objects below never persist.
begin;

create extension if not exists pgtap with schema extensions;

select plan(8);

-- Probe objects, created exactly the way a future migration would create them.
create table public._guard_probe_table (id int);
create function public._guard_probe_fn() returns int language sql as 'select 1';
create sequence public._guard_probe_seq;

-- 1-4. Default privileges: brand-new objects are closed to the browser roles.
select is(
  (select count(*)::int
     from information_schema.role_table_grants
    where table_schema = 'public'
      and table_name = '_guard_probe_table'
      and grantee in ('anon', 'authenticated', 'PUBLIC')),
  0,
  'a new table grants nothing to the browser roles'
);

select ok(
  not has_function_privilege('anon', 'public._guard_probe_fn()', 'execute'),
  'a new function is not executable by anon'
);

select ok(
  not has_function_privilege('authenticated', 'public._guard_probe_fn()', 'execute'),
  'a new function is not executable by authenticated'
);

select ok(
  not has_sequence_privilege('anon', 'public._guard_probe_seq', 'usage')
    and not has_sequence_privilege('authenticated', 'public._guard_probe_seq', 'usage'),
  'a new sequence is not usable by the browser roles'
);

-- 5. Every table in public has row level security on.
select is(
  (select count(*)::int
     from pg_class c
    where c.relnamespace = 'public'::regnamespace
      and c.relkind in ('r', 'p')
      and not c.relrowsecurity
      and c.relname not like '\_guard\_%'),
  0,
  'every table in public has RLS enabled'
);

-- 6. The browser roles never hold privileges that no feature needs.
select is(
  (select count(*)::int
     from information_schema.role_table_grants
    where table_schema = 'public'
      and table_name not like '\_guard\_%'
      and grantee in ('anon', 'authenticated', 'PUBLIC')
      and privilege_type in ('TRUNCATE', 'REFERENCES', 'TRIGGER')),
  0,
  'browser roles hold no TRUNCATE, REFERENCES or TRIGGER privilege'
);

-- 7. Answer columns are never readable from the browser, whether through a
--    column grant or a table-wide SELECT (information_schema expands both).
select is(
  (select count(*)::int
     from information_schema.column_privileges
    where table_schema = 'public'
      and column_name in ('is_correct', 'explanation')
      and privilege_type = 'SELECT'
      and grantee in ('anon', 'authenticated', 'PUBLIC')),
  0,
  'is_correct and explanation are not readable by the browser roles'
);

-- 8. Functions in public are not executable by the browser roles unless they
--    are on this list. Add a function here only on purpose, e.g. the grader.
select is(
  (select count(*)::int
     from information_schema.routine_privileges
    where routine_schema = 'public'
      and routine_name not like '\_guard\_%'
      and routine_name <> all (array[]::text[])
      and grantee in ('anon', 'authenticated', 'PUBLIC')),
  0,
  'no function in public is executable by the browser roles unless allow-listed'
);

select * from finish();

rollback;
