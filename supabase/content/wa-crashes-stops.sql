-- Lesson 10: Crashes and getting pulled over (WA Driver Guide 5.9, 5.10).
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
  ('wa-crashes-stops', 10, 'Crashes and getting pulled over',
   'What to do during and after a crash, and what to do when an officer pulls you over.',
   'WA Driver Guide 5.9, 5.10', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-crashes-stops-at-crash', 'wa-crashes-stops', 1, 'If you are in a crash',
   E'Collisions usually have 3 causes: too much speed, too little space, and not enough awareness of what is happening around you. Even careful drivers can end up in a crash, so know what to do.\n\nIf you are in a crash:\n- Do not drive away. If anyone is injured or killed, call 911. Law enforcement must be notified.\n- As soon as possible, move your vehicle to the side of the road, but stay near the collision site.\n- Do not stand or walk in traffic lanes. Another vehicle could hit you.\n- Use flares or other warning devices to alert other drivers.\n- Turn off wrecked vehicles.\n- Do not smoke near wrecked vehicles. Fuel could have spilled, and fire is a real danger.\n\nIf you hit a parked vehicle, you must try to find the owner. If you cannot, leave a note where they can easily see it. Include the date and time of the collision and your contact information.\n\nIf you drive past a crash, do not block emergency responders. Follow directions from police, firefighters and anyone else authorized to direct traffic at the scene. Focus on your driving as you pass, to keep responders and the people involved safe. Slowing down to stare at the scene creates traffic jams.\n\nA crash on the roadside can create an emergency zone. As soon as you see a roadside response vehicle with flashing lights, you must either move over into a farther lane, or slow down to at least 10 mph below the posted speed limit (and never faster than 50 mph in an emergency zone).',
   'WA Driver Guide 5.9, Crashing a vehicle; Witnessing a crash; 4.17, Emergency zone', 'draft'),
  ('wa-crashes-stops-reporting', 'wa-crashes-stops', 2, 'Reporting a crash and being prepared',
   E'After a collision, gather information that will help you report it.\n\n- Collect information from the others involved, and share yours too. Exchange your name, contact information, driver license number, and insurance company and policy number.\n- Take photos or videos of any damage to the vehicles.\n- Give information to the police or other emergency officials if they ask for it.\n- If a law enforcement officer does not file a collision report for you, you must file a collision report form within 4 days of the crash. The form is required by state law.\n\nIt is a good idea to keep an emergency kit in your vehicle. Items you might want include:\n- A first aid kit, a flashlight and a blanket\n- Water\n- Jumper cables, and a tool kit or multipurpose tool\n- A backup phone charger or power source\n- A spare tire, wheel wrench and jack\n- Reflective triangles or flares\n\nIt is also a good idea to keep a paper copy of important phone numbers, like family members and your insurance provider. It will help if your phone battery dies and you need to call from a different phone.',
   'WA Driver Guide 5.9, Reporting a crash; Emergency kit', 'draft'),
  ('wa-crashes-stops-injuries', 'wa-crashes-stops', 3, 'Helping injured people and calling 911',
   E'Injuries can add more stress after a crash. Do your best to stay calm, check yourself, and then help others. Call 911.\n\n- Do not move injured people unless they are in a burning vehicle or in some other immediate danger.\n- Help anyone who is not already walking and talking. Check for breathing, then check for bleeding.\n- If you see bleeding, follow these steps: apply pressure with your hands, apply a bandage or dressing, and apply a tourniquet.\n- Do not give injured people anything to drink, not even water.\n- Cover injured people with a blanket or coat to keep them warm and help prevent shock.\n\nWhen you call 911, try to stay calm so you can give clear information. Tell the dispatcher:\n- Your location, including any close landmarks or mile markers. If you are not sure where you are, give as much detail as you can.\n- What happened: how many vehicles, the damage, and any injuries.\n- More details if asked, like vehicle types, license plate numbers and any hazards.\n\nFollow the dispatcher''s instructions, and stay on the phone until help arrives.',
   'WA Driver Guide 5.9, Reporting an injury; Calling 911', 'draft'),
  ('wa-crashes-stops-power-lines', 'wa-crashes-stops', 4, 'Power lines',
   E'If a power line touches your vehicle, do not get out. You never know how, when or if a power line is charged, so assume every power line is energized.\n\n- After a collision involving power lines, turn off your engine, call 911, and stay inside your vehicle until emergency responders arrive.\n- If you accidentally drive over a power line, stop immediately. Moving forward or backing up puts you at risk of being electrocuted. Call 911 and stay inside until you are told it is safe to get out.\n- If power lines fall on your vehicle, or you hit a transformer box, stay in your vehicle and call 911. The ground around your vehicle could also be energized. When possible, encourage other people to stay at least 35 feet away.\n\nIf your vehicle is in contact with power lines and a fire starts, you need to get out. It is very important to jump clear of the vehicle:\n- Open your door and perch on the edge of the doorway.\n- Jump away from the vehicle with your arms at your sides. Be careful not to touch the vehicle.\n- Make sure both feet land together.\n- Shuffle 35 feet away to safety to avoid electric shock.\n- Do not go back for your belongings until you are told it is safe.',
   'WA Driver Guide 5.9, Encountering power lines', 'draft'),
  ('wa-crashes-stops-pulled-over', 'wa-crashes-stops', 5, 'Getting pulled over',
   E'Police signal a driver to stop by turning on flashing lights, a siren, or both. If an officer pulls you over:\n- Use your turn signal and pull to the right side of the road as soon as it is safe.\n- Turn off the engine and any audio devices, like the radio.\n- Stay in your vehicle unless the officer tells you to get out.\n- At night, turn on your interior lights. Officers might also use a spotlight to see better.\n- Keep your hands on the steering wheel.\n- Follow all instructions the officer gives you or your passengers.\n\nThe officer could walk up to either side of your vehicle. When they do:\n- Lower the window on that side so you can talk with each other.\n- Let the officer know right away if you have a weapon in the vehicle.\n- Wait for the officer''s instructions before you reach for your driver license or vehicle documents.',
   'WA Driver Guide 5.10, Getting pulled over', 'draft'),
  ('wa-crashes-stops-ticket', 'wa-crashes-stops', 6, 'Talking with the officer and getting a ticket',
   E'An officer will usually explain why you were stopped and ask for your:\n- Driver license\n- Proof of insurance\n- Vehicle registration\n\nTell the officer where these documents are before you reach for them. The officer will usually also explain what action they are taking: giving a warning or a ticket, or making an arrest. If they do not explain, you can ask them to.\n\nYou are allowed to respectfully ask the officer questions. If you disagree with their decision, do not drag out the stop by arguing. You can contest the decision in court instead. If you believe the officer acted inappropriately, you can contact the officer''s agency and ask for a supervisor. This is best done as soon as possible after the stop.\n\nIf you get a ticket, you are required to sign it. Signing is not an admission of guilt, but refusing to sign a ticket could get you arrested. Follow the instructions on the back of the ticket within 15 days to avoid having your driving privileges suspended. Driving with a suspended license could mean losing your vehicle, getting arrested, or both.',
   'WA Driver Guide 5.10, Getting pulled over; Getting a ticket', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-crash-stay-at-scene', 'wa-crashes-stops-at-crash', 1,
   'You are in a crash and the other driver is hurt. What should you do?',
   'WA Driver Guide 5.9, Crashing a vehicle', 'draft'),
  ('wa-q-crash-parked-car', 'wa-crashes-stops-at-crash', 2,
   'You bump into a parked car, and the owner is nowhere in sight. What should you do?',
   'WA Driver Guide 5.9, Crashing a vehicle', 'draft'),
  ('wa-q-crash-witness', 'wa-crashes-stops-at-crash', 3,
   'You are driving past a crash that police are already handling. What should you do?',
   'WA Driver Guide 5.9, Witnessing a crash; 4.17, Emergency zone', 'draft'),

  ('wa-q-crash-exchange-info', 'wa-crashes-stops-reporting', 1,
   'After a crash, what information should you exchange with the other driver?',
   'WA Driver Guide 5.9, Reporting a crash', 'draft'),
  ('wa-q-crash-report-deadline', 'wa-crashes-stops-reporting', 2,
   'After a crash, no law enforcement officer filed a collision report for you. What is the deadline to file the collision report form yourself?',
   'WA Driver Guide 5.9, Reporting a crash', 'draft'),

  ('wa-q-crash-move-injured', 'wa-crashes-stops-injuries', 1,
   'After a crash, a passenger is hurt. The car is not on fire, and they are in no other immediate danger. What should you do?',
   'WA Driver Guide 5.9, Reporting an injury', 'draft'),
  ('wa-q-crash-check-breathing', 'wa-crashes-stops-injuries', 2,
   'After a crash, you find an injured person who is not walking or talking. What should you check first?',
   'WA Driver Guide 5.9, Reporting an injury', 'draft'),
  ('wa-q-crash-911-location', 'wa-crashes-stops-injuries', 3,
   'You call 911 after a crash, but you are not sure exactly where you are. What should you do?',
   'WA Driver Guide 5.9, Calling 911', 'draft'),

  ('wa-q-crash-power-line-drive-over', 'wa-crashes-stops-power-lines', 1,
   'You accidentally drive over a power line that is lying on the road. What should you do?',
   'WA Driver Guide 5.9, Encountering power lines', 'draft'),
  ('wa-q-crash-power-line-keep-away', 'wa-crashes-stops-power-lines', 2,
   'Power lines have fallen on your car after a crash. A person nearby starts walking over to help you. What should you do?',
   'WA Driver Guide 5.9, Encountering power lines', 'draft'),
  ('wa-q-crash-power-line-fire', 'wa-crashes-stops-power-lines', 3,
   'A power line is touching your car and a fire starts, so you have to get out. How should you leave the car?',
   'WA Driver Guide 5.9, Encountering power lines', 'draft'),

  ('wa-q-crash-pull-over-where', 'wa-crashes-stops-pulled-over', 1,
   'A police car behind you turns on its flashing lights to stop you. What should you do?',
   'WA Driver Guide 5.10, Getting pulled over', 'draft'),
  ('wa-q-crash-pulled-over-night', 'wa-crashes-stops-pulled-over', 2,
   'You have been pulled over at night and are waiting for the officer to walk up. What should you do?',
   'WA Driver Guide 5.10, Getting pulled over', 'draft'),
  ('wa-q-crash-weapon', 'wa-crashes-stops-pulled-over', 3,
   'You are pulled over, and you have a weapon in your vehicle. When should you tell the officer?',
   'WA Driver Guide 5.10, Getting pulled over', 'draft'),

  ('wa-q-crash-documents', 'wa-crashes-stops-ticket', 1,
   'An officer who pulled you over asks for your documents. Which ones will they typically ask for?',
   'WA Driver Guide 5.10, Getting pulled over', 'draft'),
  ('wa-q-crash-disagree', 'wa-crashes-stops-ticket', 2,
   'An officer gives you a ticket that you think is unfair. What should you do?',
   'WA Driver Guide 5.10, Getting pulled over; Getting a ticket', 'draft'),
  ('wa-q-crash-ticket-deadline', 'wa-crashes-stops-ticket', 3,
   'You got a traffic ticket. How soon must you follow the instructions on the back to avoid having your driving privileges suspended?',
   'WA Driver Guide 5.10, Getting a ticket', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-crash-stay-at-scene-a', 'wa-q-crash-stay-at-scene', 1, 'Drive to the nearest police station to report it', false,
   'Not quite. Do not drive away from a crash. When someone is hurt, call 911 from the scene.'),
  ('wa-q-crash-stay-at-scene-b', 'wa-q-crash-stay-at-scene', 2, 'Leave once you have the other driver''s phone number', false,
   'Not quite. Do not drive away. Stay at the scene, and call 911 because someone is hurt.'),
  ('wa-q-crash-stay-at-scene-c', 'wa-q-crash-stay-at-scene', 3, 'Stay at the scene and call 911', true,
   'Right. Do not drive away. If anyone is injured or killed, call 911. Law enforcement must be notified.'),
  ('wa-q-crash-stay-at-scene-d', 'wa-q-crash-stay-at-scene', 4, 'Wait until you get home, then call the police', false,
   'Not quite. Do not drive away. When someone is hurt, call 911 from the scene.'),

  ('wa-q-crash-parked-car-a', 'wa-q-crash-parked-car', 1, 'Drive away, since no one was in the car', false,
   'Not quite. You must try to find the owner. If you cannot, leave a note where they can easily see it.'),
  ('wa-q-crash-parked-car-b', 'wa-q-crash-parked-car', 2, 'Try to find the owner, and leave a note if you cannot', true,
   'Right. You must try to find the owner. If you cannot, leave a note where they can easily see it, with the date and time of the collision and your contact information.'),
  ('wa-q-crash-parked-car-c', 'wa-q-crash-parked-car', 3, 'Take a photo of the damage, then drive away', false,
   'Photos are not enough here. You must try to find the owner, or leave a note if you cannot.'),
  ('wa-q-crash-parked-car-d', 'wa-q-crash-parked-car', 4, 'Leave a note only if the damage looks serious', false,
   'Not quite. When a crash involves a parked vehicle, you must try to find the owner, or leave a note if you cannot.'),

  ('wa-q-crash-witness-a', 'wa-q-crash-witness', 1, 'Watch the crash scene closely as you drive by', false,
   'Not quite. Keep your focus on your driving as you pass. Slowing down to stare at the scene creates traffic jams.'),
  ('wa-q-crash-witness-b', 'wa-q-crash-witness', 2, 'Park in front of the ambulance to see if you can help', false,
   'Not quite. Do not block emergency responders. Follow directions from the people directing traffic at the scene.'),
  ('wa-q-crash-witness-c', 'wa-q-crash-witness', 3, 'Stop in your lane to take photos of the crash', false,
   'Not quite. Focus on your driving as you pass, to keep responders and the people involved safe.'),
  ('wa-q-crash-witness-d', 'wa-q-crash-witness', 4, 'Focus on your driving and follow directions at the scene', true,
   'Right. Follow directions from police, firefighters and others authorized to direct traffic, and focus on your driving to keep everyone at the scene safe. If response vehicles have flashing lights, also move over into a farther lane or slow down to at least 10 mph below the posted speed limit.'),

  ('wa-q-crash-exchange-info-a', 'wa-q-crash-exchange-info', 1, 'Name, contact information, license number and insurance details', true,
   'Right. Exchange your name, contact information, driver license number, and insurance company and policy number.'),
  ('wa-q-crash-exchange-info-b', 'wa-q-crash-exchange-info', 2, 'Just phone numbers, so you can sort it out later', false,
   'Not quite. A phone number alone is not enough. You also need names, driver license numbers and insurance details.'),
  ('wa-q-crash-exchange-info-c', 'wa-q-crash-exchange-info', 3, 'Your names and where each of you was going', false,
   'Not quite. You need contact information, driver license numbers, and insurance company and policy numbers.'),
  ('wa-q-crash-exchange-info-d', 'wa-q-crash-exchange-info', 4, 'Nothing, because only the police collect information', false,
   'Not quite. You should collect information from the others involved and share yours too.'),

  ('wa-q-crash-report-deadline-a', 'wa-q-crash-report-deadline', 1, 'Within 24 hours of the crash', false,
   'Not quite. You have a little more time than that. The form is due within 4 days of the crash.'),
  ('wa-q-crash-report-deadline-b', 'wa-q-crash-report-deadline', 2, 'Within 4 days of the crash', true,
   'Right. If an officer does not file it for you, you must file a collision report form within 4 days. State law requires it.'),
  ('wa-q-crash-report-deadline-c', 'wa-q-crash-report-deadline', 3, 'Within 2 weeks of the crash', false,
   'That is too late. The form is due within 4 days of the crash.'),
  ('wa-q-crash-report-deadline-d', 'wa-q-crash-report-deadline', 4, 'Within 30 days of the crash', false,
   'That is too late. The form is due within 4 days of the crash.'),

  ('wa-q-crash-move-injured-a', 'wa-q-crash-move-injured', 1, 'Pull them out of the car right away', false,
   'Not quite. Do not move injured people unless they are in a burning vehicle or other immediate danger.'),
  ('wa-q-crash-move-injured-b', 'wa-q-crash-move-injured', 2, 'Help them stand up and walk around', false,
   'Not quite. Only move an injured person if they are in a burning vehicle or other immediate danger.'),
  ('wa-q-crash-move-injured-c', 'wa-q-crash-move-injured', 3, 'Give them some water to help them calm down', false,
   'Not quite. Do not give injured people anything to drink, not even water.'),
  ('wa-q-crash-move-injured-d', 'wa-q-crash-move-injured', 4, 'Leave them in place, call 911 and keep them warm', true,
   'Right. Do not move them, call 911, and cover them with a blanket or coat to keep them warm and help prevent shock.'),

  ('wa-q-crash-check-breathing-a', 'wa-q-crash-check-breathing', 1, 'Whether they are bleeding', false,
   'Bleeding is the second check. Check for breathing first, then check for bleeding.'),
  ('wa-q-crash-check-breathing-b', 'wa-q-crash-check-breathing', 2, 'Whether they can stand up', false,
   'Not quite. Do not move injured people unless they are in immediate danger. Check for breathing first.'),
  ('wa-q-crash-check-breathing-c', 'wa-q-crash-check-breathing', 3, 'Whether they are breathing', true,
   'Right. Help anyone who is not already walking and talking. Check for breathing, then check for bleeding.'),
  ('wa-q-crash-check-breathing-d', 'wa-q-crash-check-breathing', 4, 'Whether their car can still be driven', false,
   'The car can wait. Help the person first by checking for breathing, then for bleeding.'),

  ('wa-q-crash-911-location-a', 'wa-q-crash-911-location', 1, 'Describe nearby landmarks or mile markers', true,
   'Right. If you are not sure where you are, give as much detail as you can, like close landmarks or mile markers, so responders can find you.'),
  ('wa-q-crash-911-location-b', 'wa-q-crash-911-location', 2, 'Hang up and call back once you find an address', false,
   'Not quite. Stay on the phone with the dispatcher until help arrives, and share any details you can.'),
  ('wa-q-crash-911-location-c', 'wa-q-crash-911-location', 3, 'Say you do not know and end the call quickly', false,
   'Not quite. Even without an address, details like landmarks help responders find you. Stay on the phone.'),
  ('wa-q-crash-911-location-d', 'wa-q-crash-911-location', 4, 'Wait to call until someone else knows the location', false,
   'Do not wait. Call 911 and describe where you are as well as you can.'),

  ('wa-q-crash-power-line-drive-over-a', 'wa-q-crash-power-line-drive-over', 1, 'Keep driving forward to get clear of it', false,
   'Not quite. Moving forward puts you at risk of being electrocuted. Stop immediately.'),
  ('wa-q-crash-power-line-drive-over-b', 'wa-q-crash-power-line-drive-over', 2, 'Back up slowly until you are off the line', false,
   'Not quite. Backing up also puts you at risk of being electrocuted. Stop and stay inside.'),
  ('wa-q-crash-power-line-drive-over-c', 'wa-q-crash-power-line-drive-over', 3, 'Stop right away, call 911 and stay inside', true,
   'Right. Stop immediately, call 911, and stay inside your vehicle until you are told it is safe to get out.'),
  ('wa-q-crash-power-line-drive-over-d', 'wa-q-crash-power-line-drive-over', 4, 'Get out and walk away from the line', false,
   'Not quite. Assume every power line is energized. Stay inside your vehicle until you are told it is safe to get out.'),

  ('wa-q-crash-power-line-keep-away-a', 'wa-q-crash-power-line-keep-away', 1, 'Tell them to stay at least 35 feet away', true,
   'Right. The ground around your vehicle could also be energized. When possible, encourage people to stay at least 35 feet away.'),
  ('wa-q-crash-power-line-keep-away-b', 'wa-q-crash-power-line-keep-away', 2, 'Get out of the car and walk over to meet them', false,
   'Not quite. Stay in your vehicle and call 911. The ground around your vehicle could be energized.'),
  ('wa-q-crash-power-line-keep-away-c', 'wa-q-crash-power-line-keep-away', 3, 'Ask them to open your door for you', false,
   'Not quite. Assume the power lines are energized, and encourage people to stay at least 35 feet away.'),

  ('wa-q-crash-power-line-fire-a', 'wa-q-crash-power-line-fire', 1, 'Step out slowly while holding the door frame', false,
   'Not quite. Be careful not to touch the vehicle as you leave. Jump clear with your arms at your sides.'),
  ('wa-q-crash-power-line-fire-b', 'wa-q-crash-power-line-fire', 2, 'Climb out, then run back for your belongings', false,
   'Not quite. Do not go back for your belongings until you are told it is safe.'),
  ('wa-q-crash-power-line-fire-c', 'wa-q-crash-power-line-fire', 3, 'Jump out and run away as fast as you can', false,
   'Not quite. Land with both feet together, then shuffle 35 feet away to safety to avoid electric shock.'),
  ('wa-q-crash-power-line-fire-d', 'wa-q-crash-power-line-fire', 4, 'Jump clear with feet together, then shuffle away', true,
   'Right. Jump away with your arms at your sides without touching the vehicle, land with both feet together, and shuffle 35 feet away.'),

  ('wa-q-crash-pull-over-where-a', 'wa-q-crash-pull-over-where', 1, 'Stop right away in the lane you are in', false,
   'Not quite. Use your turn signal and pull to the right side of the road as soon as it is safe.'),
  ('wa-q-crash-pull-over-where-b', 'wa-q-crash-pull-over-where', 2, 'Signal and pull to the right when it is safe', true,
   'Right. Use your turn signal and pull to the right side of the road as soon as it is safe.'),
  ('wa-q-crash-pull-over-where-c', 'wa-q-crash-pull-over-where', 3, 'Pull over to the left side of the road', false,
   'Not quite. Pull to the right side of the road, and use your turn signal.'),
  ('wa-q-crash-pull-over-where-d', 'wa-q-crash-pull-over-where', 4, 'Keep going until the officer passes you', false,
   'Not quite. Police use flashing lights, a siren, or both to stop a driver. Signal and pull to the right when it is safe.'),

  ('wa-q-crash-pulled-over-night-a', 'wa-q-crash-pulled-over-night', 1, 'Get out and walk back to meet the officer', false,
   'Not quite. Stay in your vehicle unless the officer tells you to get out.'),
  ('wa-q-crash-pulled-over-night-b', 'wa-q-crash-pulled-over-night', 2, 'Search the glove box for your license and papers', false,
   'Not quite. Wait for the officer''s instructions before you reach for your license or vehicle documents.'),
  ('wa-q-crash-pulled-over-night-c', 'wa-q-crash-pulled-over-night', 3, 'Turn on inside lights and keep hands on the wheel', true,
   'Right. At night, turn on your interior lights, and keep your hands on the steering wheel.'),
  ('wa-q-crash-pulled-over-night-d', 'wa-q-crash-pulled-over-night', 4, 'Keep the engine running and the radio on', false,
   'Not quite. Turn off the engine and any audio devices, like the radio.'),

  ('wa-q-crash-weapon-a', 'wa-q-crash-weapon', 1, 'Only if the officer asks you about it', false,
   'Not quite. Do not wait to be asked. Let the officer know right away.'),
  ('wa-q-crash-weapon-b', 'wa-q-crash-weapon', 2, 'Right away, when the officer walks up to your car', true,
   'Right. When the officer approaches, let them know right away if you have a weapon in the vehicle.'),
  ('wa-q-crash-weapon-c', 'wa-q-crash-weapon', 3, 'At the end of the stop, before you drive off', false,
   'That is too late. Tell the officer right away when they walk up to your vehicle.'),

  ('wa-q-crash-documents-a', 'wa-q-crash-documents', 1, 'Driver license, proof of insurance and vehicle registration', true,
   'Right. An officer will typically ask for your driver license, proof of insurance and vehicle registration. Tell the officer where these documents are before you reach for them.'),
  ('wa-q-crash-documents-b', 'wa-q-crash-documents', 2, 'Driver license, car title and a recent repair receipt', false,
   'Not quite. Officers typically ask for your driver license, proof of insurance and vehicle registration.'),
  ('wa-q-crash-documents-c', 'wa-q-crash-documents', 3, 'School ID, proof of insurance and your birth certificate', false,
   'Not quite. Officers typically ask for your driver license, proof of insurance and vehicle registration.'),
  ('wa-q-crash-documents-d', 'wa-q-crash-documents', 4, 'Vehicle registration, car title and your passport', false,
   'Not quite. Officers typically ask for your driver license, proof of insurance and vehicle registration.'),

  ('wa-q-crash-disagree-a', 'wa-q-crash-disagree', 1, 'Refuse to sign it, because signing means you admit guilt', false,
   'Not quite. Signing is not an admission of guilt, and refusing to sign a ticket could result in your arrest.'),
  ('wa-q-crash-disagree-b', 'wa-q-crash-disagree', 2, 'Argue until the officer agrees to take it back', false,
   'Not quite. Do not drag out the stop by arguing. You can contest the decision in court.'),
  ('wa-q-crash-disagree-c', 'wa-q-crash-disagree', 3, 'Ask a passenger to sign it instead of you', false,
   'Not quite. If you get a ticket, you are required to sign for it.'),
  ('wa-q-crash-disagree-d', 'wa-q-crash-disagree', 4, 'Sign it, and contest it in court if you still disagree', true,
   'Right. Signing is not an admission of guilt. If you disagree, you can contest the decision in court.'),

  ('wa-q-crash-ticket-deadline-a', 'wa-q-crash-ticket-deadline', 1, 'Within 5 days', false,
   'Not quite. You have a little more time than that. Follow the instructions within 15 days.'),
  ('wa-q-crash-ticket-deadline-b', 'wa-q-crash-ticket-deadline', 2, 'Within 10 days', false,
   'Not quite. You have a little more time than that. Follow the instructions within 15 days.'),
  ('wa-q-crash-ticket-deadline-c', 'wa-q-crash-ticket-deadline', 3, 'Within 15 days', true,
   'Right. Follow the instructions on the back of the ticket within 15 days to avoid having your driving privileges suspended.'),
  ('wa-q-crash-ticket-deadline-d', 'wa-q-crash-ticket-deadline', 4, 'Within 30 days', false,
   'That is too late. Follow the instructions within 15 days, or your driving privileges could be suspended.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
