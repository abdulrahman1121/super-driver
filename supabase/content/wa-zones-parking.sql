-- Lesson 8: Work zones, parking and carrying loads (WA Driver Guide 4.17, 4.18, 4.19, 4.20).
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
  ('wa-zones-parking', 8, 'Work zones, parking and carrying loads',
   'Slowing down for work and emergency zones, parking the right way, carrying loads and animals, and driving at ferries and beaches.',
   'WA Driver Guide 4.17, 4.18, 4.19, 4.20', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-zones-parking-zones', 'wa-zones-parking', 1, 'Work zones and emergency zones',
   E'A work zone is an area where roadwork or construction takes place. It can have lane closures, detours and moving equipment. Do your part to keep the workers safe:\n- Watch for signs, cones, barrels, large vehicles and workers.\n- Remove distractions. Turn down music and pause conversations.\n- Always slow down in a work zone, even if there are no workers. Narrower lanes and rough pavement can be hazardous.\n- Leave more following distance and be prepared to stop.\n- Use extreme caution at night, whether you see workers or not.\n- Move over when you can to give workers and construction vehicles space.\n- Follow the work zone signs until you see the End Road Work sign.\n\nAn emergency zone is set up when something on the roadside needs attention right away, like a crash, a broken-down vehicle or a person in distress. As soon as you see a roadside response vehicle with flashing lights, you must either:\n- Move over into a farther lane, or\n- Slow down to at least 10 mph below the posted speed limit. Never drive faster than 50 mph in an emergency zone.\n\nRoadside response vehicles can include tow trucks, solid waste trucks, incident response, highway maintenance and utility vehicles, law enforcement, fire trucks and ambulances.',
   'WA Driver Guide 4.17, Work zone; Emergency zone', 'draft'),
  ('wa-zones-parking-where', 'wa-zones-parking', 2, 'Where not to park',
   E'Park only in designated areas, and check for signs that ban or limit parking. You are responsible for making sure your parked vehicle is not a hazard to others.\n\nDo not park:\n- In an intersection, or on a crosswalk, sidewalk or bicycle lane\n- Within 30 feet of a traffic signal, stop sign or yield sign\n- Within 5 feet of a driveway, alley or private road\n- Within 15 feet of a fire hydrant\n- Within 20 feet of pedestrian safety zones\n- Within 75 feet of a fire station driveway on the opposite side of the street\n- On railroad tracks, or within 50 feet of a railroad crossing\n- In a construction zone\n- Next to a vehicle that is already parked (double parking)\n- On the shoulder of the freeway, unless you have an emergency\n- On a bridge or overpass, or in a tunnel or underpass\n- Facing oncoming traffic\n- More than 12 inches from the curb\n- Anywhere a sign says you cannot park\n\nPainted curbs can show other limits. A white curb means only short stops are allowed. A yellow or red curb means a loading zone or some other restriction.',
   'WA Driver Guide 4.18, General parking rules; Do not park; Signs or painted curbs', 'draft'),
  ('wa-zones-parking-spaces', 'wa-zones-parking', 3, 'Parking in a space',
   E'Angled and perpendicular spaces:\n- To enter, check traffic and signal. Move forward slowly, turning the wheel, until you reach the middle of the space. Center the vehicle between the painted lines, move to the front of the space, then stop and secure the vehicle.\n- To leave, check for traffic in all directions. Keep checking as you move straight back until your bumper clears the vehicle parked beside you. Then turn the wheel sharply the way you want to go.\n\nParallel parking:\n- To enter, check traffic and signal. Back slowly into the space, looking in the direction you are moving, and stop before you touch the bumper of the vehicle behind you. Move forward to adjust. Your vehicle must be no more than 12 inches from the curb.\n- To leave, check traffic in all directions, then back up as far as you can toward the vehicle behind you. Check traffic again, signal, and move forward slowly, steering into the lane. Make sure your front bumper will clear the vehicle ahead. If it will not, back up and adjust your steering.\n\nSpecial spaces:\n- The white-striped access aisle next to a disabled parking space must be kept clear. You can be fined for blocking it, or for parking in a reserved space without displaying the required placard.\n- It is illegal to park in an electric vehicle charging space if your vehicle is not connected to the charger.',
   'WA Driver Guide 4.18, Perpendicular and angled parking; Parallel parking; Reserved disabled parking; Electric vehicle charging station parking', 'draft'),
  ('wa-zones-parking-hills', 'wa-zones-parking', 4, 'Parking on a hill',
   E'Always set your parking brake when you park on a hill, so your vehicle does not roll into the road. Turning your wheels toward the edge of the road gives extra security in case the parking brake fails.\n\n- Facing downhill: turn the steering wheel toward the curb until the front of your front tire touches the curb. If the vehicle starts to roll, it will roll forward into the curb.\n- Facing uphill with a tall curb: turn the steering wheel away from the curb until the back of your front tire touches the curb. If the vehicle starts to roll, it will roll backward into the curb.\n- Facing uphill with a low or rounded curb: turning the wheel toward the curb might be safer, because the vehicle would roll away from the road if the parking brake failed.\n- No curb: turn the wheel and tires toward the edge of the road. If the vehicle starts to roll, it will roll away from traffic.',
   'WA Driver Guide 4.18, Parking on a hill', 'draft'),
  ('wa-zones-parking-leaving', 'wa-zones-parking', 5, 'Before you walk away',
   E'Always set your parking brake, especially on a hill.\n\nBefore you open your door, check your rearview and side-view mirrors. Then open the door with the hand that is farthest from it. This is called the Dutch Reach. It makes your body turn so you can see bicyclists coming, and it keeps the door from opening too quickly. This can protect bicyclists and keep your door from being damaged by an approaching vehicle.\n\nMake sure everyone gets out:\n- It is a crime to leave a child under 16 unattended in a parked vehicle while the motor is running.\n- It is a crime to leave a child under 12 unattended in a parked vehicle.\n- It is a crime to leave an animal unattended in a vehicle if heat, cold, lack of fresh air or lack of water could harm or kill it.\n- If no one nearby can get into the vehicle, police may remove the children or animals by any reasonable means to keep them safe.\n\nTake your keys and lock your door. Locking up helps prevent theft.',
   'WA Driver Guide 4.18, Set your parking brake; Check traffic before you open your door; Ensure adults, children, and animals properly exit the vehicle; Take your keys and lock your door', 'draft'),
  ('wa-zones-parking-loads', 'wa-zones-parking', 6, 'Towing, loads and animals',
   E'If you tow anything, like a boat, trailer or camper, you are responsible for following all manufacturers'' agreements, state laws and federal standards. Know and follow all the guidelines on weight limits, vehicle restrictions, tow cables and taillight hookups, service brakes, and licensing and documents.\n\nDriving with an unsecured load is against the law and extremely dangerous. Loose items can fly into the air, or slide, shift or fall onto the road and cause a crash. To secure a load in your vehicle or trailer:\n- Tie everything down with rope, netting or straps.\n- Tie large objects directly to your vehicle or trailer.\n- Pack only items you can carry safely and securely.\n\nWhen you carry animals:\n- It is illegal to carry an animal outside the vehicle, such as in a truck bed, without a protective harness or enclosure, so it cannot jump or fall out.\n- Carrying animals in a way that puts the animal or the public at risk is a misdemeanor.\n- A loose animal, or one riding on the driver''s lap, can distract you. It is illegal to do anything that takes your focus off driving safely.',
   'WA Driver Guide 4.19, Towing; Secure your load; Animals', 'draft'),
  ('wa-zones-parking-ferries', 'wa-zones-parking', 7, 'Ferries and beaches',
   E'Washington State Ferries are part of the state highway network, so all rules of the road apply there too.\n- Signs may direct you into a ferry lane as you approach the terminal. Pull up behind the vehicles already in line.\n- Cutting in the ferry line is a traffic offense that can lead to a fine.\n- If the holding lane is in a residential area, do not block driveways or intersections.\n- Bicyclists get priority loading on most ferries. They may ride past the waiting vehicles to a bicycle waiting area in front.\n\nDriving on ocean beaches is allowed only in Grays Harbor and Pacific counties. The beach counts as a state highway, so all driving laws apply.\n- The speed limit is 25 mph.\n- Pedestrians and bicyclists have the right-of-way at all times.\n- Enter only through marked beach approaches, and drive only on hard-packed sand.\n- Watch for signs that ban beach driving in some areas and situations.',
   'WA Driver Guide 4.20, Ferries; Beaches', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-zones-work-no-workers', 'wa-zones-parking-zones', 1,
   'You are driving through a work zone, but you do not see any workers. What should you do?',
   'WA Driver Guide 4.17, Work zone', 'draft'),
  ('wa-q-zones-move-over', 'wa-zones-parking-zones', 2,
   'A tow truck is stopped on the shoulder ahead with its lights flashing. What must you do?',
   'WA Driver Guide 4.17, Emergency zone', 'draft'),
  ('wa-q-zones-emergency-max', 'wa-zones-parking-zones', 3,
   'A police car is stopped on the shoulder with its lights flashing. The posted speed limit is 70 mph, and you slow down instead of moving over. What is the fastest you may drive past it?',
   'WA Driver Guide 4.17, Emergency zone', 'draft'),

  ('wa-q-zones-hydrant', 'wa-zones-parking-where', 1,
   'How far from a fire hydrant must you park?',
   'WA Driver Guide 4.18, Do not park', 'draft'),
  ('wa-q-zones-railroad', 'wa-zones-parking-where', 2,
   'You want to park on a street near a railroad crossing. How far from the crossing must you be?',
   'WA Driver Guide 4.18, Do not park', 'draft'),
  ('wa-q-zones-white-curb', 'wa-zones-parking-where', 3,
   'You find a parking spot next to a curb that is painted white. What does the white paint mean?',
   'WA Driver Guide 4.18, Signs or painted curbs', 'draft'),

  ('wa-q-zones-back-out', 'wa-zones-parking-spaces', 1,
   'You are backing out of an angled parking space. When should you turn your steering wheel sharply?',
   'WA Driver Guide 4.18, Exiting a perpendicular or angled parking space', 'draft'),
  ('wa-q-zones-curb-distance', 'wa-zones-parking-spaces', 2,
   'You just parallel parked next to a curb. How far from the curb can your vehicle be?',
   'WA Driver Guide 4.18, Entering a parallel parking space', 'draft'),
  ('wa-q-zones-access-aisle', 'wa-zones-parking-spaces', 3,
   'A disabled parking space has white stripes painted next to it. What is that striped area for?',
   'WA Driver Guide 4.18, Reserved disabled parking', 'draft'),

  ('wa-q-zones-downhill', 'wa-zones-parking-hills', 1,
   'You park facing downhill next to a curb. Which way should you turn your steering wheel?',
   'WA Driver Guide 4.18, Facing down the hill', 'draft'),
  ('wa-q-zones-uphill-curb', 'wa-zones-parking-hills', 2,
   'You park facing uphill next to a tall curb. Which way should you turn your steering wheel?',
   'WA Driver Guide 4.18, Facing up the hill', 'draft'),
  ('wa-q-zones-no-curb', 'wa-zones-parking-hills', 3,
   'You park on a hill on a road with no curb. Which way should you turn your wheels?',
   'WA Driver Guide 4.18, If there is no curb', 'draft'),

  ('wa-q-zones-dutch-reach', 'wa-zones-parking-leaving', 1,
   'You are parked on a busy street. After you check your mirrors, how should you open the driver''s door?',
   'WA Driver Guide 4.18, Check traffic before you open your door', 'draft'),
  ('wa-q-zones-child-motor', 'wa-zones-parking-leaving', 2,
   'Your 14-year-old brother wants to wait in the parked car while you run into a store. When would leaving him there be a crime?',
   'WA Driver Guide 4.18, Ensure adults, children, and animals properly exit the vehicle', 'draft'),
  ('wa-q-zones-animal-car', 'wa-zones-parking-leaving', 3,
   'When is it a crime to leave your dog alone in a parked car?',
   'WA Driver Guide 4.18, Ensure adults, children, and animals properly exit the vehicle', 'draft'),

  ('wa-q-zones-secure-load', 'wa-zones-parking-loads', 1,
   'You are moving boxes and a mattress in a trailer. What is the right way to carry them?',
   'WA Driver Guide 4.19, Secure your load', 'draft'),
  ('wa-q-zones-truck-bed', 'wa-zones-parking-loads', 2,
   'You want to take your dog somewhere in the open bed of a pickup truck. What does the law require?',
   'WA Driver Guide 4.19, Animals', 'draft'),

  ('wa-q-zones-ferry-line', 'wa-zones-parking-ferries', 1,
   'You reach a ferry terminal, and cars are already lined up in the ferry lane. What should you do?',
   'WA Driver Guide 4.20, Ferries', 'draft'),
  ('wa-q-zones-beach-speed', 'wa-zones-parking-ferries', 2,
   'You are driving on an ocean beach where driving is allowed. What is the speed limit?',
   'WA Driver Guide 4.20, Beaches', 'draft'),
  ('wa-q-zones-beach-walkers', 'wa-zones-parking-ferries', 3,
   'You are driving on the beach, and people are walking across the sand ahead. Who has the right-of-way?',
   'WA Driver Guide 4.20, Beaches', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
-- The correct answer's position varies on purpose (see CLAUDE.md, "Current state").
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-zones-work-no-workers-a', 'wa-q-zones-work-no-workers', 1, 'Keep your normal speed, since nobody is working', false,
   'Not quite. Always slow down in a work zone, even when there are no workers. The road itself can still be hazardous.'),
  ('wa-q-zones-work-no-workers-b', 'wa-q-zones-work-no-workers', 2, 'Slow down only if it is dark outside', false,
   'Not quite. Use extreme caution at night, but slow down in a work zone at any time of day.'),
  ('wa-q-zones-work-no-workers-c', 'wa-q-zones-work-no-workers', 3, 'Slow down anyway, since narrow lanes and rough pavement are risky', true,
   'Right. Always reduce your speed in a work zone, even if there are no workers, because narrower lanes and rough pavement can be hazardous.'),
  ('wa-q-zones-work-no-workers-d', 'wa-q-zones-work-no-workers', 4, 'Speed up so you spend less time in the zone', false,
   'Not quite. In a work zone, slow down, leave more following distance and be prepared to stop.'),

  ('wa-q-zones-move-over-a', 'wa-q-zones-move-over', 1, 'Move to a farther lane, or slow to at least 10 mph under the limit', true,
   'Right. When you see a roadside response vehicle with flashing lights, you must either move over into a farther lane or slow down to at least 10 mph below the posted limit. If you slow down, never drive faster than 50 mph in an emergency zone.'),
  ('wa-q-zones-move-over-b', 'wa-q-zones-move-over', 2, 'Keep going as usual, since only police cars need extra room', false,
   'Not quite. Tow trucks count as roadside response vehicles, just like police cars, fire trucks and ambulances.'),
  ('wa-q-zones-move-over-c', 'wa-q-zones-move-over', 3, 'Slow down only if you can see a worker outside the truck', false,
   'Not quite. The rule applies as soon as you see a roadside response vehicle with flashing lights, whether or not you see anyone.'),
  ('wa-q-zones-move-over-d', 'wa-q-zones-move-over', 4, 'Stop behind the tow truck until it drives away', false,
   'You do not need to stop. Move over into a farther lane, or slow down to at least 10 mph below the posted limit.'),

  ('wa-q-zones-emergency-max-a', 'wa-q-zones-emergency-max', 1, '60 mph', false,
   'Not quite. 60 mph is 10 mph below the limit, but never drive faster than 50 mph in an emergency zone.'),
  ('wa-q-zones-emergency-max-b', 'wa-q-zones-emergency-max', 2, '50 mph', true,
   'Right. Slow down to at least 10 mph below the posted limit, and never drive faster than 50 mph in an emergency zone.'),
  ('wa-q-zones-emergency-max-c', 'wa-q-zones-emergency-max', 3, '65 mph', false,
   'Too fast. If you do not move over, slow down to at least 10 mph below the posted limit, and never drive faster than 50 mph in an emergency zone.'),
  ('wa-q-zones-emergency-max-d', 'wa-q-zones-emergency-max', 4, '70 mph, the posted limit', false,
   'Not quite. If you do not move over, you must slow down to at least 10 mph below the posted limit, and never drive faster than 50 mph in an emergency zone.'),

  ('wa-q-zones-hydrant-a', 'wa-q-zones-hydrant', 1, 'At least 5 feet', false,
   'Too close. 5 feet is the rule for driveways, alleys and private roads. Do not park within 15 feet of a fire hydrant.'),
  ('wa-q-zones-hydrant-b', 'wa-q-zones-hydrant', 2, 'At least 30 feet', false,
   'Not quite. 30 feet is the rule for traffic signals, stop signs and yield signs. For a fire hydrant, it is 15 feet.'),
  ('wa-q-zones-hydrant-c', 'wa-q-zones-hydrant', 3, 'At least 10 feet', false,
   'Too close. Do not park within 15 feet of a fire hydrant.'),
  ('wa-q-zones-hydrant-d', 'wa-q-zones-hydrant', 4, 'At least 15 feet', true,
   'Right. Do not park within 15 feet of a fire hydrant.'),

  ('wa-q-zones-railroad-a', 'wa-q-zones-railroad', 1, 'At least 20 feet away', false,
   'Not quite. 20 feet is the rule for pedestrian safety zones. Do not park within 50 feet of a railroad crossing.'),
  ('wa-q-zones-railroad-b', 'wa-q-zones-railroad', 2, 'At least 50 feet away', true,
   'Right. Do not park on railroad tracks or within 50 feet of a railroad crossing.'),
  ('wa-q-zones-railroad-c', 'wa-q-zones-railroad', 3, 'Anywhere, as long as you are off the tracks', false,
   'Not quite. Staying off the tracks is not enough. Do not park within 50 feet of a railroad crossing.'),

  ('wa-q-zones-white-curb-a', 'wa-q-zones-white-curb', 1, 'You may park there for as long as you like', false,
   'Not quite. A white curb means only short stops are allowed.'),
  ('wa-q-zones-white-curb-b', 'wa-q-zones-white-curb', 2, 'It is a loading zone', false,
   'Not quite. A yellow or red curb marks a loading zone or another restriction. A white curb means only short stops.'),
  ('wa-q-zones-white-curb-c', 'wa-q-zones-white-curb', 3, 'Only short stops are allowed', true,
   'Right. A white curb means only short stops are permitted.'),

  ('wa-q-zones-back-out-a', 'wa-q-zones-back-out', 1, 'After your bumper clears the vehicle beside you', true,
   'Right. Check traffic, move straight back until your bumper clears the vehicle parked beside you, then turn the wheel sharply.'),
  ('wa-q-zones-back-out-b', 'wa-q-zones-back-out', 2, 'As soon as you start to back up', false,
   'Not quite. Move straight back first, until your bumper clears the vehicle parked beside you.'),
  ('wa-q-zones-back-out-c', 'wa-q-zones-back-out', 3, 'Before you check for traffic behind you', false,
   'Not quite. Always check for traffic in all directions first, and keep checking as you back out.'),

  ('wa-q-zones-curb-distance-a', 'wa-q-zones-curb-distance', 1, 'No more than 24 inches', false,
   'Too far. Your vehicle must be no more than 12 inches from the curb.'),
  ('wa-q-zones-curb-distance-b', 'wa-q-zones-curb-distance', 2, 'No more than 3 feet', false,
   'Much too far. Your vehicle must be no more than 12 inches from the curb.'),
  ('wa-q-zones-curb-distance-c', 'wa-q-zones-curb-distance', 3, 'No more than 18 inches', false,
   'Close, but too far. Your vehicle must be no more than 12 inches from the curb.'),
  ('wa-q-zones-curb-distance-d', 'wa-q-zones-curb-distance', 4, 'No more than 12 inches', true,
   'Right. Move forward to adjust if you need to, so your vehicle is no more than 12 inches from the curb.'),

  ('wa-q-zones-access-aisle-a', 'wa-q-zones-access-aisle', 1, 'Extra parking for a motorcycle or small car', false,
   'Not quite. The striped area is an access aisle, and it must be kept clear.'),
  ('wa-q-zones-access-aisle-b', 'wa-q-zones-access-aisle', 2, 'An access aisle that must be kept clear', true,
   'Right. The white stripes next to a reserved space are an access aisle. You can be fined for blocking it.'),
  ('wa-q-zones-access-aisle-c', 'wa-q-zones-access-aisle', 3, 'A short-stop area, like a white curb', false,
   'Not quite. The striped area is an access aisle. It must be kept clear, and you can be fined for blocking it.'),
  ('wa-q-zones-access-aisle-d', 'wa-q-zones-access-aisle', 4, 'Overflow parking for when the lot is full', false,
   'Not quite. Even when the lot is full, the access aisle must be kept clear.'),

  ('wa-q-zones-downhill-a', 'wa-q-zones-downhill', 1, 'Away from the curb', false,
   'Not quite. Facing downhill, turn toward the curb until the front of your front tire touches it.'),
  ('wa-q-zones-downhill-b', 'wa-q-zones-downhill', 2, 'Keep the wheels straight', false,
   'Not quite. Turn toward the curb, so if the vehicle starts to roll, it rolls forward into the curb.'),
  ('wa-q-zones-downhill-c', 'wa-q-zones-downhill', 3, 'Toward the curb', true,
   'Right. Turn until the front of your front tire touches the curb. If the vehicle starts to roll, it will roll forward into the curb.'),

  ('wa-q-zones-uphill-curb-a', 'wa-q-zones-uphill-curb', 1, 'Toward the curb, so the front of the tire touches it', false,
   'Not quite. That is how you park facing downhill. Facing uphill next to a tall curb, turn away from the curb.'),
  ('wa-q-zones-uphill-curb-b', 'wa-q-zones-uphill-curb', 2, 'Away from the curb, so the back of the tire touches it', true,
   'Right. If the vehicle starts to roll, it will roll backward into the curb.'),
  ('wa-q-zones-uphill-curb-c', 'wa-q-zones-uphill-curb', 3, 'Straight ahead, with the parking brake set', false,
   'Always set the brake, but also turn your wheels. Facing uphill next to a tall curb, turn away from the curb so the vehicle would roll back into it.'),

  ('wa-q-zones-no-curb-a', 'wa-q-zones-no-curb', 1, 'Toward the edge of the road', true,
   'Right. If your vehicle starts to roll, it will roll away from traffic.'),
  ('wa-q-zones-no-curb-b', 'wa-q-zones-no-curb', 2, 'Toward the middle of the road', false,
   'Not quite. Turn your wheels toward the edge of the road, so a rolling vehicle would move away from traffic.'),
  ('wa-q-zones-no-curb-c', 'wa-q-zones-no-curb', 3, 'Keep them pointed straight ahead', false,
   'Not quite. Turning your wheels toward the edge of the road gives extra security in case the parking brake fails.'),
  ('wa-q-zones-no-curb-d', 'wa-q-zones-no-curb', 4, 'It does not matter if the parking brake is on', false,
   'Always set the parking brake, and also turn your wheels toward the edge of the road in case the brake fails.'),

  ('wa-q-zones-dutch-reach-a', 'wa-q-zones-dutch-reach', 1, 'With the hand closest to the door', false,
   'Not quite. Use the hand farthest from the door. It turns your body so you can see bicyclists coming.'),
  ('wa-q-zones-dutch-reach-b', 'wa-q-zones-dutch-reach', 2, 'Quickly, so you are out of the way sooner', false,
   'Not quite. The Dutch Reach keeps the door from opening too quickly, which protects bicyclists and your door.'),
  ('wa-q-zones-dutch-reach-c', 'wa-q-zones-dutch-reach', 3, 'With the hand farthest from the door', true,
   'Right. This is the Dutch Reach. It turns your body so you can see approaching bicyclists, and it keeps the door from opening too quickly.'),
  ('wa-q-zones-dutch-reach-d', 'wa-q-zones-dutch-reach', 4, 'Without looking back, since you checked the mirrors', false,
   'Not quite. The Dutch Reach is meant to turn your body so you can see approaching bicyclists before you open the door.'),

  ('wa-q-zones-child-motor-a', 'wa-q-zones-child-motor', 1, 'Never, because he is older than 12', false,
   'Not quite. Being over 12 is not enough if the motor is running. Leaving a child under 16 unattended with the motor running is a crime.'),
  ('wa-q-zones-child-motor-b', 'wa-q-zones-child-motor', 2, 'Always, because he is under 18', false,
   'Not quite. The age limits are under 12 in any parked vehicle, and under 16 while the motor is running.'),
  ('wa-q-zones-child-motor-c', 'wa-q-zones-child-motor', 3, 'Only if it is hot outside', false,
   'Not quite. For a 14-year-old, the rule is about the motor. Leaving a child under 16 unattended with the motor running is a crime.'),
  ('wa-q-zones-child-motor-d', 'wa-q-zones-child-motor', 4, 'If you leave the motor running', true,
   'Right. It is a crime to leave a child under 16 unattended in a parked vehicle while the motor is running.'),

  ('wa-q-zones-animal-car-a', 'wa-q-zones-animal-car', 1, 'If heat, cold, lack of fresh air or water could harm it', true,
   'Right. It is a crime to leave an animal unattended if heat, cold, lack of fresh air or lack of water could harm or kill it.'),
  ('wa-q-zones-animal-car-b', 'wa-q-zones-animal-car', 2, 'Only if you are gone for more than an hour', false,
   'Not quite. The rule is about danger to the animal, not a set amount of time.'),
  ('wa-q-zones-animal-car-c', 'wa-q-zones-animal-car', 3, 'Only if you leave the motor running', false,
   'Not quite. The motor rule is for children. For animals, what matters is whether heat, cold, lack of fresh air or lack of water could harm them.'),

  ('wa-q-zones-secure-load-a', 'wa-q-zones-secure-load', 1, 'Stack them tightly so their weight holds them down', false,
   'Not quite. Unsecured items can still slide, shift or fall onto the road. Tie everything down with rope, netting or straps.'),
  ('wa-q-zones-secure-load-b', 'wa-q-zones-secure-load', 2, 'Drive slowly so nothing blows off', false,
   'Not quite. Driving with an unsecured load is against the law. Tie everything down, and tie large items directly to the trailer.'),
  ('wa-q-zones-secure-load-c', 'wa-q-zones-secure-load', 3, 'Fill the trailer as full as you can so nothing shifts', false,
   'Not quite. Pack only items you can carry safely and securely, and tie them down.'),
  ('wa-q-zones-secure-load-d', 'wa-q-zones-secure-load', 4, 'Tie everything down with rope, netting or straps', true,
   'Right. Tie everything down, and tie large objects like the mattress directly to the trailer.'),

  ('wa-q-zones-truck-bed-a', 'wa-q-zones-truck-bed', 1, 'Nothing, as long as you drive slowly', false,
   'Not quite. It is illegal to carry an animal outside the vehicle without a protective harness or enclosure.'),
  ('wa-q-zones-truck-bed-b', 'wa-q-zones-truck-bed', 2, 'Only that the tailgate is closed', false,
   'Not quite. A closed tailgate is not enough. The dog needs a protective harness or enclosure so it cannot jump or fall out.'),
  ('wa-q-zones-truck-bed-c', 'wa-q-zones-truck-bed', 3, 'A protective harness or enclosure so it cannot fall out', true,
   'Right. It is illegal to carry an animal outside the vehicle without a protective harness or enclosure, so it cannot jump or fall out.'),
  ('wa-q-zones-truck-bed-d', 'wa-q-zones-truck-bed', 4, 'Nothing, if the dog is well trained', false,
   'Not quite. Training does not change the law. The dog needs a protective harness or enclosure.'),

  ('wa-q-zones-ferry-line-a', 'wa-q-zones-ferry-line', 1, 'Merge in near the front if you see a gap', false,
   'Not quite. Ferry line-cutting is a traffic offense that can lead to a fine.'),
  ('wa-q-zones-ferry-line-b', 'wa-q-zones-ferry-line', 2, 'Pull up behind the last vehicle in line', true,
   'Right. Pull up behind the vehicles already in line. Ferries are part of the highway network, so the rules of the road apply.'),
  ('wa-q-zones-ferry-line-c', 'wa-q-zones-ferry-line', 3, 'Wait in a nearby driveway until the line moves', false,
   'Not quite. If the holding lane is in a residential area, do not block driveways or intersections.'),
  ('wa-q-zones-ferry-line-d', 'wa-q-zones-ferry-line', 4, 'Drive ahead to the waiting area at the front', false,
   'Not quite. The waiting area in front is for bicyclists, who get priority loading on most ferries.'),

  ('wa-q-zones-beach-speed-a', 'wa-q-zones-beach-speed', 1, '15 mph', false,
   'Not quite. The speed limit on the beach is 25 mph.'),
  ('wa-q-zones-beach-speed-b', 'wa-q-zones-beach-speed', 2, '35 mph', false,
   'Too fast. The speed limit on the beach is 25 mph.'),
  ('wa-q-zones-beach-speed-c', 'wa-q-zones-beach-speed', 3, '25 mph', true,
   'Right. The beach counts as a state highway, so all driving laws apply, and the speed limit is 25 mph.'),
  ('wa-q-zones-beach-speed-d', 'wa-q-zones-beach-speed', 4, 'There is no speed limit on the sand', false,
   'Not quite. The beach is considered a state highway, so driving laws apply. The speed limit is 25 mph.'),

  ('wa-q-zones-beach-walkers-a', 'wa-q-zones-beach-walkers', 1, 'You do, because the beach counts as a highway', false,
   'Not quite. The beach is a state highway, but pedestrians and bicyclists have the right-of-way there at all times.'),
  ('wa-q-zones-beach-walkers-b', 'wa-q-zones-beach-walkers', 2, 'The people walking, at all times', true,
   'Right. On the beach, pedestrians and bicyclists have the right-of-way at all times.'),
  ('wa-q-zones-beach-walkers-c', 'wa-q-zones-beach-walkers', 3, 'Whoever reached that spot first', false,
   'Not quite. Arriving first does not matter here. Pedestrians and bicyclists always have the right-of-way on the beach.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
