-- Publish step. Run ONLY after a human has verified the seeded content against
-- the official WA Driver Guide (the human approval gate; there is no AI review
-- yet). Visitors can see nothing until this has run.
--
-- It refuses to publish if any question does not have exactly one correct
-- choice (the "at least one" half of that rule cannot be a table constraint).
--
-- Local:  docker exec -i supabase_db_SuperDriver psql -U postgres -f - < supabase/publish.sql
-- Hosted: paste into the Supabase SQL editor.
-- To take content down again: set status back to 'draft' for the same tables.

do $$
declare
  bad text;
begin
  select string_agg(q.id, ', ') into bad
    from public.questions q
   where (select count(*) from public.choices c
           where c.question_id = q.id and c.is_correct) <> 1;
  if bad is not null then
    raise exception 'Refusing to publish: questions without exactly one correct choice: %', bad;
  end if;

  select string_agg(q.id, ', ') into bad
    from public.questions q
   where (select count(*) from public.choices c where c.question_id = q.id) < 2;
  if bad is not null then
    raise exception 'Refusing to publish: questions with fewer than 2 choices: %', bad;
  end if;
end $$;

update public.lessons   set status = 'published' where state = 'WA';
update public.sections  set status = 'published';
update public.questions set status = 'published';
