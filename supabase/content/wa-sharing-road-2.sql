-- Lesson 7: Sharing the road with other vehicles (WA Driver Guide 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9).
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
  ('wa-sharing-road-2', 7, 'Sharing the road with other vehicles',
   'How to stay safe around trucks, motorcycles, bikes, trains, buses, farm equipment and emergency vehicles.',
   'WA Driver Guide 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-sharing-road-2-large-vehicles', 'wa-sharing-road-2', 1, 'Trucks and other large vehicles',
   E'Large trucks and buses have special limitations, so you need more time and space when you drive around them. Pay attention to these:\n- Following: leave enough distance that you have a wide view of the road ahead.\n- Blind zones: there are blind zones on each side of a large vehicle. If you cannot see the driver''s mirrors, the driver cannot see you. Avoid driving alongside a large vehicle for too long.\n- Stopping: large vehicles cannot stop as quickly as smaller vehicles. A loaded truck with properly adjusted brakes, going 55 mph, needs 450 feet to come to a complete stop. Cutting in front of one without enough space is dangerous for everyone.\n- Merging: before you merge in front of a large vehicle, wait until you can clearly see both of its headlights in your rearview mirror.\n- Turning: a large vehicle may need more than 1 lane to turn, and 2 lanes in a roundabout. Do not pass it while the driver is turning. Wait until the turn is complete.\n- Hazardous materials: when possible, avoid driving near vehicles with hazardous materials signs.\n- Steep hills: large vehicles go slowly up and down steep roads. Expect slow vehicles in the right lane.\n\nBe careful near snowplows. The snow they throw off the road can make it hard to see if you follow too closely.',
   'WA Driver Guide 4.4', 'draft'),
  ('wa-sharing-road-2-motorcycles', 'wa-sharing-road-2', 2, 'Motorcycles',
   E'Motorcyclists have the same rights and responsibilities as other road users and obey the same traffic laws. But motorcycles are small, so riders are more vulnerable and harder to see. Make it a habit to scan for motorcycles.\n\n- Following: leave a lot of room so you can stop safely in an emergency. Leave even more room when it is raining or the road is slick.\n- Lanes: riders change position within their lane to see, be seen and avoid objects. A motorcyclist is entitled to the same lane width as any other vehicle. Never move into the same lane alongside a motorcycle, even if the lane is wide and the rider is far to one side.\n- Turning: motorcycles are often hidden in blind zones, so do an over-the-shoulder check. For example, before turning right, look left, look right, then look left again. Drivers can also misjudge how fast an oncoming motorcycle is going.\n- Road surface: gravel, debris, potholes and even manhole covers can force a rider to change speed or lane position. Expect it.\n- Lights: give riders plenty of time to notice your turn signals and brake lights. A rider may slow down with the throttle instead of the brakes, so no brake light shows. Some motorcycle turn signals do not turn off by themselves.',
   'WA Driver Guide 4.5', 'draft'),
  ('wa-sharing-road-2-bicyclists', 'wa-sharing-road-2', 3, 'Passing bicyclists and bike lanes',
   E'Bicyclists have the same rights and duties as drivers. Bikes are small and less visible, so riders are at greater risk of being hit and seriously hurt or killed.\n\n- When turning a corner or into a driveway, watch for bicyclists in the crosswalk or on the sidewalk.\n- At intersections, yield to bicyclists as you would to a vehicle.\n- You cannot share a lane with a bicyclist. They may legally use the full lane.\n- When you drive behind a bicyclist, leave at least 3 feet of space.\n\nTo pass a bicyclist:\n- Wait until it is safe for you and the rider.\n- With 2 lanes going your direction, move over 1 full lane. With 1 lane each way, move into the other lane only when there is no oncoming traffic.\n- Pass slowly on the left, with at least 3 feet between the rider and the widest part of your vehicle.\n- Make sure you are clear of the rider before moving back.\n- Let a bicyclist clear the intersection before you turn. Do not pass one just before a right turn.\n\nBike lanes are often painted green, with solid white lines and a bicycle symbol. Drive in one only to turn, or to cross it to park near the curb. After you park, look carefully in all directions for bicyclists before opening your door.',
   'WA Driver Guide 4.6', 'draft'),
  ('wa-sharing-road-2-rail-crossings', 'wa-sharing-road-2', 4, 'Railroad crossings',
   E'Cross railroad tracks only at designated crossings. Look for safety signs, flashing lights and crossing gates.\n\nTrains always have the right-of-way. They are heavy and cannot stop quickly, even at low speeds. It can take up to a mile for a train to come to a full stop.\n\nWhen lights are flashing and bells are ringing at a crossing, you must stop, whether the gate is down or not. Never drive around the gate.\n\nStop between 15 and 50 feet from the nearest rail when:\n- The signal is flashing.\n- The crossing gate is lowering or already down.\n- A flagger signals you to stop.\n- A train is so close that it is an immediate hazard.\n- You hear a train''s warning horn.\n- A stop sign is posted.\n\nYou can go when the red lights stop flashing and all other warning signs turn off.\n\nNever try to beat a train across the tracks. Trust the signals even if you do not see a train. Trains might be closer, quieter and faster than they look, and they can come from either direction on any track.',
   'WA Driver Guide 4.7', 'draft'),
  ('wa-sharing-road-2-rail-safety', 'wa-sharing-road-2', 5, 'Trouble at the tracks and light rail',
   E'Never stop on railroad tracks. If your vehicle gets stuck at a crossing, get everyone out right away.\n\nIf anything is on or close to the tracks, call the number on the blue and white Emergency Notification System sign. Give the dispatcher the crossing ID number, your location and the details of what is happening. If there is no sign, dial 911.\n\nSound Transit''s Link light rail is an important part of Washington''s transportation network. When you drive near light rail stations and lines:\n- Pay attention to all signs and road markings.\n- Watch for approaching light rail trains.\n- Leave at least 1 car length, or more, between your vehicle and a light rail train.\n- Never stop, park or leave your car on the tracks. Park with plenty of room for trains to get around you.',
   'WA Driver Guide 4.7', 'draft'),
  ('wa-sharing-road-2-yield-slow', 'wa-sharing-road-2', 6, 'Transit buses, farm vehicles and emergency vehicles',
   E'Yield to a transit bus going the same direction as you when it has signaled and is pulling back onto the road.\n\nFarm vehicles designed to go 25 mph or less have a triangle sign or emblem on the back. When you see a slow-moving vehicle, be patient and slow down. Give it plenty of space and use caution when passing:\n- If there are 2 lanes going your direction, move over 1 full lane to pass.\n- If there is only 1 lane each way, look for oncoming traffic and pass carefully.\n- Leave at least 3 feet between the widest part of your vehicle and the farm vehicle.\n\nFire trucks, ambulances and police cars using their lights, sirens or both always have the right-of-way. As soon as you see or hear them:\n- Pull to the right side of the road and stop.\n- Wait until the emergency vehicle has passed.\n- Signal and move back into traffic in the same order you were driving before.',
   'WA Driver Guide 4.3, 4.8, 4.9', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-share-truck-mirrors', 'wa-sharing-road-2-large-vehicles', 1,
   'You are driving beside a large truck and you cannot see the driver''s mirrors. What does that mean?',
   'WA Driver Guide 4.4, Blind zones', 'draft'),
  ('wa-q-share-truck-merge', 'wa-sharing-road-2-large-vehicles', 2,
   'You are merging into traffic ahead of a large truck. When is it safe to move in front of it?',
   'WA Driver Guide 4.4, Merging', 'draft'),
  ('wa-q-share-truck-turn', 'wa-sharing-road-2-large-vehicles', 3,
   'A large truck ahead of you is making a turn and is using more than one lane. What should you do?',
   'WA Driver Guide 4.4, Turning space', 'draft'),

  ('wa-q-share-moto-lane', 'wa-sharing-road-2-motorcycles', 1,
   'A motorcycle is riding far to one side of a wide lane. Can you move into that lane beside it?',
   'WA Driver Guide 4.5, Lanes', 'draft'),
  ('wa-q-share-moto-rain', 'wa-sharing-road-2-motorcycles', 2,
   'You are following a motorcycle and it starts to rain. What should you do?',
   'WA Driver Guide 4.5, Following', 'draft'),
  ('wa-q-share-moto-signal', 'wa-sharing-road-2-motorcycles', 3,
   'A motorcycle''s turn signal has been blinking for a while, but the rider has not turned. What should you do?',
   'WA Driver Guide 4.5, Motorcyclists'' lights', 'draft'),

  ('wa-q-share-bike-two-lanes', 'wa-sharing-road-2-bicyclists', 1,
   'You want to pass a bicyclist on a road with 2 lanes going your direction. How should you pass?',
   'WA Driver Guide 4.6, Passing a bicyclist', 'draft'),
  ('wa-q-share-bike-right-turn', 'wa-sharing-road-2-bicyclists', 2,
   'You plan to turn right at the next corner. A bicyclist is riding ahead of you in the same direction. What should you do?',
   'WA Driver Guide 4.6, Passing a bicyclist', 'draft'),
  ('wa-q-share-bike-lane-use', 'wa-sharing-road-2-bicyclists', 3,
   'When are you allowed to drive in a bike lane?',
   'WA Driver Guide 4.6, Bike lanes', 'draft'),

  ('wa-q-share-rail-gate-up', 'wa-sharing-road-2-rail-crossings', 1,
   'At a railroad crossing, the lights are flashing and the bells are ringing, but the gate is still up. What should you do?',
   'WA Driver Guide 4.7, Sharing the road with trains', 'draft'),
  ('wa-q-share-rail-stop-distance', 'wa-sharing-road-2-rail-crossings', 2,
   'You need to stop at a railroad crossing because the signal is flashing. Where should you stop?',
   'WA Driver Guide 4.7, Sharing the road with trains', 'draft'),
  ('wa-q-share-train-stopping', 'wa-sharing-road-2-rail-crossings', 3,
   'Trains are heavy and cannot stop quickly. How much distance can a train need to come to a full stop?',
   'WA Driver Guide 4.7, Sharing the road with trains', 'draft'),

  ('wa-q-share-rail-stuck', 'wa-sharing-road-2-rail-safety', 1,
   'Your car gets stuck on the tracks at a railroad crossing. What should you do?',
   'WA Driver Guide 4.7, Important safety reminders', 'draft'),
  ('wa-q-share-rail-ens', 'wa-sharing-road-2-rail-safety', 2,
   'You see something blocking the railroad tracks at a crossing. Who should you call?',
   'WA Driver Guide 4.7, When to call for help', 'draft'),
  ('wa-q-share-light-rail-space', 'wa-sharing-road-2-rail-safety', 3,
   'You are driving near a light rail line. How much space should you leave between your vehicle and a light rail train?',
   'WA Driver Guide 4.7, Light rail', 'draft'),

  ('wa-q-share-transit-yield', 'wa-sharing-road-2-yield-slow', 1,
   'A transit bus going the same direction as you has signaled and is pulling back onto the road from a stop. What should you do?',
   'WA Driver Guide 4.3', 'draft'),
  ('wa-q-share-farm-emblem', 'wa-sharing-road-2-yield-slow', 2,
   'A farm vehicle ahead of you has a triangle sign on the back. What does the sign tell you?',
   'WA Driver Guide 4.8', 'draft'),
  ('wa-q-share-emergency', 'wa-sharing-road-2-yield-slow', 3,
   'An ambulance with its lights and siren on is coming up behind you. What should you do?',
   'WA Driver Guide 4.9', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-share-truck-mirrors-a', 'wa-q-share-truck-mirrors', 1, 'The driver can see you in the side mirror', false,
   'Not quite. It is the other way around: if you cannot see the driver''s mirrors, the driver cannot see you.'),
  ('wa-q-share-truck-mirrors-b', 'wa-q-share-truck-mirrors', 2, 'The truck is about to change lanes', false,
   'Not quite. Not being able to see the mirrors does not tell you that. It means the driver cannot see you.'),
  ('wa-q-share-truck-mirrors-c', 'wa-q-share-truck-mirrors', 3, 'The driver cannot see you', true,
   'Right. If you cannot see a large vehicle driver''s mirrors, the driver cannot see you. Avoid driving alongside large vehicles for too long.'),
  ('wa-q-share-truck-mirrors-d', 'wa-q-share-truck-mirrors', 4, 'You are at a safe distance from the truck', false,
   'Not quite. You are in a blind zone beside the truck, where the driver cannot see you. Avoid staying there.'),

  ('wa-q-share-truck-merge-a', 'wa-q-share-truck-merge', 1, 'As soon as your car is past its front bumper', false,
   'That is too close. Large vehicles cannot stop quickly. Wait until you can clearly see both of its headlights in your rearview mirror.'),
  ('wa-q-share-truck-merge-b', 'wa-q-share-truck-merge', 2, 'When you can clearly see both of its headlights in your rearview mirror', true,
   'Right. Wait until you can clearly see both of the truck''s headlights in your rearview mirror before merging in front of it.'),
  ('wa-q-share-truck-merge-c', 'wa-q-share-truck-merge', 3, 'When one of its headlights shows in your side mirror', false,
   'Not quite. You need to clearly see both headlights, and in your rearview mirror.'),
  ('wa-q-share-truck-merge-d', 'wa-q-share-truck-merge', 4, 'When the truck driver slows down to let you in', false,
   'Do not count on that. Large vehicles cannot stop as quickly as cars. Wait until you can see both headlights in your rearview mirror.'),

  ('wa-q-share-truck-turn-a', 'wa-q-share-truck-turn', 1, 'Wait until it finishes the turn before moving ahead', true,
   'Right. Large vehicles may need more than 1 lane to turn. Be patient and wait until the turn is complete.'),
  ('wa-q-share-truck-turn-b', 'wa-q-share-truck-turn', 2, 'Pass it quickly on the side it left open', false,
   'Not quite. Passing a large vehicle while the driver is turning is a frequent cause of collisions. Wait until the turn is complete.'),
  ('wa-q-share-truck-turn-c', 'wa-q-share-truck-turn', 3, 'Pull up beside it so you are ready to go', false,
   'Not quite. Be patient and wait until the turn is complete before moving ahead. The truck may need more than 1 lane to turn, and there are blind zones on each side of it.'),

  ('wa-q-share-moto-lane-a', 'wa-q-share-moto-lane', 1, 'Yes, if the lane is wide enough for both of you', false,
   'Not quite. A motorcyclist is entitled to the same lane width as any other vehicle, even in a wide lane.'),
  ('wa-q-share-moto-lane-b', 'wa-q-share-moto-lane', 2, 'Yes, if you stay at least 3 feet from the rider', false,
   'Not quite. Distance does not make it OK. Never move into the same lane alongside a motorcyclist.'),
  ('wa-q-share-moto-lane-c', 'wa-q-share-moto-lane', 3, 'No, never move into the same lane beside it', true,
   'Right. Never move into the same lane alongside a motorcyclist, even if the lane is wide and the rider is far to one side.'),

  ('wa-q-share-moto-rain-a', 'wa-q-share-moto-rain', 1, 'Keep the same distance you would in dry weather', false,
   'Not quite. Rain and slippery roads can be serious problems for motorcyclists. Leave even more room.'),
  ('wa-q-share-moto-rain-b', 'wa-q-share-moto-rain', 2, 'Move closer so the rider can see your headlights', false,
   'Following closer is dangerous. You need enough room to stop safely in an emergency.'),
  ('wa-q-share-moto-rain-c', 'wa-q-share-moto-rain', 3, 'Pass the motorcycle as soon as you can', false,
   'Not quite. The safe step is to leave even more following room when it rains, not to rush past.'),
  ('wa-q-share-moto-rain-d', 'wa-q-share-moto-rain', 4, 'Leave even more following room than usual', true,
   'Right. Allow even more following room when it is raining or the road surface is slick.'),

  ('wa-q-share-moto-signal-a', 'wa-q-share-moto-signal', 1, 'Stay alert, because the signal may not turn off by itself', true,
   'Right. Some motorcycles have turn signals that do not turn off automatically. Stay alert and pay careful attention.'),
  ('wa-q-share-moto-signal-b', 'wa-q-share-moto-signal', 2, 'Pull out in front of it, since it is about to turn', false,
   'Not quite. Some motorcycle signals do not turn off by themselves, so the rider may not be turning at all.'),
  ('wa-q-share-moto-signal-c', 'wa-q-share-moto-signal', 3, 'Pass it quickly before it turns', false,
   'Not quite. The rider may not be turning at all. Stay alert and pay careful attention when driving alongside a motorcycle.'),
  ('wa-q-share-moto-signal-d', 'wa-q-share-moto-signal', 4, 'Stop watching it, since the rider is clearly not turning', false,
   'Not quite. You cannot tell what the rider will do from the signal alone. Stay alert and pay careful attention when driving alongside a motorcycle.'),

  ('wa-q-share-bike-two-lanes-a', 'wa-q-share-bike-two-lanes', 1, 'Stay in your lane and squeeze past slowly', false,
   'Not quite. You cannot share a lane with a bicyclist. Move over 1 full lane to pass.'),
  ('wa-q-share-bike-two-lanes-b', 'wa-q-share-bike-two-lanes', 2, 'Move over 1 full lane into the other lane', true,
   'Right. If there are 2 lanes going your direction, move over 1 full lane and pass slowly on the bicyclist''s left side.'),
  ('wa-q-share-bike-two-lanes-c', 'wa-q-share-bike-two-lanes', 3, 'Drive on the lane line so you use part of each lane', false,
   'Not quite. Part of a lane is not enough. Move over 1 full lane.'),
  ('wa-q-share-bike-two-lanes-d', 'wa-q-share-bike-two-lanes', 4, 'Pass on the bicyclist''s right side', false,
   'Not quite. Pass slowly on the bicyclist''s left side, after moving over 1 full lane.'),

  ('wa-q-share-bike-right-turn-a', 'wa-q-share-bike-right-turn', 1, 'Pass the bicyclist, then turn right in front of them', false,
   'Not quite. Do not pass a bicyclist just before a right turn. Let them clear the intersection first.'),
  ('wa-q-share-bike-right-turn-b', 'wa-q-share-bike-right-turn', 2, 'Stay behind and let them clear the intersection first', true,
   'Right. Let the bicyclist clear the intersection before you turn, and do not pass them just before a right turn.'),
  ('wa-q-share-bike-right-turn-c', 'wa-q-share-bike-right-turn', 3, 'Honk so the bicyclist knows to stop for you', false,
   'Not quite. Let the bicyclist clear the intersection before you turn. At intersections, yield to bicyclists as you would to a vehicle.'),

  ('wa-q-share-bike-lane-use-a', 'wa-q-share-bike-lane-use', 1, 'Any time no bicyclist is using it', false,
   'Not quite. An empty bike lane is still not for driving. Use it only to turn, or to cross it to park near the curb.'),
  ('wa-q-share-bike-lane-use-b', 'wa-q-share-bike-lane-use', 2, 'When the traffic in your lane is moving slowly', false,
   'Slow traffic is not a reason to use the bike lane. Use it only to turn, or to cross it to park near the curb.'),
  ('wa-q-share-bike-lane-use-c', 'wa-q-share-bike-lane-use', 3, 'To get around a car that is waiting to turn', false,
   'Not quite. Getting around other cars is not an allowed use. Drive in a bike lane only to turn, or to cross it to park.'),
  ('wa-q-share-bike-lane-use-d', 'wa-q-share-bike-lane-use', 4, 'Only to turn, or to cross it to park near the curb', true,
   'Right. Drive in bicycle lanes only when turning or crossing the lane to park near the curb.'),

  ('wa-q-share-rail-gate-up-a', 'wa-q-share-rail-gate-up', 1, 'Stop, even though the gate is not down', true,
   'Right. When lights are flashing and bells are ringing at a crossing, you must stop, whether the gate is down or not.'),
  ('wa-q-share-rail-gate-up-b', 'wa-q-share-rail-gate-up', 2, 'Cross quickly before the gate comes down', false,
   'Not quite. Never try to beat a train across the tracks. As soon as the warnings start, stop.'),
  ('wa-q-share-rail-gate-up-c', 'wa-q-share-rail-gate-up', 3, 'Slow down and cross if you do not see a train', false,
   'Not quite. You must stop. Trust the signals even if you do not see a train. Trains might be closer, quieter and faster than they appear.'),

  ('wa-q-share-rail-stop-distance-a', 'wa-q-share-rail-stop-distance', 1, 'Between 5 and 10 feet from the nearest rail', false,
   'That is too close. Stop between 15 and 50 feet from the nearest rail.'),
  ('wa-q-share-rail-stop-distance-b', 'wa-q-share-rail-stop-distance', 2, 'Right at the edge of the nearest rail', false,
   'Not quite. Stop back from the tracks, between 15 and 50 feet from the nearest rail.'),
  ('wa-q-share-rail-stop-distance-c', 'wa-q-share-rail-stop-distance', 3, 'Between 15 and 50 feet from the nearest rail', true,
   'Right. When the signal is flashing, stop between 15 and 50 feet away from the nearest rail.'),
  ('wa-q-share-rail-stop-distance-d', 'wa-q-share-rail-stop-distance', 4, 'Between 60 and 100 feet from the nearest rail', false,
   'Not quite. Stop between 15 and 50 feet from the nearest rail.'),

  ('wa-q-share-train-stopping-a', 'wa-q-share-train-stopping', 1, 'Up to 50 feet', false,
   'Much farther. Trains are heavy and cannot stop quickly. It can take up to a mile.'),
  ('wa-q-share-train-stopping-b', 'wa-q-share-train-stopping', 2, 'Up to 100 feet', false,
   'Much farther. Even at low speeds a train cannot stop quickly. It can take up to a mile.'),
  ('wa-q-share-train-stopping-c', 'wa-q-share-train-stopping', 3, 'Up to 450 feet', false,
   'Not quite. 450 feet is how far a loaded truck with properly adjusted brakes, going 55 mph, needs to stop. A train can take up to a mile.'),
  ('wa-q-share-train-stopping-d', 'wa-q-share-train-stopping', 4, 'Up to a mile', true,
   'Right. Trains are heavy and cannot stop quickly, even at low speeds. It can take up to a mile for a train to stop.'),

  ('wa-q-share-rail-stuck-a', 'wa-q-share-rail-stuck', 1, 'Stay inside and keep trying to start the car', false,
   'Not quite. Do not stay in the vehicle. If it gets stuck at a crossing, get everyone out immediately.'),
  ('wa-q-share-rail-stuck-b', 'wa-q-share-rail-stuck', 2, 'Get everyone out of the vehicle right away', true,
   'Right. If your vehicle gets stuck at a crossing, get everyone out immediately.'),
  ('wa-q-share-rail-stuck-c', 'wa-q-share-rail-stuck', 3, 'Turn on your hazard lights and wait inside', false,
   'Waiting inside is not safe. Get everyone out of the vehicle immediately.'),
  ('wa-q-share-rail-stuck-d', 'wa-q-share-rail-stuck', 4, 'Stay in the car and call for a tow truck', false,
   'Not quite. Get everyone out of the vehicle first, right away.'),

  ('wa-q-share-rail-ens-a', 'wa-q-share-rail-ens', 1, 'No one, since the train will see it and stop in time', false,
   'Not quite. Trains cannot stop quickly. It can take up to a mile, so report it.'),
  ('wa-q-share-rail-ens-b', 'wa-q-share-rail-ens', 2, 'A tow company, so it can clear the tracks', false,
   'Not quite. Call the number on the blue and white Emergency Notification System sign, or 911 if there is no sign.'),
  ('wa-q-share-rail-ens-c', 'wa-q-share-rail-ens', 3, 'The number on the blue and white Emergency Notification System sign', true,
   'Right. Call that number and give the dispatcher the crossing ID number and your location. If there is no sign, dial 911.'),

  ('wa-q-share-light-rail-space-a', 'wa-q-share-light-rail-space', 1, 'At least 1 car length, or more', true,
   'Right. Leave at least 1 car length, or more, between your vehicle and light rail trains.'),
  ('wa-q-share-light-rail-space-b', 'wa-q-share-light-rail-space', 2, 'At least 3 feet', false,
   'Not quite. That is too little. Leave at least 1 car length, or more, between you and a light rail train.'),
  ('wa-q-share-light-rail-space-c', 'wa-q-share-light-rail-space', 3, 'At least half a car length', false,
   'That is too close. Leave at least 1 car length, or more.'),
  ('wa-q-share-light-rail-space-d', 'wa-q-share-light-rail-space', 4, 'None, if the train is stopped at a station', false,
   'Not quite. Leave at least 1 car length, or more, and never stop or park on the tracks.'),

  ('wa-q-share-transit-yield-a', 'wa-q-share-transit-yield', 1, 'Speed up to get past before it pulls out', false,
   'Not quite. You must yield to a transit bus that has signaled and is pulling back onto the road.'),
  ('wa-q-share-transit-yield-b', 'wa-q-share-transit-yield', 2, 'Yield and let the bus pull back onto the road', true,
   'Right. Yield to a transit bus going your direction that has signaled and is pulling back onto the road.'),
  ('wa-q-share-transit-yield-c', 'wa-q-share-transit-yield', 3, 'Keep going, because the bus must wait for a gap', false,
   'Not quite. Once the bus has signaled and is pulling back onto the road, you are the one who must yield.'),

  ('wa-q-share-farm-emblem-a', 'wa-q-share-farm-emblem', 1, 'It is carrying hazardous materials', false,
   'Not quite. On a farm vehicle, the triangle marks a slow-moving vehicle designed to go 25 mph or less.'),
  ('wa-q-share-farm-emblem-b', 'wa-q-share-farm-emblem', 2, 'It is about to turn off the road', false,
   'The triangle does not show turns. It means the vehicle is designed to go 25 mph or less.'),
  ('wa-q-share-farm-emblem-c', 'wa-q-share-farm-emblem', 3, 'It is designed to go 45 mph or less', false,
   'Not quite. Farm vehicles with this triangle are designed to go 25 mph or less.'),
  ('wa-q-share-farm-emblem-d', 'wa-q-share-farm-emblem', 4, 'It is designed to go 25 mph or less', true,
   'Right. Farm vehicles designed to go 25 mph or less have a triangle sign on the back. Be patient and slow down.'),

  ('wa-q-share-emergency-a', 'wa-q-share-emergency', 1, 'Speed up to stay ahead of it', false,
   'Not quite. Emergency vehicles using lights or sirens always have the right-of-way. Pull to the right and stop.'),
  ('wa-q-share-emergency-b', 'wa-q-share-emergency', 2, 'Stop right where you are in your lane', false,
   'Not quite. Pull to the right side of the road first, then stop. Moving to the right helps emergency vehicle drivers do their job.'),
  ('wa-q-share-emergency-c', 'wa-q-share-emergency', 3, 'Pull to the right side of the road and stop', true,
   'Right. As soon as you see or hear the signals, pull to the right side of the road and stop until it has passed.'),
  ('wa-q-share-emergency-d', 'wa-q-share-emergency', 4, 'Pull to the left side of the road and stop', false,
   'Not quite. Pull to the right side of the road, not the left, and stop.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
