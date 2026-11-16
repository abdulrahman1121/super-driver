-- Lesson 3: Speed and space (WA Driver Guide 4.17, 5.1, 5.2).
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
  ('wa-speed-space', 3, 'Speed and space',
   'Speed limits, school zones, and leaving room around your car.',
   'WA Driver Guide 4.17, 5.1, 5.2', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-speed-limits', 'wa-speed-space', 1, 'Speed limits and conditions',
   E'A speed limit is the maximum speed that is legal under ideal conditions. Washington law also requires you to drive at a speed that is safe for current conditions, so you may need to go slower than the limit. You can drive below the speed limit, but going over it is illegal.\n\nSlow down for:\n- Sharp curves or hills where you cannot see far\n- Slippery roads from rain, snow or ice\n- Places with pedestrians, children, cyclists or animals\n- Shopping centers, parking lots and heavy traffic\n- Narrow bridges and tunnels\n- Residential areas\n\nHigher speeds also mean longer stopping distances and more serious crashes.',
   'WA Driver Guide 5.1, Speed', 'draft'),
  ('wa-school-space', 'wa-speed-space', 2, 'School zones and following space',
   E'A school zone is the roads around a school building or playground. It may be marked with signs, pavement markings and flashing lights. The school zone speed limit is 20 mph. Signs may clarify when the 20 mph limit applies. Students may use the playground or join activities after hours, so slow down and watch whenever you are near a school.\n\nWhen driving near other vehicles, leave a distance of at least twice the length of your vehicle between you and the vehicle ahead. Leave even more room in the dark, on snowy roads, and behind large vehicles that block your view.',
   'WA Driver Guide 4.17 School zone; 5.2 Space; 5.6', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-limit-meaning', 'wa-speed-limits', 1,
   'What does a posted speed limit mean?',
   'WA Driver Guide 5.1, Speed limits', 'draft'),
  ('wa-q-rain', 'wa-speed-limits', 2,
   'It is raining and the road is slippery. The posted limit is 45 mph. What is the best choice?',
   'WA Driver Guide 5.1, Adjusting speed for conditions', 'draft'),
  ('wa-q-school-speed', 'wa-school-space', 1,
   'What is the speed limit in a school zone in Washington?',
   'WA Driver Guide 4.17, School zone', 'draft'),
  ('wa-q-space-gap', 'wa-school-space', 2,
   'When driving near other vehicles, how much distance does the guide say to keep between you and the vehicle ahead?',
   'WA Driver Guide 5.2, Space', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-limit-meaning-a', 'wa-q-limit-meaning', 4, 'The maximum speed that is legal under ideal conditions', true,
   'Right. You can drive below it, but going over it is illegal, and you must also drive at a speed that is safe for conditions.'),
  ('wa-q-limit-meaning-b', 'wa-q-limit-meaning', 1, 'The speed you should always drive', false,
   'Not quite. It is a maximum, and you may need to go slower when conditions are poor.'),
  ('wa-q-limit-meaning-c', 'wa-q-limit-meaning', 2, 'The minimum speed allowed', false,
   'The limit is a maximum, not a minimum. You can legally drive below it.'),
  ('wa-q-limit-meaning-d', 'wa-q-limit-meaning', 3, 'A speed that is safe in any weather', false,
   'The limit is for ideal conditions only. Rain, snow, ice and traffic may call for a lower speed.'),
  ('wa-q-rain-a', 'wa-q-rain', 3, 'Drive slower than 45 mph, enough to stay in control', true,
   'Right. The limit is for ideal conditions. You must drive at a speed that is safe for the road.'),
  ('wa-q-rain-b', 'wa-q-rain', 1, 'Drive exactly 45 mph so you do not hold anyone up', false,
   'Not quite. 45 mph may be too fast on a slippery road. Safe speed matters more than the posted number.'),
  ('wa-q-rain-c', 'wa-q-rain', 2, 'Drive faster to get off the road sooner', false,
   'Speeding on a slippery road increases stopping distance and the risk of losing control.'),
  ('wa-q-school-speed-a', 'wa-q-school-speed', 2, '20 mph', true,
   'Right. The school zone speed limit is 20 mph. Signs may say when it applies.'),
  ('wa-q-school-speed-b', 'wa-q-school-speed', 1, '15 mph', false,
   'Not quite. The school zone limit in the guide is 20 mph.'),
  ('wa-q-school-speed-c', 'wa-q-school-speed', 3, '25 mph', false,
   'Not quite. The school zone limit in the guide is 20 mph.'),
  ('wa-q-school-speed-d', 'wa-q-school-speed', 4, '30 mph', false,
   'Not quite. The school zone limit in the guide is 20 mph.'),
  ('wa-q-space-gap-a', 'wa-q-space-gap', 3, 'At least twice the length of your vehicle', true,
   'Right. The guide says to leave a distance of at least twice the length of your vehicle, and more in bad conditions.'),
  ('wa-q-space-gap-b', 'wa-q-space-gap', 1, 'About one car length', false,
   'That is too close. The guide says at least twice the length of your vehicle.'),
  ('wa-q-space-gap-c', 'wa-q-space-gap', 2, 'Half a car length', false,
   'That is much too close. The guide says at least twice the length of your vehicle.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
