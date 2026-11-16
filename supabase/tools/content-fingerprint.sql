-- Content fingerprint: one md5 over every row of lessons, sections, questions and
-- choices, ignoring only the publish status. Two databases with the same content
-- print the same fingerprint, so a refactor of the seed files can be proven to
-- change no data. Any changed character, position, answer flag or missing row
-- changes the fingerprint; publishing a lesson does not.
--
-- Run it from the repo root:
--   docker exec -i supabase_db_SuperDriver psql -U postgres -t -A -F '  rows=' < supabase/tools/content-fingerprint.sql
-- It prints: <md5>  rows=<number of rows>

select md5(string_agg(t, '|' order by t)) as fingerprint, count(*) as rows
from (
  select 'lesson:'   || (to_jsonb(l) - 'status')::text as t from public.lessons l
  union all
  select 'section:'  || (to_jsonb(s) - 'status')::text from public.sections s
  union all
  select 'question:' || (to_jsonb(q) - 'status')::text from public.questions q
  union all
  select 'choice:'   || to_jsonb(c)::text from public.choices c
) x;