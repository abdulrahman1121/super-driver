-- Lesson 9: Spotting and handling hazards (WA Driver Guide 5.0, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8).
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
  ('wa-hazards', 9, 'Spotting and handling hazards',
   'How to spot hazards early, merge smoothly, drive at night and on slippery roads, and handle car trouble.',
   'WA Driver Guide 5.0, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-hazards-spotting', 'wa-hazards', 1, 'Spotting and handling hazards',
   E'Driving always carries some risk. Safe habits lower your chance of a crash. Common factors in fatal crashes include speed, impairment, distractions, people not buckled in, and inexperience. In Washington, vehicle crashes are a leading cause of death for people ages 16 to 25.\n\nA hazard is anything that requires you to make a change, like a new speed or direction. It can be an immediate danger, like a child running into the road, or something less serious, like a trash can in the road. Hazards can be still or moving, and there may be more than 1 at a time. Decide which one needs the most urgent response. Slow down as you approach hazards to give yourself more space and time to make safe decisions.\n\nKeep scanning ahead, beside and behind you. The drivers behind you could be the most affected by your decisions.\n\nUse the same routine for every hazard:\n- Plan: scan around you, including behind, and decide if the change is safe.\n- Communicate: signal so others know what you plan to do.\n- Check: set your speed and position so you have space to make your change with no more than medium braking. Recheck your mirrors and look over your shoulder for pedestrians and bicyclists. Make sure no other driver is moving into the same space.\n- Execute: make the change smoothly. Try not to surprise anyone.\n- Evaluate: think about how it went.\n\nYour lights, horn and hand signals can also warn others about a risk.',
   'WA Driver Guide 5.0, Dangers of driving; 5.8, Communicating risk', 'draft'),
  ('wa-hazards-focus', 'wa-hazards', 2, 'Looking ahead and staying focused',
   E'The earlier you spot a hazard, the more time you have to prepare, and the more time the people around you have to adjust. Planning ahead like this is less risky than relying on your reactions to avoid danger.\n\nEye-lead time means scanning far down the road so you have time to see, analyze and respond to hazards. Scan as far as you can see ahead and to the sides, and use your mirrors to scan behind.\n\nTo practice judging distance, pick a marker, such as a road sign or utility pole, that you think is 15 seconds ahead. Then count until you reach it. Your guesses will get better with practice.\n\nYour brain can only focus on 1 thing at a time, so give driving your full attention. Turn off distractions like your phone and in-car entertainment. Even a few seconds of distraction can have devastating consequences.\n\nYou use 3 types of vision while driving. Think about reading a page:\n- Central vision lets you see detail straight in front of you, like the words you are reading.\n- Fringe vision is what you use to see the edges of the page. You can see it, but it may not be very focused.\n- Peripheral vision is what you can see to the side of you without losing focus on the words, like the walls of the room or someone walking past you.\n\nHigher speeds reduce the quality of all 3 types of vision.',
   'WA Driver Guide 5.4, Time; 5.5, Focus', 'draft'),
  ('wa-hazards-merging', 'wa-hazards', 3, 'Merging and turning into traffic',
   E'When you merge, leave enough space that the people around you do not have to swerve, slow or stop. Squeezing into a space that is too small can be dangerous, especially if the driver in front needs to slow down or stop.\n\nDrivers already on the interstate have the right-of-way, so you may need to speed up or slow down to find a safe space. Use the entire on-ramp, your turn signal and your mirrors.\n\nWhen traffic is moving slowly or is stopped because a lane is closed, it is important to merge smoothly. To zipper merge:\n- Stay in your lane. Keep using both lanes until you reach the merge area.\n- Take turns with vehicles from the other lane, like the teeth of a zipper.\n- Be courteous. Allow 1 vehicle from the ending lane to merge in front of you.\n- Keep a steady pace that matches the speed of traffic in the open lane.\n\nZipper merging improves traffic flow by 60 percent and makes merging predictable.\n\nWhen you turn in front of oncoming traffic, remember that approaching traffic has the right-of-way. It is better to give yourself too much time than not enough. When you turn into the flow of traffic, you need enough time to finish your turn and reach the speed of that traffic.',
   'WA Driver Guide 5.3, Merging; 5.4, Turning in front of approaching vehicles', 'draft'),
  ('wa-hazards-night-curves', 'wa-hazards', 4, 'Night driving and curves',
   E'It is harder to see at night. To stay safe:\n- Drive at a speed that lets you stop within the glow of your headlights (usually 400 feet).\n- Use your high beams when there are no oncoming vehicles. Switch back to your regular headlights when traffic approaches, and when you follow another vehicle.\n- Do not look straight into oncoming headlights. If a vehicle comes toward you with its high beams on, look toward the right side of the road.\n- Search beyond your headlight beams for dark shapes or shadows.\n- Do not wear sunglasses or colored lenses at night or on overcast days. They reduce your vision.\n\nOn curves:\n- Before the curve: slow down, look ahead to judge how sharp and long it is, and move slightly to the outside of your lane.\n- In the curve: keep a steady speed, with no sudden braking or speeding up, and steer smoothly.\n- Leaving the curve: speed up gradually and check your mirrors.\n\nIf you turn the steering wheel suddenly, inertia tries to keep the car moving straight. Higher speeds also mean you need more time and space to stop or change direction.',
   'WA Driver Guide 5.6, Night driving; Curves', 'draft'),
  ('wa-hazards-slippery', 'wa-hazards', 5, 'Slippery roads, skids and hydroplaning',
   E'Rain, snow and sleet can make Washington roads slippery. Adjust your driving, even if that means going below the posted speed limit.\n\nWatch for slippery spots:\n- When rain starts on a hot day, the pavement can be very slippery for the first few minutes, until oil from the asphalt washes away.\n- On cold, wet days, shady spots can be icy.\n- Bridges and overpasses can have icy spots even when the rest of the road does not.\n- When below-freezing temperatures warm up to near freezing, melting ice makes the road more slippery.\n- Black ice is a thin coating of ice that is hard to see. Pay attention whenever it is near or below freezing.\n\nA skid happens when your tires can no longer grip the road. You cannot control a vehicle while it skids, so it is best to avoid skidding in the first place. If you skid:\n- Take your foot off the accelerator.\n- Press or pump your brakes. Antilock brakes help you slow down and let you keep steering. If you do not have antilock brakes, quickly pressing the brake pedal down could cause you to skid more.\n- Steer in the same direction your vehicle is moving.\n- Keep correcting your steering until your tires grip the road again.\n- After you get control, think about the road conditions and adjust your driving.\n\nHydroplaning is when water builds up between your tires and the road, so your tires lose grip and skid. The best way to prevent it is to slow down when the road is wet. If you hydroplane:\n- Take your foot off the accelerator.\n- Gently press the brakes. If you do not have antilock brakes, pressing the brake pedal hard could cause you to hydroplane more.\n- Keep the steering wheel steady. Do not jerk it or overcorrect.\n- Look where you want to go, and calmly wait for your tires to grip again.\n- After you get control, think about the road conditions and adjust your driving.',
   'WA Driver Guide 5.6, Slippery roads; Skidding; Hydroplaning', 'draft'),
  ('wa-hazards-breakdowns', 'wa-hazards', 6, 'When your vehicle has a problem',
   E'If your vehicle has trouble on the road:\n- Get it off the road and away from traffic, if you can.\n- Stop where other drivers can clearly see your vehicle, especially if you cannot get it off the road. Avoid stopping just over a hill or around a curve.\n- Turn on your emergency flashers and headlights.\n- Warn others by placing emergency flares 200 to 300 feet behind your vehicle.\n- If you do not have flares or another warning device, stand somewhere safe and wave traffic around your vehicle.\n- Lift the hood or tie a white cloth to the antenna, side mirror or door handle to signal an emergency.\n\nIf a tire blows out or suddenly goes flat:\n- Grip the steering wheel firmly and keep the vehicle going straight.\n- Slow down gradually. Take your foot off the accelerator.\n- Do not brake. Let the vehicle slow by itself, or brake gently if necessary.\n- Pull off the road in a safe place, if possible, and turn on your emergency flashers. If you cannot get to a safe place to change the tire, turn on your hazard warning lights, stay in your vehicle and call for help.\n- Have the tire repaired or replaced.\n\nIf the engine shuts off while you are driving:\n- Keep a strong grip on the steering wheel. It might be hard to turn, but you can turn it.\n- Look for an escape path. Do not brake hard. Brake with steady pressure on the pedal, slow down, and then pull off the road.\n- Stop and try to restart the engine. If it will not start, raise the hood, turn on your hazard warning lights and call for help.\n\nIf your headlights suddenly go out:\n- Turn on your hazard warning lights, turn signals or fog lights, if you have them.\n- Pull off the road as soon as possible.\n\nIf the vehicle keeps going faster and faster:\n- Keep your eyes on the road.\n- Quickly shift to neutral.\n- Pull off the road when it is safe.\n- Turn off the engine.',
   'WA Driver Guide 5.7, Vehicle failures', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-hazards-what-is', 'wa-hazards-spotting', 1,
   'While you are driving, what counts as a hazard?',
   'WA Driver Guide 5.0, Hazard perception', 'draft'),
  ('wa-q-hazards-several', 'wa-hazards-spotting', 2,
   'You notice two hazards ahead of you at the same time. What should you do?',
   'WA Driver Guide 5.0, Hazard perception', 'draft'),
  ('wa-q-hazards-routine', 'wa-hazards-spotting', 3,
   'You want to move around a trash can in your lane. You have scanned the road and turned on your signal. What should you do before you move over?',
   'WA Driver Guide 5.0, Hazard management', 'draft'),

  ('wa-q-hazards-eye-lead', 'wa-hazards-focus', 1,
   'Why should you keep scanning far down the road ahead of you?',
   'WA Driver Guide 5.4, Time', 'draft'),
  ('wa-q-hazards-attention', 'wa-hazards-focus', 2,
   'Which of these is true about paying attention while you drive?',
   'WA Driver Guide 5.5, Attention', 'draft'),
  ('wa-q-hazards-speed-vision', 'wa-hazards-focus', 3,
   'How does driving at higher speeds affect your vision?',
   'WA Driver Guide 5.5, Field of vision', 'draft'),

  ('wa-q-hazards-onramp', 'wa-hazards-merging', 1,
   'You are on an on-ramp, about to merge onto the interstate. Who has the right-of-way?',
   'WA Driver Guide 5.3, Merging', 'draft'),
  ('wa-q-hazards-zipper', 'wa-hazards-merging', 2,
   'A lane ahead is closed and traffic is moving slowly. How do you zipper merge?',
   'WA Driver Guide 5.3, How to zipper merge', 'draft'),
  ('wa-q-hazards-turn-time', 'wa-hazards-merging', 3,
   'You want to turn in front of oncoming traffic, but you are not sure the gap is big enough. What should you do?',
   'WA Driver Guide 5.4, Turning in front of approaching vehicles', 'draft'),

  ('wa-q-hazards-night-speed', 'wa-hazards-night-curves', 1,
   'How fast should you drive at night?',
   'WA Driver Guide 5.6, Night driving', 'draft'),
  ('wa-q-hazards-high-beams', 'wa-hazards-night-curves', 2,
   'You have your high beams on along a dark road. A car appears, coming toward you. What should you do?',
   'WA Driver Guide 5.6, Night driving', 'draft'),
  ('wa-q-hazards-curve', 'wa-hazards-night-curves', 3,
   'You see a sharp curve ahead. When should you slow down?',
   'WA Driver Guide 5.6, Approaching a curve', 'draft'),

  ('wa-q-hazards-ice', 'wa-hazards-slippery', 1,
   'It is a cold, wet day and most of the road looks clear. What should you keep in mind?',
   'WA Driver Guide 5.6, Slippery roads', 'draft'),
  ('wa-q-hazards-skid', 'wa-hazards-slippery', 2,
   'Your car starts to skid on a slippery road. Which way should you steer?',
   'WA Driver Guide 5.6, Skidding', 'draft'),
  ('wa-q-hazards-hydroplane', 'wa-hazards-slippery', 3,
   'Your car starts to hydroplane on a wet road and feels like it is floating. What should you do?',
   'WA Driver Guide 5.6, Hydroplaning', 'draft'),

  ('wa-q-hazards-flares', 'wa-hazards-breakdowns', 1,
   'Your car breaks down and you need to warn other drivers. Where should you place emergency flares?',
   'WA Driver Guide 5.7, Vehicle failures', 'draft'),
  ('wa-q-hazards-blowout', 'wa-hazards-breakdowns', 2,
   'A tire suddenly blows out while you are driving. What should you do?',
   'WA Driver Guide 5.7, Tires', 'draft'),
  ('wa-q-hazards-accelerator', 'wa-hazards-breakdowns', 3,
   'Your car keeps going faster and faster on its own. What should you do?',
   'WA Driver Guide 5.7, Accelerator', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-hazards-what-is-a', 'wa-q-hazards-what-is', 1, 'Only something that could cause a crash right away', false,
   'Not quite. A hazard can also be something less serious, like a trash can in the road or a speed limit sign coming up.'),
  ('wa-q-hazards-what-is-b', 'wa-q-hazards-what-is', 2, 'Anything that requires you to make a change', true,
   'Right. A hazard is anything that requires you to make a change, such as changing your speed or direction.'),
  ('wa-q-hazards-what-is-c', 'wa-q-hazards-what-is', 3, 'Only other vehicles that are moving', false,
   'Not quite. Hazards can be still or moving, and they are not only vehicles. A child or a trash can in the road is a hazard too.'),
  ('wa-q-hazards-what-is-d', 'wa-q-hazards-what-is', 4, 'Only damage to the road, like potholes', false,
   'Not quite. A hazard is anything that requires you to make a change, including people, objects or a speed limit sign coming up.'),

  ('wa-q-hazards-several-a', 'wa-q-hazards-several', 1, 'Deal with whichever one you saw first', false,
   'Not quite. The order you noticed them in does not decide it. Decide which hazard needs the most urgent response.'),
  ('wa-q-hazards-several-b', 'wa-q-hazards-several', 2, 'Ignore the smaller one and keep your speed', false,
   'Not quite. A hazard is anything that requires you to make a change. Slow down as you approach hazards so you have more space and time to make safe decisions.'),
  ('wa-q-hazards-several-c', 'wa-q-hazards-several', 3, 'Decide which one needs the most urgent response', true,
   'Right. When there is more than 1 hazard, it is your job to decide which one needs the most urgent response. Slowing down gives you more time.'),

  ('wa-q-hazards-routine-a', 'wa-q-hazards-routine', 1, 'Move over right away, since your signal is on', false,
   'Not quite. Your signal tells others your plan, but you still need to check that the space is clear before you move.'),
  ('wa-q-hazards-routine-b', 'wa-q-hazards-routine', 2, 'Brake hard so the driver behind you notices', false,
   'Not quite. Set your speed so you need no more than medium braking, and try not to surprise anyone. The drivers behind you could be the most affected by your decisions.'),
  ('wa-q-hazards-routine-c', 'wa-q-hazards-routine', 3, 'Turn off your signal so no one gets confused', false,
   'Not quite. Signaling is how you let others know what you plan to do. Turning it off hides your plan.'),
  ('wa-q-hazards-routine-d', 'wa-q-hazards-routine', 4, 'Recheck your mirrors and look over your shoulder', true,
   'Right. After you plan and signal, check: recheck your mirrors and look over your shoulder for pedestrians and bicyclists.'),

  ('wa-q-hazards-eye-lead-a', 'wa-q-hazards-eye-lead', 1, 'So you have time to respond to hazards', true,
   'Right. Scanning far ahead gives you time to see, analyze and respond to hazards, and gives the people around you time to adjust.'),
  ('wa-q-hazards-eye-lead-b', 'wa-q-hazards-eye-lead', 2, 'So you no longer need your mirrors', false,
   'Not quite. You scan ahead and to the sides, and you still use your mirrors to scan behind.'),
  ('wa-q-hazards-eye-lead-c', 'wa-q-hazards-eye-lead', 3, 'So you can react at the last moment', false,
   'Not quite. Looking far ahead lets you plan early, which is less risky than relying on your reactions to avoid danger.'),
  ('wa-q-hazards-eye-lead-d', 'wa-q-hazards-eye-lead', 4, 'So you can follow the car ahead closer', false,
   'Not quite. Leave enough space in front of your vehicle to see what is happening on the road ahead.'),

  ('wa-q-hazards-attention-a', 'wa-q-hazards-attention', 1, 'Distractions only matter in heavy traffic', false,
   'Not quite. Distractions, even for a few seconds, can have devastating consequences. Your full attention is essential for safe driving.'),
  ('wa-q-hazards-attention-b', 'wa-q-hazards-attention', 2, 'Your brain can only focus on 1 thing at a time', true,
   'Right. Your brain can only focus on 1 thing at a time, so give driving your full attention. Even a few seconds of distraction can have devastating consequences.'),
  ('wa-q-hazards-attention-c', 'wa-q-hazards-attention', 3, 'A few seconds of distraction is harmless', false,
   'Not quite. Even a few seconds of distraction can have devastating consequences.'),

  ('wa-q-hazards-speed-vision-a', 'wa-q-hazards-speed-vision', 1, 'It makes your central vision sharper', false,
   'Not quite. Higher speeds reduce the quality of each type of vision, including central vision.'),
  ('wa-q-hazards-speed-vision-b', 'wa-q-hazards-speed-vision', 2, 'It only affects your peripheral vision', false,
   'Not quite. Higher speeds reduce the quality of all 3 types: central, fringe and peripheral.'),
  ('wa-q-hazards-speed-vision-c', 'wa-q-hazards-speed-vision', 3, 'It has no effect on what you can see', false,
   'Not quite. Speed does change what you can see. Higher speeds reduce the quality of each type of vision.'),
  ('wa-q-hazards-speed-vision-d', 'wa-q-hazards-speed-vision', 4, 'It lowers the quality of each type of vision', true,
   'Right. Higher speeds reduce the quality of each type of vision: central, fringe and peripheral.'),

  ('wa-q-hazards-onramp-a', 'wa-q-hazards-onramp', 1, 'You do, because you are merging', false,
   'Not quite. A merging driver must find a safe space. Drivers already on the interstate have the right-of-way.'),
  ('wa-q-hazards-onramp-b', 'wa-q-hazards-onramp', 2, 'Whichever driver is going faster', false,
   'Not quite. Speed does not decide it. Drivers already on the interstate have the right-of-way.'),
  ('wa-q-hazards-onramp-c', 'wa-q-hazards-onramp', 3, 'Drivers already on the interstate', true,
   'Right. Drivers already on the interstate have the right-of-way, so you may need to speed up or slow down to merge into a safe space.'),
  ('wa-q-hazards-onramp-d', 'wa-q-hazards-onramp', 4, 'The larger of the two vehicles', false,
   'Not quite. Vehicle size does not decide it. Drivers already on the interstate have the right-of-way.'),

  ('wa-q-hazards-zipper-a', 'wa-q-hazards-zipper', 1, 'Use both lanes until the merge area, then take turns', true,
   'Right. Stay in your lane until the merge area, then take turns with the other lane like the teeth of a zipper. It improves traffic flow by 60 percent.'),
  ('wa-q-hazards-zipper-b', 'wa-q-hazards-zipper', 2, 'Move into the open lane as early as you can', false,
   'Not quite. In a zipper merge, you stay in your lane and keep using both lanes until you reach the merge area.'),
  ('wa-q-hazards-zipper-c', 'wa-q-hazards-zipper', 3, 'Speed up to get ahead of cars in the other lane', false,
   'Not quite. Keep a steady pace that matches the open lane, and take turns with the other lane.'),
  ('wa-q-hazards-zipper-d', 'wa-q-hazards-zipper', 4, 'Stop at the end of your lane and wait for a big gap', false,
   'Not quite. In a zipper merge, you take turns with the other lane and keep a steady pace that matches the speed of traffic in the open lane.'),

  ('wa-q-hazards-turn-time-a', 'wa-q-hazards-turn-time', 1, 'Turn quickly before the gap closes', false,
   'Not quite. It is better to give yourself too much time than not enough. Approaching traffic has the right-of-way.'),
  ('wa-q-hazards-turn-time-b', 'wa-q-hazards-turn-time', 2, 'Turn, because turning drivers go first', false,
   'Not quite. Approaching traffic has the right-of-way, so you wait for a safe gap.'),
  ('wa-q-hazards-turn-time-c', 'wa-q-hazards-turn-time', 3, 'Wait for a bigger gap', true,
   'Right. It is better to give yourself too much time than not enough. Approaching traffic has the right-of-way.'),

  ('wa-q-hazards-night-speed-a', 'wa-q-hazards-night-speed', 1, 'Whatever speed feels comfortable to you', false,
   'Not quite. Comfort is not the test. Drive at a speed that lets you stop within the glow of your headlights.'),
  ('wa-q-hazards-night-speed-b', 'wa-q-hazards-night-speed', 2, 'Fast enough to keep up with the car ahead', false,
   'Not quite. At night, drive at a speed that lets you stop within the glow of your headlights (usually 400 feet).'),
  ('wa-q-hazards-night-speed-c', 'wa-q-hazards-night-speed', 3, 'The same speed you would drive in daylight', false,
   'Not quite. It is harder to see at night, so drive at a speed that lets you stop within the glow of your headlights.'),
  ('wa-q-hazards-night-speed-d', 'wa-q-hazards-night-speed', 4, 'Slow enough to stop within the glow of your headlights', true,
   'Right. Drive at a speed that lets you stop within the glow of your headlights (usually 400 feet).'),

  ('wa-q-hazards-high-beams-a', 'wa-q-hazards-high-beams', 1, 'Keep your high beams on so you can see', false,
   'Not quite. Use high beams only when there are no oncoming vehicles. Switch back to your regular headlights when traffic approaches.'),
  ('wa-q-hazards-high-beams-b', 'wa-q-hazards-high-beams', 2, 'Switch back to your regular headlights', true,
   'Right. Use your high beams when there are no oncoming vehicles, and switch back to your regular headlights when there is approaching traffic.'),
  ('wa-q-hazards-high-beams-c', 'wa-q-hazards-high-beams', 3, 'Turn off your headlights until it passes', false,
   'Not quite. It is harder to see at night. When there is approaching traffic, switch back to your regular headlights.'),
  ('wa-q-hazards-high-beams-d', 'wa-q-hazards-high-beams', 4, 'Flash your high beams until it passes', false,
   'Not quite. When there is approaching traffic, switch back to your regular headlights.'),

  ('wa-q-hazards-curve-a', 'wa-q-hazards-curve', 1, 'Before you enter the curve', true,
   'Right. Slowing down before the curve helps your tires keep traction and keeps your vehicle from skidding or running off the road.'),
  ('wa-q-hazards-curve-b', 'wa-q-hazards-curve', 2, 'In the middle of the curve', false,
   'Not quite. In the curve, keep a steady speed. Sudden braking there can upset your vehicle''s balance and cause a loss of control.'),
  ('wa-q-hazards-curve-c', 'wa-q-hazards-curve', 3, 'As you come out of the curve', false,
   'Not quite. As you leave the curve, you gently speed back up. Slow down before you enter it.'),

  ('wa-q-hazards-ice-a', 'wa-q-hazards-ice', 1, 'Ice is easy to spot, so you will see it', false,
   'Not quite. Black ice is a thin coating that is hard to see. Pay attention whenever it is near or below freezing.'),
  ('wa-q-hazards-ice-b', 'wa-q-hazards-ice', 2, 'Ice that starts melting makes roads safer', false,
   'Not quite. When ice melts and gets wet near freezing, the road becomes more slippery, not less.'),
  ('wa-q-hazards-ice-c', 'wa-q-hazards-ice', 3, 'Bridges and shady spots can still be icy', true,
   'Right. On cold, wet days shady spots can be icy, and bridges and overpasses can have icy spots even when the rest of the road does not.'),
  ('wa-q-hazards-ice-d', 'wa-q-hazards-ice', 4, 'Roads only get icy while it is snowing', false,
   'Not quite. Snow is not needed. On cold, wet days, shady spots and bridges can be icy.'),

  ('wa-q-hazards-skid-a', 'wa-q-hazards-skid', 1, 'Hard in the opposite direction of the skid', false,
   'Not quite. Steer in the same direction your vehicle is moving, and keep correcting until your tires grip again.'),
  ('wa-q-hazards-skid-b', 'wa-q-hazards-skid', 2, 'In the same direction your vehicle is moving', true,
   'Right. Take your foot off the accelerator, press or pump your brakes, steer in the same direction your vehicle is moving, and keep correcting until your tires grip again.'),
  ('wa-q-hazards-skid-c', 'wa-q-hazards-skid', 3, 'Hold the wheel still and do not steer at all', false,
   'Not quite. You need to keep steering. Steer in the same direction your vehicle is moving and keep correcting.'),
  ('wa-q-hazards-skid-d', 'wa-q-hazards-skid', 4, 'Toward the nearest shoulder to get off the road', false,
   'Not quite. First get control by steering in the same direction your vehicle is moving. Then assess the situation.'),

  ('wa-q-hazards-hydroplane-a', 'wa-q-hazards-hydroplane', 1, 'Brake hard to stop as fast as you can', false,
   'Not quite. Press the brakes gently. Without antilock brakes, pressing hard could make you hydroplane more.'),
  ('wa-q-hazards-hydroplane-b', 'wa-q-hazards-hydroplane', 2, 'Turn the wheel quickly to find grip', false,
   'Not quite. Keep the steering wheel steady and avoid jerking it or overcorrecting.'),
  ('wa-q-hazards-hydroplane-c', 'wa-q-hazards-hydroplane', 3, 'Take your foot off the accelerator and keep the wheel steady', true,
   'Right. Take your foot off the accelerator, press the brakes gently, keep the steering wheel steady and wait for your tires to grip again.'),

  ('wa-q-hazards-flares-a', 'wa-q-hazards-flares', 1, 'Right beside your vehicle', false,
   'Not quite. To warn other road users, place flares 200 to 300 feet behind your vehicle.'),
  ('wa-q-hazards-flares-b', 'wa-q-hazards-flares', 2, '50 feet in front of your vehicle', false,
   'Not quite. Flares go behind your vehicle, 200 to 300 feet back.'),
  ('wa-q-hazards-flares-c', 'wa-q-hazards-flares', 3, '1,000 feet behind your vehicle', false,
   'Not quite. Place emergency flares 200 to 300 feet behind your vehicle to warn other road users.'),
  ('wa-q-hazards-flares-d', 'wa-q-hazards-flares', 4, '200 to 300 feet behind your vehicle', true,
   'Right. Emergency flares placed 200 to 300 feet behind your vehicle warn other road users.'),

  ('wa-q-hazards-blowout-a', 'wa-q-hazards-blowout', 1, 'Brake hard right away to stop quickly', false,
   'Not quite. Do not brake. Let the vehicle slow by itself, or brake gently if you must.'),
  ('wa-q-hazards-blowout-b', 'wa-q-hazards-blowout', 2, 'Hold the wheel firmly and slow down gradually', true,
   'Right. Grip the wheel firmly, keep the vehicle going straight, and take your foot off the accelerator so it slows down gradually. Do not brake, or brake gently if necessary.'),
  ('wa-q-hazards-blowout-c', 'wa-q-hazards-blowout', 3, 'Steer sharply onto the shoulder at once', false,
   'Not quite. Keep the vehicle going straight while you slow down gradually. Then pull off the road in a safe place, if possible.'),

  ('wa-q-hazards-accelerator-a', 'wa-q-hazards-accelerator', 1, 'Quickly shift to neutral, then pull off when safe', true,
   'Right. Keep your eyes on the road, quickly shift to neutral, pull off the road when it is safe, and then turn off the engine.'),
  ('wa-q-hazards-accelerator-b', 'wa-q-hazards-accelerator', 2, 'Look down to see what is wrong with the pedal', false,
   'Not quite. Keep your eyes on the road. Shift to neutral and pull off when it is safe.'),
  ('wa-q-hazards-accelerator-c', 'wa-q-hazards-accelerator', 3, 'Keep driving and wait for it to slow down', false,
   'Not quite. Do not wait. Quickly shift to neutral, then pull off the road when it is safe.'),
  ('wa-q-hazards-accelerator-d', 'wa-q-hazards-accelerator', 4, 'Turn off the engine while still at full speed', false,
   'Not quite. Shift to neutral first and pull off the road when it is safe. Turn off the engine after that.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
