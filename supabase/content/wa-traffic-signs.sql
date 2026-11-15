-- Lesson 5: Traffic signs (WA Driver Guide 4.12).
--
-- STATUS: UNVERIFIED DRAFT CONTENT. Drafted 2026-11-13 from the official WA
-- Driver Guide (text-only edition, dol.wa.gov, (c) 2025) by an AI assistant and
-- checked by a second AI reviewer only. Inserted as 'draft', so visitors cannot
-- see it. A person must check it against the guide before it is published.
--
-- Idempotent: re-running updates rows by id and sets them back to 'draft'.
-- IDs are stable; never rename them (saved progress references question IDs).

-- ---------------------------------------------------------------- lessons
insert into public.lessons (id, position, title, summary, source, status) values
  ('wa-traffic-signs', 5, 'Traffic signs',
   'What sign colors mean, and what to do at the signs you will see most.',
   'WA Driver Guide 4.12', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-traffic-signs-colors', 'wa-traffic-signs', 1, 'What sign colors mean',
   E'Traffic signs tell you about traffic rules, hazards, road directions and where to find services along the road. A sign''s shape, color, symbols and words all give you clues about the kind of information it gives.\n\nWhat the colors mean:\n- Red: an action that is prohibited (not allowed) or restricted\n- Orange: a warning about construction and maintenance\n- Yellow: a warning about general and unexpected road conditions\n- Fluorescent yellow-green: a warning about school, pedestrian and bicycling activity\n- White: regulatory\n- Green: guide or direction information\n- Blue: guidance to services for drivers\n- Brown: public recreation, cultural and historical areas\n\nColor is one of the clues to the type of information a sign gives.',
   'WA Driver Guide 4.12, Signs', 'draft'),
  ('wa-traffic-signs-stop-yield', 'wa-traffic-signs', 2, 'Stop, yield and keep right',
   E'These common signs each tell you exactly what to do.\n\n- Stop: you must stop at the line, crosswalk or corner. Look for crossing vehicles and pedestrians in all directions, and yield the right-of-way.\n- Yield: slow down and let traffic that has the right-of-way cross first.\n- Keep Right: stay in the right lane unless you are passing another vehicle.\n\nAt a stop sign, stopping is only the first step. You still need to look in all directions for vehicles and people, and yield the right-of-way before you go. At a yield sign, you must slow down and let traffic with the right-of-way cross first.',
   'WA Driver Guide 4.12, Stop; Yield; Keep Right', 'draft'),
  ('wa-traffic-signs-speed', 'wa-traffic-signs', 3, 'Speed signs',
   E'Speed limit signs show the maximum safe speed allowed, or the minimum safe speed required.\n\n- The maximum speed limit is for ideal conditions. Slow down when conditions require it, such as when the road is slippery or it is foggy and hard to see. Even if you are under the posted limit, you can get a ticket for going too fast for road conditions.\n- Some roads have a minimum speed limit. You are required to go at least that fast, so you are not a hazard to other drivers.\n\nSpeed warning signs tell you a speed change is recommended for a possible hazard or road condition, often a curve or turn. Adjust your speed for the road, weather and traffic, and follow the speed warning limit.\n\nVariable speed limit signs are digital signs that post changing speed limits to help spread out the flow of traffic. Digital advanced notification signs can also close whole lanes quickly and warn you before you reach slower traffic.',
   'WA Driver Guide 4.12, Speed Limit; Speed warning; Variable speed limit and advanced notification', 'draft'),
  ('wa-traffic-signs-direction', 'wa-traffic-signs', 4, 'Which way to go, and what not to do',
   E'These signs tell you which way traffic may go and which moves are not allowed.\n\n- One-way: traffic flows only in the direction of the arrow. Never drive the wrong way on a one-way street.\n- Not allowed: some regulatory signs have a red circle with a red slash over a symbol. They mean that action, such as a left turn, right turn or U-turn, is not allowed.\n- Do Not Enter: a square sign with a white horizontal line inside a circle. You cannot enter the street from that direction.\n- Wrong Way: you are driving in the wrong direction. Stop and turn around right away. This sign is meant to prevent head-on crashes.\n- No passing: shows where passing is not allowed. You might see it near hills, curves, intersections and other places where a vehicle could enter the road. Other signs and lane markings show where it is safe to pass.\n- Shared center lane left turn only: the lane is for vehicles turning left from either direction. Do not use it for through traffic or for passing. Arrows are often painted on the road.\n- Roundabout: marks the entrance to a roundabout. You may also see yield, pedestrian warning and direction arrow signs there.',
   'WA Driver Guide 4.12, 1-Way; Not allowed; Do Not Enter; Wrong Way; No passing and passing safely; Shared center lane left turn only; Roundabout', 'draft'),
  ('wa-traffic-signs-work-zones', 'wa-traffic-signs', 5, 'Work zones and traffic cameras',
   E'Work zone signs warn you that people are working near the road. They are used for construction, maintenance and emergency operations.\n\n- Drivers, pedestrians and bicyclists must yield to highway construction workers, to vehicles with flashing yellow lights, and to equipment inside a highway construction or maintenance work zone.\n- Fines double for offenses in construction areas when workers are present.\n\nThe guide says automated traffic safety cameras record images if you:\n- Fail to stop at a steady red light\n- Fail to stop at a railroad crossing signal\n- Go over the speed limit in a school zone\n\nAll places with traffic cameras are clearly marked. Speeding tickets from these camera locations are mailed to the vehicle owner.',
   'WA Driver Guide 4.12, Work zone signs; Automated traffic safety cameras', 'draft'),
  ('wa-traffic-signs-guide', 'wa-traffic-signs', 6, 'Guide signs and other signs',
   E'Some signs help you find your way and the places you need.\n\n- Service signs show where services are, such as hospitals, electric vehicle charging stations and rest areas.\n- Recreation signs show local attractions, such as hiking trails, picnic spaces and skiing areas.\n- Destination signs show directions and distances to places such as cities, airports and state lines, and to special areas such as national parks, historical areas and museums.\n- Route number signs use their shape and color to show the type of road: interstate, U.S., state, city or county road.\n\nWashington has many more signs, such as curve, hill, merge, deer crossing, slippery when wet, low clearance, signal ahead, chain advisory, tsunami hazard zone and volcano evacuation route signs. You are responsible for knowing all signs, including city and county signs.',
   'WA Driver Guide 4.12, Service signs; Recreation signs; Destination signs; Other traffic signs', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-signs-yellow', 'wa-traffic-signs-colors', 1,
   'What does a yellow sign warn you about?',
   'WA Driver Guide 4.12, Signs', 'draft'),
  ('wa-q-signs-yellow-green', 'wa-traffic-signs-colors', 2,
   'What does a fluorescent yellow-green sign warn you about?',
   'WA Driver Guide 4.12, Signs', 'draft'),
  ('wa-q-signs-brown', 'wa-traffic-signs-colors', 3,
   'What does a brown sign identify?',
   'WA Driver Guide 4.12, Signs', 'draft'),

  ('wa-q-signs-stop-look', 'wa-traffic-signs-stop-yield', 1,
   'You have come to a full stop at a stop sign. What should you do before you go?',
   'WA Driver Guide 4.12, Stop', 'draft'),
  ('wa-q-signs-yield', 'wa-traffic-signs-stop-yield', 2,
   'You come to a yield sign. What does it tell you to do?',
   'WA Driver Guide 4.12, Yield', 'draft'),
  ('wa-q-signs-keep-right', 'wa-traffic-signs-stop-yield', 3,
   'What does a Keep Right sign remind you to do?',
   'WA Driver Guide 4.12, Keep Right', 'draft'),

  ('wa-q-signs-minimum-speed', 'wa-traffic-signs-speed', 1,
   'A road has a posted minimum speed limit. What does that mean for you?',
   'WA Driver Guide 4.12, Speed Limit', 'draft'),
  ('wa-q-signs-too-fast', 'wa-traffic-signs-speed', 2,
   'It is foggy and hard to see. You are driving just under the posted speed limit. Can you get a ticket for your speed?',
   'WA Driver Guide 4.12, Speed Limit', 'draft'),
  ('wa-q-signs-speed-warning', 'wa-traffic-signs-speed', 3,
   'A speed warning sign before a sharp curve shows a speed lower than the speed limit. What should you do?',
   'WA Driver Guide 4.12, Speed warning', 'draft'),

  ('wa-q-signs-wrong-way', 'wa-traffic-signs-direction', 1,
   'You see a Wrong Way sign facing you. What should you do?',
   'WA Driver Guide 4.12, Wrong Way', 'draft'),
  ('wa-q-signs-no-u-turn', 'wa-traffic-signs-direction', 2,
   'A sign shows a U-turn symbol inside a red circle with a red slash over it. What does it mean?',
   'WA Driver Guide 4.12, Not allowed', 'draft'),
  ('wa-q-signs-center-lane', 'wa-traffic-signs-direction', 3,
   'A sign marks the middle lane as a shared center lane for left turns only. How may you use that lane?',
   'WA Driver Guide 4.12, Shared center lane left turn only', 'draft'),

  ('wa-q-signs-work-zone-yield', 'wa-traffic-signs-work-zones', 1,
   'You are driving through a highway construction work zone. Who must you yield to?',
   'WA Driver Guide 4.12, Work zone signs', 'draft'),
  ('wa-q-signs-work-zone-fines', 'wa-traffic-signs-work-zones', 2,
   'You get a ticket in a construction area while workers are present. What happens to the fine?',
   'WA Driver Guide 4.12, Work zone signs', 'draft'),
  ('wa-q-signs-camera', 'wa-traffic-signs-work-zones', 3,
   'An automated traffic safety camera will record images if you do which of these?',
   'WA Driver Guide 4.12, Automated traffic safety cameras', 'draft'),

  ('wa-q-signs-service', 'wa-traffic-signs-guide', 1,
   'You need to find an electric vehicle charging station. Which kind of sign shows where one is?',
   'WA Driver Guide 4.12, Service signs', 'draft'),
  ('wa-q-signs-know-all', 'wa-traffic-signs-guide', 2,
   'As a Washington driver, which traffic signs are you responsible for knowing?',
   'WA Driver Guide 4.12, Other traffic signs', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
-- The correct answer's position varies across questions on purpose.
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-signs-yellow-a', 'wa-q-signs-yellow', 1, 'Construction and maintenance work', false,
   'Not quite. Orange signs warn about construction and maintenance. Yellow signs warn about general and unexpected road conditions.'),
  ('wa-q-signs-yellow-b', 'wa-q-signs-yellow', 2, 'School, pedestrian and bicycling activity', false,
   'That is what fluorescent yellow-green signs warn about. Plain yellow signs warn about general and unexpected road conditions.'),
  ('wa-q-signs-yellow-c', 'wa-q-signs-yellow', 3, 'General and unexpected road conditions', true,
   'Right. Yellow signs warn about general and unexpected road conditions.'),
  ('wa-q-signs-yellow-d', 'wa-q-signs-yellow', 4, 'Guide or directional information', false,
   'That is green. Yellow signs warn about general and unexpected road conditions.'),

  ('wa-q-signs-yellow-green-a', 'wa-q-signs-yellow-green', 1, 'School, pedestrian and bicycling activity', true,
   'Right. Fluorescent yellow-green signs warn of school, pedestrian and bicycling activity.'),
  ('wa-q-signs-yellow-green-b', 'wa-q-signs-yellow-green', 2, 'Construction and maintenance work', false,
   'That is orange. Fluorescent yellow-green signs warn of school, pedestrian and bicycling activity.'),
  ('wa-q-signs-yellow-green-c', 'wa-q-signs-yellow-green', 3, 'General and unexpected road conditions ahead', false,
   'That is plain yellow. Fluorescent yellow-green signs warn of school, pedestrian and bicycling activity.'),
  ('wa-q-signs-yellow-green-d', 'wa-q-signs-yellow-green', 4, 'An action that is not allowed or is restricted', false,
   'That is red. Fluorescent yellow-green signs warn of school, pedestrian and bicycling activity.'),

  ('wa-q-signs-brown-a', 'wa-q-signs-brown', 1, 'An action that is not allowed or is restricted', false,
   'Not quite. Red is the color for prohibited or restricted actions. Brown identifies public recreation, cultural and historical areas.'),
  ('wa-q-signs-brown-b', 'wa-q-signs-brown', 2, 'Guidance to services for drivers', false,
   'That is blue. Brown identifies public recreation, cultural and historical areas.'),
  ('wa-q-signs-brown-c', 'wa-q-signs-brown', 3, 'A warning about general and unexpected road conditions', false,
   'That is yellow. Brown identifies public recreation, cultural and historical areas.'),
  ('wa-q-signs-brown-d', 'wa-q-signs-brown', 4, 'Public recreation, cultural and historical areas', true,
   'Right. Brown signs identify public recreation, cultural and historical areas.'),

  ('wa-q-signs-stop-look-a', 'wa-q-signs-stop-look', 1, 'Go right away, since you have already made a full stop', false,
   'Not quite. Stopping is only the first step. You must also look in all directions and yield the right-of-way.'),
  ('wa-q-signs-stop-look-b', 'wa-q-signs-stop-look', 2, 'Look all ways for vehicles and people, then yield', true,
   'Right. Look for crossing vehicles and pedestrians in all directions and yield the right-of-way.'),
  ('wa-q-signs-stop-look-c', 'wa-q-signs-stop-look', 3, 'Look only to your left for cars, then go', false,
   'Looking one way is not enough. Look for crossing vehicles and pedestrians in all directions, and yield the right-of-way.'),

  ('wa-q-signs-yield-a', 'wa-q-signs-yield', 1, 'Speed up so you get ahead of cross traffic', false,
   'Not quite. A yield sign means slow down, not speed up, and let traffic with the right-of-way cross first.'),
  ('wa-q-signs-yield-b', 'wa-q-signs-yield', 2, 'Keep going, because the other drivers must yield to you instead', false,
   'The yield sign is for you. You must let traffic that has the right-of-way cross first.'),
  ('wa-q-signs-yield-c', 'wa-q-signs-yield', 3, 'Stop at the sign, then go even if traffic is coming', false,
   'You must let traffic that has the right-of-way cross first, not pull out in front of it.'),
  ('wa-q-signs-yield-d', 'wa-q-signs-yield', 4, 'Slow down and let traffic with the right-of-way cross first', true,
   'Right. A yield sign means you slow down and allow traffic that has the right-of-way to cross first.'),

  ('wa-q-signs-keep-right-a', 'wa-q-signs-keep-right', 1, 'Turn right at the next intersection you reach', false,
   'Not quite. The sign is not a turn instruction. It reminds you to stay in the right lane unless you are passing.'),
  ('wa-q-signs-keep-right-b', 'wa-q-signs-keep-right', 2, 'Use the right lane only when it is dark outside', false,
   'The reminder is not just for nighttime. Stay in the right lane unless you are passing another vehicle.'),
  ('wa-q-signs-keep-right-c', 'wa-q-signs-keep-right', 3, 'Stay in the right lane unless you are passing', true,
   'Right. A Keep Right sign reminds you to stay in the right lane unless you are passing another vehicle.'),
  ('wa-q-signs-keep-right-d', 'wa-q-signs-keep-right', 4, 'Drive on the right shoulder when traffic is slow', false,
   'The sign is about the right lane, not the shoulder. Stay in the right lane unless you are passing.'),

  ('wa-q-signs-minimum-speed-a', 'wa-q-signs-minimum-speed', 1, 'It is only a suggestion, so you may drive slower if you like', false,
   'Not quite. A minimum speed limit is required. You must travel at least that fast.'),
  ('wa-q-signs-minimum-speed-b', 'wa-q-signs-minimum-speed', 2, 'You must go at least that fast, so you are not a hazard', true,
   'Right. You are required to travel at least the minimum speed so you are not a hazard to other drivers.'),
  ('wa-q-signs-minimum-speed-c', 'wa-q-signs-minimum-speed', 3, 'It applies only to large trucks and buses', false,
   'The minimum speed limit applies to you too. You are required to travel at least that fast.'),
  ('wa-q-signs-minimum-speed-d', 'wa-q-signs-minimum-speed', 4, 'You must drive at exactly that speed the whole time', false,
   'A minimum is the lowest speed required, not the only speed allowed. You must go at least that fast.'),

  ('wa-q-signs-too-fast-a', 'wa-q-signs-too-fast', 1, 'Yes, if you are going too fast for the conditions', true,
   'Right. The posted limit is for ideal conditions. Even under it, you can get a ticket for going too fast for road conditions.'),
  ('wa-q-signs-too-fast-b', 'wa-q-signs-too-fast', 2, 'No, not as long as you stay under the limit', false,
   'Not quite. Even under the posted limit, you can get a ticket for going too fast for road conditions like fog.'),
  ('wa-q-signs-too-fast-c', 'wa-q-signs-too-fast', 3, 'Only if you are driving through a school zone at the time', false,
   'The fog is what matters here, not the zone. Even under the posted limit, you can get a ticket for going too fast for road conditions.'),

  ('wa-q-signs-speed-warning-a', 'wa-q-signs-speed-warning', 1, 'Keep the posted speed limit, since the sign is only a warning', false,
   'Not quite. A speed warning sign recommends a speed change for a hazard such as a curve. Follow the speed warning limit.'),
  ('wa-q-signs-speed-warning-b', 'wa-q-signs-speed-warning', 2, 'Slow down only if there is a car ahead of you', false,
   'The warning is about the curve, not other cars. Adjust your speed and follow the speed warning limit.'),
  ('wa-q-signs-speed-warning-c', 'wa-q-signs-speed-warning', 3, 'Adjust your speed and follow the speed warning limit', true,
   'Right. Adjust your speed for the road, weather and traffic, and follow the speed warning limit.'),
  ('wa-q-signs-speed-warning-d', 'wa-q-signs-speed-warning', 4, 'Speed up so you get through the curve quickly', false,
   'Speeding up is the opposite of what the sign tells you. Adjust your speed and follow the speed warning limit.'),

  ('wa-q-signs-wrong-way-a', 'wa-q-signs-wrong-way', 1, 'Keep driving slowly and watch for oncoming cars', false,
   'Not quite. A Wrong Way sign means you are driving in the wrong direction. Stop and turn around right away.'),
  ('wa-q-signs-wrong-way-b', 'wa-q-signs-wrong-way', 2, 'Turn on your hazard lights and keep going', false,
   'Driving on could lead to a head-on crash. The sign tells you to stop and turn around right away.'),
  ('wa-q-signs-wrong-way-c', 'wa-q-signs-wrong-way', 3, 'Move to the right lane and continue to the next exit', false,
   'Do not keep going. The sign is meant to prevent head-on crashes, so stop and turn around right away.'),
  ('wa-q-signs-wrong-way-d', 'wa-q-signs-wrong-way', 4, 'Stop and turn around right away', true,
   'Right. You are driving in the wrong direction. Stop and turn around immediately to help prevent a head-on crash.'),

  ('wa-q-signs-no-u-turn-a', 'wa-q-signs-no-u-turn', 1, 'U-turns are not allowed here', true,
   'Right. A red circle with a red slash over a symbol means that action is not allowed.'),
  ('wa-q-signs-no-u-turn-b', 'wa-q-signs-no-u-turn', 2, 'A U-turn lane is coming up ahead', false,
   'Not quite. A red circle with a red slash means the action shown is not allowed.'),
  ('wa-q-signs-no-u-turn-c', 'wa-q-signs-no-u-turn', 3, 'U-turns are allowed only when no cars are coming', false,
   'A red circle with a red slash means the action shown, here a U-turn, is not allowed.'),
  ('wa-q-signs-no-u-turn-d', 'wa-q-signs-no-u-turn', 4, 'Only buses may make U-turns here', false,
   'Not quite. A red circle with a red slash over a U-turn symbol means U-turns are not allowed here.'),

  ('wa-q-signs-center-lane-a', 'wa-q-signs-center-lane', 1, 'To pass a slow vehicle that is driving in front of you', false,
   'Not quite. This lane is not for passing other vehicles. It is reserved for turning left.'),
  ('wa-q-signs-center-lane-b', 'wa-q-signs-center-lane', 2, 'To turn left, shared with traffic from both directions', true,
   'Right. The lane is reserved for left-turning vehicles from either direction.'),
  ('wa-q-signs-center-lane-c', 'wa-q-signs-center-lane', 3, 'As an extra through lane whenever traffic is heavy and slow', false,
   'This lane is not for through traffic. It is reserved for vehicles turning left.'),

  ('wa-q-signs-work-zone-yield-a', 'wa-q-signs-work-zone-yield', 1, 'No one, as long as you stay under the posted speed limit', false,
   'Not quite. In a work zone you must yield to construction workers, vehicles with flashing yellow lights and equipment.'),
  ('wa-q-signs-work-zone-yield-b', 'wa-q-signs-work-zone-yield', 2, 'Only to other cars in your lane', false,
   'You must also yield to highway construction workers, vehicles with flashing yellow lights and equipment in the work zone.'),
  ('wa-q-signs-work-zone-yield-c', 'wa-q-signs-work-zone-yield', 3, 'Only to pedestrians, not to the workers or their machines', false,
   'Workers and their equipment are exactly who you must yield to in a work zone, along with vehicles with flashing yellow lights.'),
  ('wa-q-signs-work-zone-yield-d', 'wa-q-signs-work-zone-yield', 4, 'Workers, vehicles with flashing yellow lights, and equipment', true,
   'Right. You must yield to highway construction workers, vehicles with flashing yellow lights, and equipment inside the work zone.'),

  ('wa-q-signs-work-zone-fines-a', 'wa-q-signs-work-zone-fines', 1, 'It is the same as anywhere else', false,
   'Not quite. Fines double for offenses in construction areas when workers are present.'),
  ('wa-q-signs-work-zone-fines-b', 'wa-q-signs-work-zone-fines', 2, 'It is cut in half', false,
   'Fines go up, not down. They double in construction areas when workers are present.'),
  ('wa-q-signs-work-zone-fines-c', 'wa-q-signs-work-zone-fines', 3, 'It is doubled', true,
   'Right. Fines double for offenses in construction areas when workers are present.'),

  ('wa-q-signs-camera-a', 'wa-q-signs-camera', 1, 'Stay in the right lane when you are not passing', false,
   'Not quite. That is what a Keep Right sign asks you to do. The guide says these cameras record images if you fail to stop at a steady red light or a railroad crossing signal, or go over the speed limit in a school zone.'),
  ('wa-q-signs-camera-b', 'wa-q-signs-camera', 2, 'Fail to stop at a steady red light', true,
   'Right. The guide says these cameras record images if you fail to stop at a steady red light. It also lists failing to stop at a railroad crossing signal and going over the speed limit in a school zone.'),
  ('wa-q-signs-camera-c', 'wa-q-signs-camera', 3, 'Drive a little below the speed limit', false,
   'Not quite. Going over the speed limit in a school zone is on the guide''s list, not driving below it. These cameras also record images if you fail to stop at a steady red light or a railroad crossing signal.'),
  ('wa-q-signs-camera-d', 'wa-q-signs-camera', 4, 'Slow down for a speed warning sign before a curve', false,
   'Not quite. That is what a speed warning sign asks you to do. The guide says these cameras record images if you fail to stop at a steady red light or a railroad crossing signal, or go over the speed limit in a school zone.'),

  ('wa-q-signs-service-a', 'wa-q-signs-service', 1, 'A destination sign', false,
   'Not quite. Destination signs show directions and distances to places like cities and airports. Service signs show services such as charging stations.'),
  ('wa-q-signs-service-b', 'wa-q-signs-service', 2, 'A recreation sign', false,
   'Recreation signs show local attractions like hiking trails. Service signs show services such as charging stations.'),
  ('wa-q-signs-service-c', 'wa-q-signs-service', 3, 'A service sign', true,
   'Right. Service signs show the location of services such as hospitals, electric vehicle charging stations and rest areas.'),
  ('wa-q-signs-service-d', 'wa-q-signs-service', 4, 'A route number sign', false,
   'Route number signs show the type of road, such as interstate or state road. Service signs show services such as charging stations.'),

  ('wa-q-signs-know-all-a', 'wa-q-signs-know-all', 1, 'All signs, including city and county signs', true,
   'Right. You are responsible for knowing all signs, including city and county signs.'),
  ('wa-q-signs-know-all-b', 'wa-q-signs-know-all', 2, 'Only the signs posted on state highways and freeways', false,
   'Not quite. You are responsible for knowing all signs, including city and county signs.'),
  ('wa-q-signs-know-all-c', 'wa-q-signs-know-all', 3, 'Only the signs shown in the driver guide', false,
   'The guide lists some, but not all, Washington signs. You are responsible for knowing all of them.'),
  ('wa-q-signs-know-all-d', 'wa-q-signs-know-all', 4, 'Only stop, yield and speed limit signs', false,
   'Those signs matter, but you are responsible for knowing all signs, including city and county signs.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
