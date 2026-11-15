-- Learning content seed (WA only).
--
-- STATUS: UNVERIFIED DRAFT CONTENT. Drafted 2026-11-08 from the official WA
-- Driver Guide (text-only edition, dol.wa.gov) by an AI assistant, with no
-- automated review yet. Everything is inserted as 'draft', so visitors cannot
-- see it. A human must check each item against the guide, then run
-- supabase/publish.sql. See "Temporary shortcuts and debt" in CLAUDE.md.
--
-- Idempotent: re-running updates rows by id and sets them back to 'draft'
-- (any edit returns an item to draft). IDs are stable; never rename them,
-- because saved progress references question IDs.
--
-- Loaded automatically by `npm run db:reset`. On the hosted project, paste this
-- file into the Supabase SQL editor.

-- ---------------------------------------------------------------- lessons
insert into public.lessons (id, position, title, summary, source, status) values
  ('wa-intersections', 1, 'Intersections and right-of-way',
   'Who goes first at stop signs, uncontrolled intersections and broken signals.',
   'WA Driver Guide 4.10, 4.13, 4.15', 'draft'),
  ('wa-signals-markings', 2, 'Signals and road markings',
   'What traffic lights, flashing signals and painted lines tell you to do.',
   'WA Driver Guide 4.10, 4.11, 4.16', 'draft'),
  ('wa-speed-space', 3, 'Speed and space',
   'Speed limits, school zones, and leaving room around your car.',
   'WA Driver Guide 4.17, 5.1, 5.2', 'draft'),
  ('wa-sharing-road', 4, 'Sharing the road',
   'Pedestrians, bicyclists and school buses.',
   'WA Driver Guide 4.1, 4.2, 4.16', 'draft')
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
   'WA Driver Guide 4.15, 4.10, 4.13', 'draft'),

  ('wa-signals-lights', 'wa-signals-markings', 1, 'Traffic lights',
   E'- Solid red: stop. After a complete stop you may turn right on red if there is no "no turn on red" sign and you have plenty of room to enter traffic. You may turn left on red onto a one-way street under the same conditions.\n- Flashing red: works like a stop sign. Come to a full stop, then go when it is your turn.\n- Solid yellow: slow down, because the light is changing to red. Prepare to stop. If you are already in the intersection, continue through at the posted speed. You may not speed up to get through.\n- Flashing yellow: works like a yield sign. Slow down, treat it like an uncontrolled intersection, and go when you have the right-of-way.\n- Solid green: go, but wait for the intersection to clear and yield to pedestrians and emergency vehicles.\n\nLaw enforcement, construction workers and school crossing guards can overrule signals. Follow their directions.',
   'WA Driver Guide 4.11, 4.10', 'draft'),
  ('wa-signals-lines', 'wa-signals-markings', 2, 'Lines on the road',
   E'- Yellow lines separate traffic moving in opposite directions. White lines separate lanes moving the same direction.\n- Dashed yellow line on your side: you may pass if it is safe.\n- Solid yellow line on your side: do not cross it to pass.\n- Double solid yellow centerline: no passing, in either direction.\n- Solid white line: stay in your lane unless a special situation requires you to change.\n- Dashed white line between lanes: you may change lanes if it is safe.\n- Stop lines: stop before your vehicle reaches the stop line or the crosswalk.',
   'WA Driver Guide 4.16, Road markings', 'draft'),

  ('wa-speed-limits', 'wa-speed-space', 1, 'Speed limits and conditions',
   E'A speed limit is the maximum speed that is legal under ideal conditions. Washington law also requires you to drive at a speed that is safe for current conditions, so you may need to go slower than the limit. You can drive below the speed limit, but going over it is illegal.\n\nSlow down for:\n- Sharp curves or hills where you cannot see far\n- Slippery roads from rain, snow or ice\n- Places with pedestrians, children, cyclists or animals\n- Shopping centers, parking lots and heavy traffic\n- Narrow bridges and tunnels\n- Residential areas\n\nHigher speeds also mean longer stopping distances and more serious crashes.',
   'WA Driver Guide 5.1, Speed', 'draft'),
  ('wa-school-space', 'wa-speed-space', 2, 'School zones and following space',
   E'A school zone is the roads around a school building or playground. It may be marked with signs, pavement markings and flashing lights. The school zone speed limit is 20 mph. Signs may clarify when the 20 mph limit applies. Students may use the playground or join activities after hours, so slow down and watch whenever you are near a school.\n\nWhen driving near other vehicles, leave a distance of at least twice the length of your vehicle between you and the vehicle ahead. Leave even more room in the dark, on snowy roads, and behind large vehicles that block your view.',
   'WA Driver Guide 4.17 School zone; 5.2 Space; 5.6', 'draft'),

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
   'WA Driver Guide 4.15, Uncontrolled intersections', 'draft'),

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
   'WA Driver Guide 4.16, Dashed white line between lanes of traffic', 'draft'),

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
   'WA Driver Guide 5.2, Space', 'draft'),

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
-- Exactly one is_correct per question. Every choice has an explanation.
-- Correct answers are spread across positions 1 to 4 (changed 2026-11-15); they used
-- to be first every time. The browser also shuffles the order at display time.
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
   'Speed does not decide right-of-way. The rule is that you yield when entering a paved road from an unpaved one.'),

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
   'White lines separate lanes going the same direction. Yellow lines separate opposite directions.'),

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
   'That is much too close. The guide says at least twice the length of your vehicle.'),

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
