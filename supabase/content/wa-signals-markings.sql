-- Lesson 2: Signals and road markings (WA Driver Guide 4.10, 4.11, 4.16).
--
-- Moved here from supabase/seed.sql so every lesson lives in its own file, with no
-- change to the data. Originally drafted from the official WA Driver Guide
-- (text-only edition, dol.wa.gov) by an AI assistant, and checked against the guide
-- by a person before it was first published. Inserted as 'draft', so visitors
-- cannot see it until it is published (see supabase/publish.sql). The correct
-- answers are spread across positions, not always first.
--
-- Idempotent on a fresh database: re-running updates rows by id and sets them back
-- to 'draft'. Do NOT paste this file into a database that already has the lesson
-- published: it would unpublish it, and if the stored positions differ from the
-- file the database refuses the update (two choices of one question cannot share
-- a position). IDs are stable; never rename them (saved progress references
-- question IDs).

-- ---------------------------------------------------------------- lessons
insert into public.lessons (id, position, title, summary, source, status) values
  ('wa-signals-markings', 2, 'Signals and road markings',
   'What traffic lights, flashing signals and painted lines tell you to do.',
   'WA Driver Guide 4.10, 4.11, 4.16', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-signals-lights', 'wa-signals-markings', 1, 'Traffic lights',
   E'- Solid red: stop. After a complete stop you may turn right on red if there is no "no turn on red" sign and you have plenty of room to enter traffic. You may turn left on red onto a one-way street under the same conditions.\n- Flashing red: works like a stop sign. Come to a full stop, then go when it is your turn.\n- Solid yellow: slow down, because the light is changing to red. Prepare to stop. If you are already in the intersection, continue through at the posted speed. You may not speed up to get through.\n- Flashing yellow: works like a yield sign. Slow down, treat it like an uncontrolled intersection, and go when you have the right-of-way.\n- Solid green: go, but wait for the intersection to clear and yield to pedestrians and emergency vehicles.\n\nLaw enforcement, construction workers and school crossing guards can overrule signals. Follow their directions.',
   'WA Driver Guide 4.11, 4.10', 'draft'),
  ('wa-signals-lines', 'wa-signals-markings', 2, 'Lines on the road',
   E'- Yellow lines separate traffic moving in opposite directions. White lines separate lanes moving the same direction.\n- Dashed yellow line on your side: you may pass if it is safe.\n- Solid yellow line on your side: do not cross it to pass.\n- Double solid yellow centerline: no passing, in either direction.\n- Solid white line: stay in your lane unless a special situation requires you to change.\n- Dashed white line between lanes: you may change lanes if it is safe.\n- Stop lines: stop before your vehicle reaches the stop line or the crosswalk.',
   'WA Driver Guide 4.16, Road markings', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-flashing-red', 'wa-signals-lights', 1,
   'You come to a flashing red light. What does it mean?',
   'WA Driver Guide 4.11, Flashing Red', 'draft'),
  ('wa-q-flashing-yellow', 'wa-signals-lights', 2,
   'A flashing yellow light has the same meaning as which sign?',
   'WA Driver Guide 4.11, Flashing Yellow', 'draft'),
  ('wa-q-yellow-in-intersection', 'wa-signals-lights', 3,
   'The light turns yellow while you are already in the intersection. What should you do?',
   'WA Driver Guide 4.11, Solid Yellow', 'draft'),
  ('wa-q-double-yellow', 'wa-signals-lines', 1,
   'A double solid yellow line runs down the middle of the road. What does it mean?',
   'WA Driver Guide 4.16, Double solid yellow centerline', 'draft'),
  ('wa-q-dashed-white', 'wa-signals-lines', 2,
   'A dashed white line separates two lanes going the same direction. What does it mean?',
   'WA Driver Guide 4.16, Dashed white line between lanes of traffic', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-flashing-red-a', 'wa-q-flashing-red', 2, 'Stop completely, then go when it is your turn', true,
   'Right. A flashing red light works like a stop sign.'),
  ('wa-q-flashing-red-b', 'wa-q-flashing-red', 1, 'Slow down and go through carefully', false,
   'Not quite. Flashing red means a full stop, not just slowing down.'),
  ('wa-q-flashing-red-c', 'wa-q-flashing-red', 3, 'Stop only if other cars are coming', false,
   'You must always stop first, like at a stop sign, and then go when it is your turn.'),
  ('wa-q-flashing-red-d', 'wa-q-flashing-red', 4, 'It is only a warning, so keep going', false,
   'A flashing red light is not just a warning. It works like a stop sign.'),
  ('wa-q-flashing-yellow-a', 'wa-q-flashing-yellow', 1, 'Yield sign', true,
   'Right. Slow down, treat it like an uncontrolled intersection, and go when you have the right-of-way.'),
  ('wa-q-flashing-yellow-b', 'wa-q-flashing-yellow', 2, 'Stop sign', false,
   'A stop sign matches a flashing red light. Flashing yellow matches a yield sign.'),
  ('wa-q-flashing-yellow-c', 'wa-q-flashing-yellow', 3, 'Speed limit sign', false,
   'A flashing yellow light is about right-of-way, so it matches a yield sign.'),
  ('wa-q-yellow-in-intersection-a', 'wa-q-yellow-in-intersection', 3, 'Continue through at the posted speed', true,
   'Right. If you are already in the intersection when it turns yellow, keep going at the posted speed.'),
  ('wa-q-yellow-in-intersection-b', 'wa-q-yellow-in-intersection', 1, 'Stop right where you are', false,
   'Stopping inside an intersection is unsafe. Continue through at the posted speed.'),
  ('wa-q-yellow-in-intersection-c', 'wa-q-yellow-in-intersection', 2, 'Speed up to clear it quickly', false,
   'You are not allowed to speed up beyond the posted speed limit to clear an intersection on yellow.'),
  ('wa-q-yellow-in-intersection-d', 'wa-q-yellow-in-intersection', 4, 'Back up to the stop line', false,
   'Do not back up. Continue through the intersection at the posted speed.'),
  ('wa-q-double-yellow-a', 'wa-q-double-yellow', 1, 'No passing, in either direction', true,
   'Right. Double solid yellow centerlines mean you may not pass, in either direction.'),
  ('wa-q-double-yellow-b', 'wa-q-double-yellow', 2, 'You may pass if the road ahead is clear', false,
   'Not quite. You may not pass on a road with double solid yellow lines, even if the road is clear.'),
  ('wa-q-double-yellow-c', 'wa-q-double-yellow', 3, 'Only slow vehicles may pass', false,
   'No one may pass across double solid yellow lines.'),
  ('wa-q-double-yellow-d', 'wa-q-double-yellow', 4, 'The road is about to end', false,
   'Double yellow lines show the middle of a 2-way road and mean no passing.'),
  ('wa-q-dashed-white-a', 'wa-q-dashed-white', 2, 'You may change lanes if it is safe', true,
   'Right. A dashed white line between lanes means you can cross it to change lanes when it is safe.'),
  ('wa-q-dashed-white-b', 'wa-q-dashed-white', 1, 'You must stay in your lane', false,
   'That is a solid white line. A dashed white line allows lane changes when it is safe.'),
  ('wa-q-dashed-white-c', 'wa-q-dashed-white', 3, 'The traffic is going in opposite directions', false,
   'White lines separate lanes going the same direction. Yellow lines separate opposite directions.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
