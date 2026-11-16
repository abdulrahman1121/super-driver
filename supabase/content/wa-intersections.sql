-- Lesson 1: Intersections and right-of-way (WA Driver Guide 4.10, 4.13, 4.15).
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
  ('wa-intersections', 1, 'Intersections and right-of-way',
   'Who goes first at stop signs, uncontrolled intersections and broken signals.',
   'WA Driver Guide 4.10, 4.13, 4.15', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-intersections-stops', 'wa-intersections', 1, 'Four-way and two-way stops',
   E'Right-of-way rules decide the order vehicles move through an intersection. The law decides who must yield, which means give up the right-of-way.\n\nAt a 4-way stop:\n- The first vehicle to arrive is the first to go.\n- The second vehicle to arrive goes second, and so on.\n- If two vehicles arrive at about the same time, yield to the one on your right.\n- A vehicle turning left must yield to vehicles going straight or turning right.\n\nAt a 2-way stop, turning vehicles must yield to the vehicle going straight. The vehicle going straight has the right-of-way.',
   'WA Driver Guide 4.13, Right-of-way', 'draft'),
  ('wa-intersections-uncontrolled', 'wa-intersections', 2, 'Uncontrolled intersections and broken signals',
   E'Uncontrolled intersections have no signs or signals, but the normal right-of-way rules still apply. You must yield if any of these are true:\n- A vehicle is already in the intersection.\n- You enter or cross a state highway from a secondary road.\n- You enter a paved road from an unpaved road.\n- You plan to turn left and a vehicle is approaching from the opposite direction.\n\nIf a traffic signal is not working, treat the intersection like a 4-way stop. Come to a complete stop, yield to traffic on your right, and go only when it is safe.\n\nEvery intersection is legally a crosswalk, whether or not it is marked.',
   'WA Driver Guide 4.15, 4.10, 4.13', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-4way-same-time', 'wa-intersections-stops', 1,
   'You and another driver stop at a 4-way stop at about the same time. The other car is on your right. Who goes first?',
   'WA Driver Guide 4.13, 4-way stop', 'draft'),
  ('wa-q-4way-left-turn', 'wa-intersections-stops', 2,
   'At a 4-way stop, you and an oncoming car arrive at about the same time. You want to turn left and the other driver is going straight. What should you do?',
   'WA Driver Guide 4.13, 4-way stop', 'draft'),
  ('wa-q-signal-out', 'wa-intersections-uncontrolled', 1,
   'The traffic light at an intersection is dark and not working. What should you do?',
   'WA Driver Guide 4.10, Broken lights or signals', 'draft'),
  ('wa-q-unpaved', 'wa-intersections-uncontrolled', 2,
   'You are on an unpaved road about to enter a paved road. Who has the right-of-way?',
   'WA Driver Guide 4.15, Uncontrolled intersections', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-4way-same-time-a', 'wa-q-4way-same-time', 3, 'The car on your right', true,
   'Right. If two vehicles arrive at about the same time, you yield to the one on your right.'),
  ('wa-q-4way-same-time-b', 'wa-q-4way-same-time', 1, 'You, because you are on the left', false,
   'Not quite. Being on the left means you yield. The vehicle on your right goes first.'),
  ('wa-q-4way-same-time-c', 'wa-q-4way-same-time', 2, 'The larger vehicle', false,
   'Size does not decide right-of-way at a 4-way stop. Arrival order does, then the vehicle on the right.'),
  ('wa-q-4way-same-time-d', 'wa-q-4way-same-time', 4, 'Whoever honks first', false,
   'Honking does not give anyone the right-of-way. Use the arrival and right-hand rules.'),
  ('wa-q-4way-left-turn-a', 'wa-q-4way-left-turn', 2, 'Wait and let the oncoming car go first', true,
   'Right. A vehicle turning left must yield to vehicles going straight or turning right.'),
  ('wa-q-4way-left-turn-b', 'wa-q-4way-left-turn', 1, 'Turn first, because you are turning', false,
   'Not quite. Turning left means you yield to the car going straight.'),
  ('wa-q-4way-left-turn-c', 'wa-q-4way-left-turn', 3, 'Turn first if you flash your headlights', false,
   'Signals like this do not change who has the right-of-way. The left-turning vehicle yields.'),
  ('wa-q-signal-out-a', 'wa-q-signal-out', 4, 'Treat the intersection like a 4-way stop', true,
   'Right. Come to a complete stop, yield to traffic on your right, and go when it is safe.'),
  ('wa-q-signal-out-b', 'wa-q-signal-out', 1, 'Slow down and go through if no cars are visible', false,
   'Not quite. You must come to a complete stop first, like at a 4-way stop.'),
  ('wa-q-signal-out-c', 'wa-q-signal-out', 2, 'Follow the car ahead of you', false,
   'Each driver must stop and take their turn. Following the car ahead skips that step.'),
  ('wa-q-signal-out-d', 'wa-q-signal-out', 3, 'Treat it like a yield sign', false,
   'A dark signal works like a 4-way stop, which means a full stop, not just a yield.'),
  ('wa-q-unpaved-a', 'wa-q-unpaved', 3, 'Traffic on the paved road', true,
   'Right. When you enter a paved road from an unpaved road, you must yield.'),
  ('wa-q-unpaved-b', 'wa-q-unpaved', 1, 'You, if you got there first', false,
   'Not quite. Arriving first does not help here. Entering a paved road from an unpaved road means you yield.'),
  ('wa-q-unpaved-c', 'wa-q-unpaved', 2, 'Whoever is going faster', false,
   'Speed does not decide right-of-way. The rule is that you yield when entering a paved road from an unpaved one.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
