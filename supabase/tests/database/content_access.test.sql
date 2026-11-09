-- Content access test: what a visitor (anon) can and cannot do with learning
-- content. Uses its own rows (ids start with "_t-"), all rolled back.
-- Run with: npm run db:test
begin;

create extension if not exists pgtap with schema extensions;

select plan(14);

-- Fixtures, created as the migration owner. One published chain, one draft chain.
insert into public.lessons (id, position, title, summary, source, status) values
  ('_t-pub',   9001, 'Published', 's', 'src', 'published'),
  ('_t-draft', 9002, 'Draft',     's', 'src', 'draft');
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('_t-pub-s',   '_t-pub',   1, 't', 'b', 'src', 'published'),
  ('_t-draft-s', '_t-draft', 1, 't', 'b', 'src', 'draft');
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('_t-pub-q',   '_t-pub-s',   1, 'p', 'src', 'published'),
  ('_t-draft-q', '_t-draft-s', 1, 'p', 'src', 'draft');
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('_t-pub-c1',   '_t-pub-q',   1, 'right', true,  'because right'),
  ('_t-pub-c2',   '_t-pub-q',   2, 'wrong', false, 'because wrong'),
  ('_t-draft-c1', '_t-draft-q', 1, 'right', true,  'draft secret');

-- Data rule (as the owner): a second correct choice for a question is refused.
select throws_ok(
  $$insert into public.choices (id, question_id, position, body, is_correct, explanation)
    values ('_t-pub-c3', '_t-pub-q', 3, 'also right', true, 'x')$$,
  '23505',
  null,
  'a question cannot have two correct choices'
);

-- From here on we are a visitor.
set local role anon;

select is(
  (select count(*)::int from public.lessons where id like '\_t-%'),
  1,
  'visitor sees the published lesson and not the draft'
);

select is(
  (select count(*)::int from public.sections where id like '\_t-%'),
  1,
  'visitor sees only the published section'
);

select is(
  (select count(*)::int from public.questions where id like '\_t-%'),
  1,
  'visitor sees only the published question'
);

select is(
  (select count(*)::int from public.choices where id like '\_t-%'),
  2,
  'visitor sees the choices of the published question only'
);

select throws_ok(
  $$select is_correct from public.choices$$,
  '42501',
  null,
  'visitor cannot read is_correct'
);

select throws_ok(
  $$select explanation from public.choices$$,
  '42501',
  null,
  'visitor cannot read explanation'
);

select throws_ok(
  $$select status from public.lessons$$,
  '42501',
  null,
  'visitor cannot read status'
);

select throws_ok(
  $$insert into public.lessons (id, position, title, summary, source)
    values ('_t-hack', 9999, 't', 's', 'x')$$,
  '42501',
  null,
  'visitor cannot write lessons'
);

-- The grader.
select is(
  (select is_correct from public.check_choice('_t-pub-c1')),
  true,
  'grader says the correct choice is correct'
);

select is(
  (select explanation from public.check_choice('_t-pub-c2')),
  'because wrong',
  'grader returns the explanation for a wrong choice'
);

select is(
  (select count(*)::int from public.check_choice('_t-draft-c1')),
  0,
  'grader returns nothing for a choice of a draft question'
);

select is(
  (select count(*)::int from public.check_choice('does-not-exist')),
  0,
  'grader returns nothing for an unknown choice'
);

select is(
  (select count(*)::int from public.check_choice(null)),
  0,
  'grader returns nothing for a null choice id'
);

select * from finish();

rollback;
