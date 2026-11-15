-- Lesson 12: Your vehicle (WA Driver Guide 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10, 2.11, 2.12, 2.13).
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
  ('wa-your-vehicle', 12, 'Your vehicle',
   'Set up and check your vehicle, buckle everyone in, handle it smoothly and watch your blind zones.',
   'WA Driver Guide 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10, 2.11, 2.12, 2.13', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-your-vehicle-getting-ready', 'wa-your-vehicle', 1, 'Getting ready to drive',
   E'Every vehicle is different. Read the owner''s manual for every vehicle you drive, so you know its systems, gauges and controls before you go. Then your focus can be on the road.\n\nEach time you get in, adjust the seat, steering wheel and mirrors so you can see well and easily reach the pedals and controls:\n- Sit comfortably straight, with your chest at least 10 inches from the steering wheel. This leaves space for the airbag.\n- Set the steering wheel so you can grip it with a gentle bend in your elbow.\n- Set the headrest even with your ears to protect you from whiplash.\n\nA good routine before you drive:\n- Check outside: objects in the tires, broken glass, fluid leaks under the vehicle, and children, pets or other obstacles.\n- Check inside: warnings on the instrument panel, clear windows, and loose items safely secured.\n- Check your adjustments: mirrors set, seat and steering wheel in place, seat belt buckled, phone silenced and put away.\n- Check in with yourself: are you healthy, clear-headed, in control of your emotions and ready to focus on driving?',
   'WA Driver Guide 2.4, Know your vehicle; Functions; Adjustments; 2.5, Driver''s seat; 2.13, Before you go', 'draft'),
  ('wa-your-vehicle-maintenance', 'wa-your-vehicle', 2, 'Tires, windows and headlights',
   E'Making sure your vehicle is safe to drive is your responsibility. A small problem can quickly turn into a bigger, more expensive and more dangerous one, so pay attention to warning lights and follow your owner''s manual for routine maintenance.\n\n- Tire tread: worn tires can slip and slide, especially on wet roads. Tread should not be less than 2/32 of an inch.\n- Tire pressure: low pressure can affect handling. The right pressure is on the Tire and Loading Information label on the edge of the driver''s door, or in the owner''s manual.\n- Windows: keep them clean inside and out, and keep the washer fluid full. Completely clear snow, ice and frost from all windows before you drive. Do not hang things from your mirror or block your view.\n\nWashington law says your headlights must be on from a half hour after sunset to a half hour before sunrise. To make it easier to remember, you can have them on all the time, or whenever it is dark, rainy, snowy, foggy or smoky. Headlights help you see, and they help others see you. Daytime running lights are not as bright as headlights and do not turn on your taillights.\n\nYou can use high beams on open roads without streetlights. Switch back to regular headlights when you are 500 feet from an oncoming vehicle, or 300 feet behind another vehicle.',
   'WA Driver Guide 2.5, Tire tread; Tire pressure; Glass surfaces; Headlights', 'draft'),
  ('wa-your-vehicle-signals', 'wa-your-vehicle', 3, 'Brake lights, signals and hazard lights',
   E'Your brake lights, turn signals and hazard lights let other drivers know what you are doing. Keep all your lights clean, bright, pointing the right way and working. A "lamp out" symbol on your dashboard means it is time to replace a bulb.\n\n- Brake lights are red and must be clearly visible from 100 feet away. They tell the person behind you to slow down and prepare to stop.\n- Signal 100 feet before you turn or change direction. Make it a habit, even when you do not see anyone around, and make sure the signal stops blinking after the turn.\n- If your car malfunctions or you need to make an emergency stop, turn on your flashing hazard lights. They alert other drivers so they can safely go around you.\n\nIf your brake lights or turn signals are not working, use hand signals. Put your left arm out the driver-side window:\n- Slowing or stopping: point your fingers to the ground.\n- Left turn: point your fingers straight out to the left.\n- Right turn: bend your arm so your fingers point to the sky.',
   'WA Driver Guide 2.5, Headlights; Brake lights; Turn signals; Hand signals; Hazard warning lights', 'draft'),
  ('wa-your-vehicle-occupants', 'wa-your-vehicle', 4, 'Seat belts, child seats and airbags',
   E'Buckling up correctly is the most effective thing you can do to protect yourself. In Washington, every person in a moving vehicle must wear a seat belt or be secured in an approved child restraint. It is illegal to drive or ride without one.\n\nWear your belt the right way:\n- The shoulder belt lies snug across the middle of your chest and your shoulder, not across your neck or face. Never put it behind your back or under your arm.\n- The lap belt holds your hips snugly, below your stomach, and rests on your upper thighs.\n- Make sure the belt is not twisted.\n\nChildren need the right seat for their age and size:\n- Up to age 2: a rear-facing car seat.\n- Ages 2 to 4: a car seat with a rear- or forward-facing harness.\n- Age 4 and older: a car seat or booster seat until the lap and shoulder belts fit properly, typically between ages 8 and 12.\n- Old and tall enough for a seat belt (over 4 feet 9 inches): a properly fitting seat belt.\n\nAirbags and seat belts work together. If you are not buckled when an airbag goes off, you risk serious injury or death. Children under 13 should never ride in the front seat, because an airbag could seriously injure or kill them.',
   'WA Driver Guide 2.6, Seat belts and occupant protection; Child seats; Airbags', 'draft'),
  ('wa-your-vehicle-control', 'wa-your-vehicle', 5, 'Steering, braking and reference points',
   E'Hold the outside of the steering wheel on its top half. Picture the wheel as a clock: your hands can be at 9 and 3, or at 10 and 2.\n\n- Hand-to-hand (pull/push): each hand stays on its own side and your hands never cross. This keeps your arms away from the airbag if it goes off.\n- Hand-over-hand: for turning at low speeds, at intersections, when parking, with limited visibility, or when recovering from a skid.\n- One hand: when backing up or reaching for controls like wipers or lights. When backing, hold the wheel at 12 and turn your body to see behind you.\n\nBrake and speed up smoothly, as if you had a cup of water in your lap that you do not want to spill. Ideally you will only need light or medium braking. Unnecessary firm or emergency braking can surprise the people behind you. Antilock brakes (ABS) let you keep steering during emergency braking, but they do not shorten your stopping distance. Regular maintenance, correct tire pressure and alignment checks help keep your vehicle''s weight balanced across the tires.\n\nReference points, like the center of your hood or your side mirrors, help you judge distance when you park, turn, back and stop. They depend on your vehicle and the road.',
   'WA Driver Guide 2.7, Steering; 2.8, Braking; 2.9, Accelerating; 2.10, Balanced weight; 2.11, Vehicle reference points', 'draft'),
  ('wa-your-vehicle-blind-zones', 'wa-your-vehicle', 6, 'Blind zones and safety technology',
   E'Blind zones are the areas around your vehicle you cannot see from the driver''s seat. They can completely hide a vehicle, motorcyclist or bicyclist, and it is your responsibility to be aware of everything in them.\n\n- Adjust your mirrors to shrink your blind zones, and recheck your mirrors every time you get behind the wheel.\n- Mirrors alone are not enough. Move your head, neck and body so both eyes can see that your blind zones are clear. Keep the steering wheel straight while you look.\n- Stay out of other drivers'' blind zones. Speed up or slow down so they can clearly see you.\n- Buses, motorhomes and commercial motor vehicles have bigger blind zones, sometimes called "no zones." If you cannot see their mirrors, the driver cannot see you.\n\nSafety technology, like blind spot detection, lane keeping assistance and automatic emergency braking, can warn you sooner. It assists your good habits but does not replace them, and you are still fully responsible for your vehicle. It also has limits. For example, a blind spot alert cannot detect a vehicle 2 lanes over that is also getting ready to merge, and the technology might not notice people walking, rolling or riding near your vehicle. Dirty sensors or faded road markings can also keep it from working well. Leave these features on unless severe weather makes the alerts a distraction, and still check with your own eyes.',
   'WA Driver Guide 2.12, Your blind zones; 2.13, Other vehicles'' blind zones; 2.4, Vehicle safety technology', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-vehicle-seat-distance', 'wa-your-vehicle-getting-ready', 1,
   'You are adjusting the driver''s seat. How far should your chest be from the steering wheel?',
   'WA Driver Guide 2.5, Driver''s seat', 'draft'),
  ('wa-q-vehicle-before-you-go', 'wa-your-vehicle-getting-ready', 2,
   'You are about to drive. Which of these is part of a good routine before you go?',
   'WA Driver Guide 2.13, Before you go', 'draft'),

  ('wa-q-vehicle-tire-tread', 'wa-your-vehicle-maintenance', 1,
   'Worn tires can slip and slide on wet roads. What is the least amount of tread your tires should have?',
   'WA Driver Guide 2.5, Tire tread', 'draft'),
  ('wa-q-vehicle-headlight-hours', 'wa-your-vehicle-maintenance', 2,
   'Washington law says your headlights must be on during which hours?',
   'WA Driver Guide 2.5, Headlights', 'draft'),
  ('wa-q-vehicle-high-beams', 'wa-your-vehicle-maintenance', 3,
   'You are using high beams on a dark, open road, and a car is coming toward you. When should you switch back to regular headlights?',
   'WA Driver Guide 2.5, Headlights', 'draft'),

  ('wa-q-vehicle-turn-signal', 'wa-your-vehicle-signals', 1,
   'You plan to turn at the next corner. How far ahead of the turn should you start signaling?',
   'WA Driver Guide 2.5, Turn signals', 'draft'),
  ('wa-q-vehicle-hand-signal-right', 'wa-your-vehicle-signals', 2,
   'Your turn signals are not working and you want to turn right. What hand signal do you give?',
   'WA Driver Guide 2.5, Hand signals', 'draft'),
  ('wa-q-vehicle-hazard-lights', 'wa-your-vehicle-signals', 3,
   'Your car malfunctions and you have to make an emergency stop. What should you turn on?',
   'WA Driver Guide 2.5, Hazard warning lights', 'draft'),

  ('wa-q-vehicle-seat-belt-law', 'wa-your-vehicle-occupants', 1,
   'In Washington, who in a moving vehicle must wear a seat belt or ride in an approved child restraint?',
   'WA Driver Guide 2.6, Seat belts and occupant protection', 'draft'),
  ('wa-q-vehicle-rear-facing', 'wa-your-vehicle-occupants', 2,
   'You are giving a ride to a 1-year-old child. What kind of seat must the child ride in?',
   'WA Driver Guide 2.6, Rear-facing', 'draft'),
  ('wa-q-vehicle-front-seat', 'wa-your-vehicle-occupants', 3,
   'Because of airbags, children under what age should never ride in the front seat?',
   'WA Driver Guide 2.6, Airbags', 'draft'),

  ('wa-q-vehicle-push-pull', 'wa-your-vehicle-control', 1,
   'Why is hand-to-hand (pull/push) steering safer if the airbag goes off?',
   'WA Driver Guide 2.7, Hand-to-hand steering (pull/push)', 'draft'),
  ('wa-q-vehicle-abs', 'wa-your-vehicle-control', 2,
   'What does an antilock braking system (ABS) do when you brake hard in an emergency?',
   'WA Driver Guide 2.8, Antilock Braking Systems (ABS)', 'draft'),
  ('wa-q-vehicle-smooth-braking', 'wa-your-vehicle-control', 3,
   'In everyday driving, what kind of braking should you aim for?',
   'WA Driver Guide 2.8, Braking pressure', 'draft'),

  ('wa-q-vehicle-no-zone', 'wa-your-vehicle-blind-zones', 1,
   'You are driving beside a large commercial truck and you cannot see its side mirrors. What does that tell you?',
   'WA Driver Guide 2.13, Other vehicles'' blind zones', 'draft'),
  ('wa-q-vehicle-blind-spot-alert', 'wa-your-vehicle-blind-zones', 2,
   'Your car has a blind spot warning, and it shows no alert. You want to change lanes. What should you do?',
   'WA Driver Guide 2.12, Your blind zones; 2.4, Vehicle safety technology', 'draft'),
  ('wa-q-vehicle-head-check', 'wa-your-vehicle-blind-zones', 3,
   'You turn your head to check your blind zone. What should you do with the steering wheel while you look?',
   'WA Driver Guide 2.12, Your blind zones', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-vehicle-seat-distance-a', 'wa-q-vehicle-seat-distance', 1, 'At least 2 inches', false,
   'That is much too close. Keep your chest at least 10 inches from the wheel to leave space for the airbag.'),
  ('wa-q-vehicle-seat-distance-b', 'wa-q-vehicle-seat-distance', 2, 'At least 6 inches', false,
   'Not quite. Your chest should be at least 10 inches from the wheel, so the airbag has room.'),
  ('wa-q-vehicle-seat-distance-c', 'wa-q-vehicle-seat-distance', 3, 'At least 10 inches', true,
   'Right. Sitting at least 10 inches from the steering wheel leaves space for the airbag.'),
  ('wa-q-vehicle-seat-distance-d', 'wa-q-vehicle-seat-distance', 4, 'As close as you can get', false,
   'Sitting very close is not safe. Leave at least 10 inches so the airbag has space.'),

  ('wa-q-vehicle-before-you-go-a', 'wa-q-vehicle-before-you-go', 1, 'Check under the vehicle for fluid leaks', true,
   'Right. Checking outside your vehicle for leaks, objects in the tires and other obstacles is a good first step.'),
  ('wa-q-vehicle-before-you-go-b', 'wa-q-vehicle-before-you-go', 2, 'Leave loose items on the seat to grab later', false,
   'Not quite. Loose items should be safely secured before you drive.'),
  ('wa-q-vehicle-before-you-go-c', 'wa-q-vehicle-before-you-go', 3, 'Keep your phone out so you can see texts', false,
   'Your phone should be silenced and put away before you start driving.'),
  ('wa-q-vehicle-before-you-go-d', 'wa-q-vehicle-before-you-go', 4, 'Set your mirrors once you are moving', false,
   'Set your mirrors before you go, along with your seat and steering wheel.'),

  ('wa-q-vehicle-tire-tread-a', 'wa-q-vehicle-tire-tread', 1, '1/32 of an inch', false,
   'Not quite. That is too worn. Tire tread should not be less than 2/32 of an inch.'),
  ('wa-q-vehicle-tire-tread-b', 'wa-q-vehicle-tire-tread', 2, '1/64 of an inch', false,
   'That is far too worn. Tire tread should not be less than 2/32 of an inch.'),
  ('wa-q-vehicle-tire-tread-c', 'wa-q-vehicle-tire-tread', 3, 'None, if the tire still holds air', false,
   'Worn tires can slip and slide, especially on wet roads. Tread should not be less than 2/32 of an inch.'),
  ('wa-q-vehicle-tire-tread-d', 'wa-q-vehicle-tire-tread', 4, '2/32 of an inch', true,
   'Right. Tire tread should not be less than 2/32 of an inch.'),

  ('wa-q-vehicle-headlight-hours-a', 'wa-q-vehicle-headlight-hours', 1, 'Only when the streetlights are off', false,
   'Streetlights do not decide it. The law says from a half hour after sunset to a half hour before sunrise.'),
  ('wa-q-vehicle-headlight-hours-b', 'wa-q-vehicle-headlight-hours', 2, 'From a half hour after sunset to a half hour before sunrise', true,
   'Right. That is what the law says, and it may be easier to just keep your headlights on all the time.'),
  ('wa-q-vehicle-headlight-hours-c', 'wa-q-vehicle-headlight-hours', 3, 'From an hour after sunset to an hour before sunrise', false,
   'Not quite. The law says a half hour after sunset to a half hour before sunrise, not a full hour.'),
  ('wa-q-vehicle-headlight-hours-d', 'wa-q-vehicle-headlight-hours', 4, 'Only when it is raining, snowing or foggy', false,
   'Headlights are a good idea in bad weather too, but the law also requires them from a half hour after sunset to a half hour before sunrise.'),

  ('wa-q-vehicle-high-beams-a', 'wa-q-vehicle-high-beams', 1, 'When it is 100 feet from you', false,
   'That is too late. Switch back to regular headlights when you are 500 feet from an oncoming vehicle.'),
  ('wa-q-vehicle-high-beams-b', 'wa-q-vehicle-high-beams', 2, 'When it is 500 feet from you', true,
   'Right. Switch back when you are 500 feet from an oncoming vehicle, and 300 feet when you are behind a vehicle.'),
  ('wa-q-vehicle-high-beams-c', 'wa-q-vehicle-high-beams', 3, 'Only after it has passed you', false,
   'Waiting until it passes is too late. Switch back when you are 500 feet from an oncoming vehicle.'),
  ('wa-q-vehicle-high-beams-d', 'wa-q-vehicle-high-beams', 4, 'When it is 300 feet from you', false,
   'Not quite. 300 feet is for a vehicle you are driving behind. For an oncoming vehicle, switch back at 500 feet.'),

  ('wa-q-vehicle-turn-signal-a', 'wa-q-vehicle-turn-signal', 1, 'Just as you start to turn', false,
   'That gives others almost no warning. Signal 100 feet before you make your move.'),
  ('wa-q-vehicle-turn-signal-b', 'wa-q-vehicle-turn-signal', 2, '25 feet before the turn', false,
   'That is too short. Signal 100 feet before you turn.'),
  ('wa-q-vehicle-turn-signal-c', 'wa-q-vehicle-turn-signal', 3, '50 feet before the turn', false,
   'Not quite. Signal 100 feet before you make your move.'),
  ('wa-q-vehicle-turn-signal-d', 'wa-q-vehicle-turn-signal', 4, '100 feet before the turn', true,
   'Right. Signal 100 feet before you turn, even when you do not see anyone else around.'),

  ('wa-q-vehicle-hand-signal-right-a', 'wa-q-vehicle-hand-signal-right', 1, 'Left arm straight out, fingers pointing left', false,
   'That is the hand signal for a left turn.'),
  ('wa-q-vehicle-hand-signal-right-b', 'wa-q-vehicle-hand-signal-right', 2, 'Left arm out, fingers pointing to the ground', false,
   'That signal tells the driver behind you to slow down and prepare to stop.'),
  ('wa-q-vehicle-hand-signal-right-c', 'wa-q-vehicle-hand-signal-right', 3, 'Left arm out, bent so your fingers point up', true,
   'Right. For a right turn, put your left arm out the window and bend it so your fingers point to the sky.'),
  ('wa-q-vehicle-hand-signal-right-d', 'wa-q-vehicle-hand-signal-right', 4, 'Right arm out the passenger-side window', false,
   'Not quite. Hand signals are given with your left arm out the driver-side window.'),

  ('wa-q-vehicle-hazard-lights-a', 'wa-q-vehicle-hazard-lights', 1, 'Your flashing hazard lights', true,
   'Right. Hazard lights alert other drivers to your situation so they can safely go around you.'),
  ('wa-q-vehicle-hazard-lights-b', 'wa-q-vehicle-hazard-lights', 2, 'Your high beams', false,
   'High beams are for open roads without streetlights. Flashing hazard lights are what alert other drivers.'),
  ('wa-q-vehicle-hazard-lights-c', 'wa-q-vehicle-hazard-lights', 3, 'Your right turn signal', false,
   'A turn signal tells others you are about to change direction. Use your flashing hazard lights for an emergency stop.'),

  ('wa-q-vehicle-seat-belt-law-a', 'wa-q-vehicle-seat-belt-law', 1, 'Only the driver and front seat passenger', false,
   'Not quite. The law covers every person in the vehicle, front and back.'),
  ('wa-q-vehicle-seat-belt-law-b', 'wa-q-vehicle-seat-belt-law', 2, 'Every person in the vehicle', true,
   'Right. Every person in a moving vehicle must wear a seat belt or be fastened into an approved child restraint.'),
  ('wa-q-vehicle-seat-belt-law-c', 'wa-q-vehicle-seat-belt-law', 3, 'Only passengers under age 16', false,
   'Not quite. The rule applies to every person in a moving vehicle, including adults and the driver.'),

  ('wa-q-vehicle-rear-facing-a', 'wa-q-vehicle-rear-facing', 1, 'A booster seat', false,
   'Booster seats are for children age 4 and older. Children up to age 2 must ride in a rear-facing car seat.'),
  ('wa-q-vehicle-rear-facing-b', 'wa-q-vehicle-rear-facing', 2, 'A forward-facing car seat', false,
   'Not yet. Children up to age 2 must ride in a rear-facing car seat.'),
  ('wa-q-vehicle-rear-facing-c', 'wa-q-vehicle-rear-facing', 3, 'A seat belt in the back seat', false,
   'A seat belt alone is for people old and tall enough for it to fit, over 4 feet 9 inches. Children up to age 2 must ride in a rear-facing car seat.'),
  ('wa-q-vehicle-rear-facing-d', 'wa-q-vehicle-rear-facing', 4, 'A rear-facing car seat', true,
   'Right. Children up to age 2 must ride in a rear-facing car seat.'),

  ('wa-q-vehicle-front-seat-a', 'wa-q-vehicle-front-seat', 1, 'Under 8', false,
   'Not quite. Children under 13 should never ride in the front seat, because an airbag could seriously injure them.'),
  ('wa-q-vehicle-front-seat-b', 'wa-q-vehicle-front-seat', 2, 'Under 10', false,
   'Not quite. The age is 13. Children under 13 should never ride in the front seat.'),
  ('wa-q-vehicle-front-seat-c', 'wa-q-vehicle-front-seat', 3, 'Under 13', true,
   'Right. Children under 13 should never ride in the front seat. They could be seriously injured or killed if an airbag goes off.'),
  ('wa-q-vehicle-front-seat-d', 'wa-q-vehicle-front-seat', 4, 'Under 16', false,
   'Not quite. The age is 13. Children under 13 should never ride in the front seat.'),

  ('wa-q-vehicle-push-pull-a', 'wa-q-vehicle-push-pull', 1, 'It lets you steer with one hand', false,
   'Not quite. Hand-to-hand steering keeps both of your hands on the wheel.'),
  ('wa-q-vehicle-push-pull-b', 'wa-q-vehicle-push-pull', 2, 'Your hands never cross over the wheel', true,
   'Right. Because your hands never cross, your arms stay away from the airbag area, so there is less chance of injury.'),
  ('wa-q-vehicle-push-pull-c', 'wa-q-vehicle-push-pull', 3, 'It makes the airbag open more slowly', false,
   'Not quite. The safety benefit is that your hands never cross over the wheel, so there is less chance of injury to your face, hands or arms if the airbag goes off.'),

  ('wa-q-vehicle-abs-a', 'wa-q-vehicle-abs', 1, 'It lets you keep steering control', true,
   'Right. ABS lets you steer during emergency braking. You may feel the vehicle shake a bit while it works.'),
  ('wa-q-vehicle-abs-b', 'wa-q-vehicle-abs', 2, 'It shortens your stopping distance', false,
   'Not quite. ABS does not shorten your stopping distance. It helps you keep better steering control.'),
  ('wa-q-vehicle-abs-c', 'wa-q-vehicle-abs', 3, 'It keeps the vehicle from shaking', false,
   'It is the opposite. You may feel your vehicle shake a bit when ABS is working.'),

  ('wa-q-vehicle-smooth-braking-a', 'wa-q-vehicle-smooth-braking', 1, 'Firm braking, to stop as fast as you can', false,
   'Firm braking is there when you need it, but unnecessary firm braking can surprise the people behind you.'),
  ('wa-q-vehicle-smooth-braking-b', 'wa-q-vehicle-smooth-braking', 2, 'Emergency braking, so the ABS can help', false,
   'Not quite. Unnecessary emergency braking can surprise the people behind you, who expect a smooth stop.'),
  ('wa-q-vehicle-smooth-braking-c', 'wa-q-vehicle-smooth-braking', 3, 'Smooth, light or medium braking', true,
   'Right. Ideally you only need light and medium braking. Brake as if you had a cup of water in your lap you do not want to spill.'),

  ('wa-q-vehicle-no-zone-a', 'wa-q-vehicle-no-zone', 1, 'The driver can see you clearly', false,
   'It is the opposite. If you cannot see their mirrors, the driver cannot see you.'),
  ('wa-q-vehicle-no-zone-b', 'wa-q-vehicle-no-zone', 2, 'The driver cannot see you', true,
   'Right. You are in a blind zone, or "no zone." Speed up or slow down so the driver can clearly see you.'),
  ('wa-q-vehicle-no-zone-c', 'wa-q-vehicle-no-zone', 3, 'You are at a safe distance', false,
   'Not quite. Not seeing the mirrors means the driver cannot see you. Speed up or slow down to get out of the blind zone.'),

  ('wa-q-vehicle-blind-spot-alert-a', 'wa-q-vehicle-blind-spot-alert', 1, 'Change lanes, since the system says it is clear', false,
   'Not quite. These systems have limits. For example, they cannot detect a vehicle 2 lanes over that is also getting ready to merge.'),
  ('wa-q-vehicle-blind-spot-alert-b', 'wa-q-vehicle-blind-spot-alert', 2, 'Turn the warning off so it does not distract you', false,
   'Leave safety features on unless severe weather makes the alerts a distraction, and still check with your own eyes.'),
  ('wa-q-vehicle-blind-spot-alert-c', 'wa-q-vehicle-blind-spot-alert', 3, 'Check only your rearview mirror', false,
   'Not quite. Move your head, neck and body so both eyes can see that your blind zones are clear.'),
  ('wa-q-vehicle-blind-spot-alert-d', 'wa-q-vehicle-blind-spot-alert', 4, 'Still turn your head and check for yourself', true,
   'Right. The alert is helpful, but make a habit of using your own eyes to check your blind zones.'),

  ('wa-q-vehicle-head-check-a', 'wa-q-vehicle-head-check', 1, 'Keep it straight', true,
   'Right. When you turn your head to look, keep the steering wheel straight.'),
  ('wa-q-vehicle-head-check-b', 'wa-q-vehicle-head-check', 2, 'Turn it slightly toward that lane', false,
   'Not quite. Keep the steering wheel straight while you turn your head to look.'),
  ('wa-q-vehicle-head-check-c', 'wa-q-vehicle-head-check', 3, 'Let go of it for a moment', false,
   'Not quite. When you turn your head to look, keep the steering wheel straight.'),
  ('wa-q-vehicle-head-check-d', 'wa-q-vehicle-head-check', 4, 'Hold it with one hand at 12', false,
   'The 12 position is for backing up. When you check your blind zone, keep the wheel straight.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
