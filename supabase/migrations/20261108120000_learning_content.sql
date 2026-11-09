-- Learning content: lessons > sections > questions > choices.
--
-- Decisions (see CLAUDE.md decisions log):
--   * Questions belong to a section (option A, section-owned).
--   * Answers live in `choices`; the browser roles can only read safe columns.
--   * Rows are readable only when published (RLS); columns are limited by GRANTs.
--     Both are needed: RLS filters rows, column privileges filter columns.
--   * Grading runs in a SECURITY DEFINER function so is_correct never reaches the
--     browser as data.
--
-- The first migration changed default privileges, so every table below starts
-- closed to anon/authenticated and gets only the explicit grants at the end.

-- ---------------------------------------------------------------- tables

create table public.lessons (
  id        text primary key,
  state     text not null default 'WA' check (state = 'WA'),
  position  int  not null,
  title     text not null,
  summary   text not null,
  source    text not null,
  status    text not null default 'draft'
              check (status in ('draft', 'ai_reviewed', 'published')),
  unique (state, position)
);

create table public.sections (
  id        text primary key,
  lesson_id text not null references public.lessons (id) on delete cascade,
  position  int  not null,
  title     text not null,
  -- Plain text. Blank line = new paragraph; lines starting with "- " = bullets.
  body      text not null,
  source    text not null,
  status    text not null default 'draft'
              check (status in ('draft', 'ai_reviewed', 'published')),
  unique (lesson_id, position)
);

create table public.questions (
  id         text primary key,
  section_id text not null references public.sections (id) on delete cascade,
  position   int  not null,
  prompt     text not null,
  source     text not null,
  status     text not null default 'draft'
               check (status in ('draft', 'ai_reviewed', 'published')),
  unique (section_id, position)
);

create table public.choices (
  id          text primary key,
  question_id text not null references public.questions (id) on delete cascade,
  position    int  not null,
  body        text not null,
  is_correct  boolean not null,
  explanation text not null,
  unique (question_id, position)
);

-- At most one correct choice per question. "At least one" cannot be a simple
-- constraint (it spans rows); supabase/publish.sql checks it before publishing.
create unique index choices_one_correct_per_question
  on public.choices (question_id) where is_correct;

create index sections_lesson_id_idx  on public.sections  (lesson_id);
create index questions_section_id_idx on public.questions (section_id);
create index choices_question_id_idx on public.choices   (question_id);

-- ------------------------------------------------------------------- RLS

alter table public.lessons   enable row level security;
alter table public.sections  enable row level security;
alter table public.questions enable row level security;
alter table public.choices   enable row level security;

create policy "published lessons are readable" on public.lessons
  for select to anon, authenticated using (status = 'published');

create policy "published sections are readable" on public.sections
  for select to anon, authenticated using (status = 'published');

create policy "published questions are readable" on public.questions
  for select to anon, authenticated using (status = 'published');

-- Choices have no status of their own: they follow their question.
create policy "choices of published questions are readable" on public.choices
  for select to anon, authenticated
  using (exists (
    select 1 from public.questions q
    where q.id = choices.question_id and q.status = 'published'
  ));

-- --------------------------------------------------------- column grants
-- Never grant table-wide SELECT on choices: that would expose is_correct and
-- explanation. `status` is not granted on lessons, sections or choices (see the
-- one exception on questions below).

grant select (id, state, position, title, summary, source)
  on public.lessons to anon, authenticated;

grant select (id, lesson_id, position, title, body, source)
  on public.sections to anon, authenticated;

-- `status` IS granted here, unlike the other tables, because the policy on
-- `choices` reads questions.status, and a policy that reads ANOTHER table is
-- checked against the caller's column privileges (found by the content access
-- test; it failed closed with "permission denied for table questions"). It
-- leaks nothing: RLS only shows published rows, so it always reads 'published'.
grant select (id, section_id, position, prompt, source, status)
  on public.questions to anon, authenticated;

grant select (id, question_id, position, body)
  on public.choices to anon, authenticated;

-- ---------------------------------------------------------------- grader
-- Returns whether one choice is correct, plus its explanation. Returns no row
-- for an unknown choice or a choice whose question is not published, so a
-- draft answer cannot be probed.
--
-- Known limitation (accepted for lesson checks): calling this for each choice
-- of a question reveals which is correct. The practice test must NOT use this
-- function; it needs to grade a whole submission at once.

create function public.check_choice(p_choice_id text)
returns table (is_correct boolean, explanation text)
language sql
stable
security definer
set search_path = ''
as $$
  select c.is_correct, c.explanation
    from public.choices c
    join public.questions q on q.id = c.question_id
   where c.id = p_choice_id
     and q.status = 'published';
$$;

revoke all on function public.check_choice(text) from public, anon, authenticated;
grant execute on function public.check_choice(text) to anon, authenticated;
