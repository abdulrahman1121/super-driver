-- Lesson 4: Sharing the road (WA Driver Guide 4.1, 4.2, 4.16).
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
  ('wa-sharing-road', 4, 'Sharing the road',
   'Pedestrians, bicyclists and school buses.',
   'WA Driver Guide 4.1, 4.2, 4.16', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-people', 'wa-sharing-road', 1, 'Pedestrians and bicyclists',
   E'Always yield to pedestrians. Pedestrians and bicyclists have the right-of-way at crosswalks and intersections, whether or not the road is marked.\n\n- Wait until a pedestrian has cleared your lane and one more lane before you go.\n- If a person uses a wheelchair, cane or service animal, wait until they have crossed the whole street.\n- Do not drive into oncoming traffic to pass a pedestrian or bicyclist.\n- Do not honk at a person with a service animal. It can confuse or frighten them.\n\nWhere a lane is shared with bicycles (marked with sharrows), drive slowly and give at least 3 feet of space when you pass.',
   'WA Driver Guide 4.1, 4.16 Sharrows', 'draft'),
  ('wa-school-buses', 'wa-sharing-road', 2, 'School buses',
   E'School bus lights work like traffic signals: red means stop, and yellow means caution or slow down. Fines are doubled for passing a stopped school bus.\n\n- If you are behind the bus or going the same direction, stop when the red lights flash and the stop sign is extended.\n- Do not use a center turn lane to pass a school bus.\n- On a 2-lane road, traffic coming toward the bus must stop too.\n- On a road with 3 or more lanes, or with lanes separated by a median or barrier, traffic going the opposite direction does not need to stop.\n- Keep watching for children even after the red lights stop flashing.',
   'WA Driver Guide 4.2', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-unmarked-crosswalk', 'wa-people', 1,
   'You reach an intersection with no painted crosswalk lines. Is there a crosswalk?',
   'WA Driver Guide 4.13, 4.16 Crosswalks', 'draft'),
  ('wa-q-sharrow-space', 'wa-people', 2,
   'You are passing a person riding a bike in a lane marked with sharrows. How much space should you give?',
   'WA Driver Guide 4.16, Sharrows', 'draft'),
  ('wa-q-bus-two-lane', 'wa-school-buses', 1,
   'You are driving toward a school bus on a 2-lane road. Its red lights are flashing and its stop sign is extended. What should you do?',
   'WA Driver Guide 4.2', 'draft'),
  ('wa-q-bus-median', 'wa-school-buses', 2,
   'A school bus has its red lights flashing on the other side of a road that has a median. You are going the opposite direction. Do you have to stop?',
   'WA Driver Guide 4.2', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-unmarked-crosswalk-a', 'wa-q-unmarked-crosswalk', 2, 'Yes, every intersection is legally a crosswalk', true,
   'Right. Every intersection is legally a crosswalk, whether or not it is marked, so be ready to yield.'),
  ('wa-q-unmarked-crosswalk-b', 'wa-q-unmarked-crosswalk', 1, 'No, only painted crosswalks count', false,
   'Not quite. Unmarked intersections are crosswalks too.'),
  ('wa-q-unmarked-crosswalk-c', 'wa-q-unmarked-crosswalk', 3, 'Only if there is a traffic signal', false,
   'A signal is not needed. Every intersection is legally a crosswalk.'),
  ('wa-q-sharrow-space-a', 'wa-q-sharrow-space', 3, 'At least 3 feet', true,
   'Right. Drive slowly and give at least 3 feet of space when passing a bicycle in a sharrow lane.'),
  ('wa-q-sharrow-space-b', 'wa-q-sharrow-space', 1, 'About 1 foot', false,
   'That is too close. Give at least 3 feet.'),
  ('wa-q-sharrow-space-c', 'wa-q-sharrow-space', 2, 'Six inches', false,
   'That is much too close. Give at least 3 feet.'),
  ('wa-q-bus-two-lane-a', 'wa-q-bus-two-lane', 2, 'Stop', true,
   'Right. On a 2-lane road, all vehicles must stop when the red lights flash and the stop sign extends.'),
  ('wa-q-bus-two-lane-b', 'wa-q-bus-two-lane', 1, 'Slow down and pass carefully', false,
   'Not quite. It is unlawful to pass when the red lights flash. You must stop.'),
  ('wa-q-bus-two-lane-c', 'wa-q-bus-two-lane', 3, 'Stop only if you can see children', false,
   'You must stop whenever the red lights flash and the stop sign is extended, even if you cannot see children.'),
  ('wa-q-bus-two-lane-d', 'wa-q-bus-two-lane', 4, 'Keep going, since the bus is in the other lane', false,
   'On a 2-lane road, traffic coming toward the bus must stop too.'),
  ('wa-q-bus-median-a', 'wa-q-bus-median', 1, 'No, you do not need to stop', true,
   'Right. When lanes are separated by a median or barrier, drivers going the opposite direction do not need to stop. Keep watching for children.'),
  ('wa-q-bus-median-b', 'wa-q-bus-median', 2, 'Yes, you must always stop', false,
   'Not quite. Opposite-direction traffic does not need to stop when a median or barrier separates the lanes.'),
  ('wa-q-bus-median-c', 'wa-q-bus-median', 3, 'Only if you see children', false,
   'The rule depends on the road layout, not on seeing children. With a median or barrier you do not need to stop, but stay alert.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
