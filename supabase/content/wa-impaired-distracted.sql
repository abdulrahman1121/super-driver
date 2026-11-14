-- Lesson 11: Impaired and distracted driving (WA Driver Guide 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6).
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
  ('wa-impaired-distracted', 11, 'Impaired and distracted driving',
   'How your health, alcohol, drugs, tiredness, emotions and phone can affect your driving, and how to stay focused.',
   'WA Driver Guide 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-impaired-distracted-fit', 'wa-impaired-distracted', 1, 'Fit to drive: health, vision and hearing',
   E'Driving requires you to be physically and mentally fit. A bad cold can slow your thinking. A headache or tense shoulders can make it harder to handle the car. Stress can make it harder to make wise decisions behind the wheel. Before you start the engine, check in with yourself. If you are not feeling well but need to go somewhere, let someone else drive.\n\nVision:\n- You must pass a vision test before you get your driver license.\n- If you are required to wear corrective lenses, always wear them when driving.\n- Avoid dark or tinted corrective lenses at night.\n\nAt night:\n- Make sure your headlights are on and properly aimed.\n- To avoid the glare of oncoming lights, watch the right edge of the road and use it as a steering guide.\n- Slow down and leave more following distance. You should be able to stop inside the area your headlights light up.\n\nHearing: horns, sirens and screeching tires can warn you of danger. It is against the law to drive while wearing earbuds, earphones, headphones or headsets that broadcast sound or cancel noise. You can use a hands-free device in one ear if it meets the state rule for these devices (WAC 204-10-045). But if you have an instruction permit or intermediate license, you cannot use a cell phone or any mobile electronic device while driving, even hands-free.',
   'WA Driver Guide 3.0, Health; Vision; Seeing at night; Hearing', 'draft'),
  ('wa-impaired-distracted-substances', 'wa-impaired-distracted', 2, 'Alcohol, cannabis and medicines',
   E'Impaired driving happens when anything makes it hard for you to think straight, respond quickly or control your car. Alcohol is the most common substance involved in impaired driving crashes. It can cause drowsiness, blurry vision, slower reactions and overconfidence that can lead to risky driving. Even an experienced driver cannot drive safely after drinking alcohol or using drugs.\n\nCannabis is legal for adults 21 and over, but driving after using any cannabis is illegal for all ages. There is no safe amount of cannabis for driving.\n\nLegal medicines can impair you too:\n- Just because a drug is legal does not mean it is safe to use while driving.\n- Over-the-counter drugs for headaches, colds or allergies can make you drowsy.\n- Do not drive if you just started a new prescription or a higher dose. Wait until you know how it affects you, and talk to your doctor or pharmacist.\n- A label warning against "operating heavy machinery" includes driving.\n\nMixing alcohol, cannabis or other drugs can cause effects greater than any one drug on its own. This is called polydrug use, and it is the most common impairment involved in fatal crashes.\n\nPenalties for driving under the influence of alcohol or drugs are tough: expensive fines, higher insurance rates, license suspension and even jail. Plan for a sober driver, and never ride with a driver who has had any amount of an impairing substance.',
   'WA Driver Guide 3.1, Alcohol and driving; Cannabis and driving; Medications and driving; Polydrug use and driving', 'draft'),
  ('wa-impaired-distracted-drowsy', 'wa-impaired-distracted', 3, 'Drowsy driving',
   E'Fatigue comes from physical or mental strain, repetitive tasks, illness or lack of sleep. Like alcohol and drugs, it hurts your vision and judgment, and you risk falling asleep at the wheel.\n\nPull over and rest if you:\n- Have trouble focusing, or cannot remember driving the last few miles\n- Blink often or have heavy eyelids\n- Drift from your lane, swerve, tailgate or hit rumble strips\n- Have trouble keeping your head up\n- Miss exits or traffic signs\n- Feel restless, irritable or aggressive\n\nIf you are traveling with another driver, take turns driving. If you are alone and start to feel tired, pull off the road and take a 20-minute nap. It is better to stop and sleep than to risk a crash.\n\nBefore a trip:\n- Get enough sleep. Most people need 7 to 9 hours to stay alert.\n- Plan to stop about every 100 miles or 2 hours during long trips.\n- Plan your trip with plenty of time for breaks. Walk around, get some fresh air and drink some water.\n- Bring a travel companion who can help you stay alert and share the driving.',
   'WA Driver Guide 3.1, Fatigue and drowsy driving', 'draft'),
  ('wa-impaired-distracted-emotions', 'wa-impaired-distracted', 4, 'Emotions, aggressive driving and road rage',
   E'Emotions can affect your driving. If you feel anxious, for example, you might press too hard on the gas pedal. To calm down before a drive, try this in a parked car: breathe in through your nose and out like you are cooling hot soup, or count slowly from 1 to 20. Leave plenty of time for your trip.\n\nAggressive driving is a traffic offense. It means purposely doing something that puts people or property in danger. Behaviors linked to aggressive driving include speeding, following too close, unsafe lane changes, improper signaling, not obeying traffic signals, signs and road markings, and driving too close to someone walking or cycling along the road. Street racing can lead to fines, jail time and having your vehicle impounded.\n\nRoad rage is a criminal offense. It is an angry response that leads to violent behavior with a vehicle or other weapon.\n\nIf another driver acts in anger toward you:\n- Take a deep breath, move out of the way and keep your distance.\n- Avoid aggressive speeding, honking or hand gestures.\n- Keep your eyes on the road.\n- If you feel you are being followed or harassed, drive to an area with other people and open businesses.\n- Call the police if necessary. Report road rage that is happening now by calling 911.',
   'WA Driver Guide 3.1, Mental health; Aggressive driving; Racing and street demonstrations; Road rage; If you are the victim of road rage; Reporting road rage', 'draft'),
  ('wa-impaired-distracted-phones', 'wa-impaired-distracted', 5, 'Distractions and your phone',
   E'Distracted driving is any activity that takes your attention away from driving. Distractions can come from:\n- Inside the vehicle: cell phones, eating, adjusting the radio, interacting with passengers\n- Outside the vehicle: billboards, crashes, other people''s behavior\n- Your body: fatigue, discomfort, physical impairments\n- Your mind: daydreaming, worrying, strong emotions\n\nDistracted drivers are more likely to swerve out of their lane, speed or drive too slowly, follow too closely, and miss traffic signals, stop signs, motorcyclists, bicyclists or pedestrians.\n\nWashington''s distracted driving law:\n- You cannot hold any electronic device while driving, such as a phone, tablet or gaming device. This applies to all drivers, regardless of age or experience.\n- If you have an instruction permit or intermediate license, you cannot use a cell phone or any mobile electronic device while driving, even hands-free. With an intermediate license, you can only use your phone to report an emergency.\n- Other drivers may use hands-free devices, but anything that takes your eyes and mind off the road can still be dangerous.\n- A ticket can mean heavy fines, and fines after your first violation can be doubled.\n\nPlan ahead, put your phone away and stay observant.',
   'WA Driver Guide 3.4, Washington''s distracted driving laws; 3.0, Hearing; 1.8, Intermediate driver license', 'draft'),
  ('wa-impaired-distracted-alert', 'wa-impaired-distracted', 6, 'Stay alert and make good decisions',
   E'Every action behind the wheel is a decision. If you are a teen, remember that the part of your brain responsible for judgment and decision making is still developing. Put safety ahead of speed and social pressure.\n\nWhen something changes on the road, you can use the OODA loop:\n- Observe: what changed?\n- Orient: what does the change mean for your safety and the safety of others?\n- Decide: choose the safest action, such as slowing down, changing lanes or signaling.\n- Act: do it smoothly and decisively, and communicate clearly so others understand what you intend to do.\n\nKeep searching and scanning:\n- Ahead: look beyond the vehicle in front of you, and watch for feet, wheels, shadows and movement in, under and around parked vehicles.\n- To the sides: at intersections, watch for vehicles, pedestrians and cyclists coming from the left and right. Before turning, check your side mirrors and look over your shoulder.\n- Behind: check before you change lanes, turn across a bike lane, slow down or back up.\n\nAfter each drive, ask yourself: Did anything surprise me? Did I surprise anyone? Was my driving legal and smooth? What should I change next time?',
   'WA Driver Guide 3.2, Why informed decisions matter; 3.3, Problem solving on the road; 3.5, Visually search and scan; 3.6, Self-evaluation', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-impaired-night-glare', 'wa-impaired-distracted-fit', 1,
   'At night, the headlights of oncoming cars are bothering your eyes. What should you do?',
   'WA Driver Guide 3.0, Seeing at night', 'draft'),
  ('wa-q-impaired-night-stop', 'wa-impaired-distracted-fit', 2,
   'You are driving on a dark road at night. How should you choose your speed?',
   'WA Driver Guide 3.0, Seeing at night', 'draft'),
  ('wa-q-impaired-earbuds', 'wa-impaired-distracted-fit', 3,
   'Is it legal to drive while wearing noise-canceling headphones?',
   'WA Driver Guide 3.0, Hearing', 'draft'),

  ('wa-q-impaired-cannabis', 'wa-impaired-distracted-substances', 1,
   'You are over 21 and just used cannabis legally. Is it legal for you to drive?',
   'WA Driver Guide 3.1, Cannabis and driving', 'draft'),
  ('wa-q-impaired-new-medicine', 'wa-impaired-distracted-substances', 2,
   'Your doctor just prescribed a new medicine for you. What should you do about driving?',
   'WA Driver Guide 3.1, Medications and driving', 'draft'),
  ('wa-q-impaired-heavy-machinery', 'wa-impaired-distracted-substances', 3,
   'A medicine label warns against operating heavy machinery. Does this warning apply to driving a car?',
   'WA Driver Guide 3.1, Medications and driving', 'draft'),

  ('wa-q-impaired-fatigue-sign', 'wa-impaired-distracted-drowsy', 1,
   'Which of these is a sign of fatigue that means you should pull over and rest?',
   'WA Driver Guide 3.1, Fatigue and drowsy driving', 'draft'),
  ('wa-q-impaired-tired-alone', 'wa-impaired-distracted-drowsy', 2,
   'You are driving alone on a long trip and start to feel sleepy. What is the safest choice?',
   'WA Driver Guide 3.1, Fatigue and drowsy driving', 'draft'),
  ('wa-q-impaired-break-often', 'wa-impaired-distracted-drowsy', 3,
   'On a long trip, how often should you plan to stop for a break?',
   'WA Driver Guide 3.1, Fatigue and drowsy driving', 'draft'),

  ('wa-q-impaired-aggressive', 'wa-impaired-distracted-emotions', 1,
   'Which of these is a behavior linked to aggressive driving?',
   'WA Driver Guide 3.1, Aggressive driving', 'draft'),
  ('wa-q-impaired-honk-back', 'wa-impaired-distracted-emotions', 2,
   'After you change lanes, another driver honks and yells at you. What is the best response?',
   'WA Driver Guide 3.1, If you are the victim of road rage', 'draft'),
  ('wa-q-impaired-followed', 'wa-impaired-distracted-emotions', 3,
   'You think an angry driver is following you. What should you do?',
   'WA Driver Guide 3.1, If you are the victim of road rage; Reporting road rage', 'draft'),

  ('wa-q-impaired-hold-phone', 'wa-impaired-distracted-phones', 1,
   'You are an adult with a regular driver license. May you hold your phone while you drive?',
   'WA Driver Guide 3.4, Washington''s distracted driving laws', 'draft'),
  ('wa-q-impaired-permit-handsfree', 'wa-impaired-distracted-phones', 2,
   'You have an instruction permit. May you talk on a hands-free phone while driving?',
   'WA Driver Guide 3.0, Hearing', 'draft'),
  ('wa-q-impaired-repeat-fine', 'wa-impaired-distracted-phones', 3,
   'You already got one distracted driving ticket. What can happen to the fine for a later one?',
   'WA Driver Guide 3.4, Washington''s distracted driving laws', 'draft'),

  ('wa-q-impaired-over-shoulder', 'wa-impaired-distracted-alert', 1,
   'You are about to turn. How should you check for bicyclists or pedestrians next to you?',
   'WA Driver Guide 3.5, Scan to the side', 'draft'),
  ('wa-q-impaired-parked-cars', 'wa-impaired-distracted-alert', 2,
   'You are driving past a row of parked cars. What should you watch for?',
   'WA Driver Guide 3.5, Scan to the front', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-impaired-night-glare-a', 'wa-q-impaired-night-glare', 1, 'Look straight at the oncoming headlights', false,
   'Not quite. To avoid the glare, watch the right edge of the road instead and use it as a steering guide.'),
  ('wa-q-impaired-night-glare-b', 'wa-q-impaired-night-glare', 2, 'Watch the right edge of the road and steer by it', true,
   'Right. Watching the right edge of the road, and using it as a steering guide, helps you avoid the glare of oncoming lights.'),
  ('wa-q-impaired-night-glare-c', 'wa-q-impaired-night-glare', 3, 'Switch to tinted glasses for the drive', false,
   'Avoid dark or tinted corrective lenses at night. Watch the right edge of the road instead.'),
  ('wa-q-impaired-night-glare-d', 'wa-q-impaired-night-glare', 4, 'Speed up so the other car passes sooner', false,
   'At night you should reduce your speed, not increase it. Watch the right edge of the road to avoid the glare.'),

  ('wa-q-impaired-night-stop-a', 'wa-q-impaired-night-stop', 1, 'The same speed you would drive in daylight', false,
   'Not quite. At night, reduce your speed and increase your following distance.'),
  ('wa-q-impaired-night-stop-b', 'wa-q-impaired-night-stop', 2, 'Fast enough to keep up with the car ahead', false,
   'Keeping up is not the goal. At night, slow down and leave more following distance.'),
  ('wa-q-impaired-night-stop-c', 'wa-q-impaired-night-stop', 3, 'Slow enough to stop inside the area your headlights light up', true,
   'Right. Reduce your speed at night. You should be able to stop inside the lit area created by your headlights.'),

  ('wa-q-impaired-earbuds-a', 'wa-q-impaired-earbuds', 1, 'Yes, as long as no music is playing', false,
   'Not quite. Headphones that cancel noise are against the law while driving, even with no music playing.'),
  ('wa-q-impaired-earbuds-b', 'wa-q-impaired-earbuds', 2, 'Yes, if you keep the volume low', false,
   'Volume does not matter. It is against the law to drive wearing headphones that broadcast sound or cancel noise.'),
  ('wa-q-impaired-earbuds-c', 'wa-q-impaired-earbuds', 3, 'Yes, but only on the highway', false,
   'The rule is not limited to certain roads. You may not drive wearing headphones that broadcast sound or cancel noise.'),
  ('wa-q-impaired-earbuds-d', 'wa-q-impaired-earbuds', 4, 'No, it is against the law', true,
   'Right. It is against the law to drive while wearing earbuds, earphones, headphones or headsets that broadcast sound or cancel noise.'),

  ('wa-q-impaired-cannabis-a', 'wa-q-impaired-cannabis', 1, 'Yes, because you are over 21', false,
   'Not quite. Cannabis is legal for adults 21 and over, but driving after using any cannabis is illegal for all ages.'),
  ('wa-q-impaired-cannabis-b', 'wa-q-impaired-cannabis', 2, 'Yes, if you only used a small amount', false,
   'There is no safe amount of cannabis for driving, and driving after using any cannabis is illegal.'),
  ('wa-q-impaired-cannabis-c', 'wa-q-impaired-cannabis', 3, 'No, driving after using any cannabis is illegal', true,
   'Right. Driving after using any cannabis is illegal for all ages. There is no safe amount of cannabis for driving.'),
  ('wa-q-impaired-cannabis-d', 'wa-q-impaired-cannabis', 4, 'Yes, if it was an edible and not smoked', false,
   'Edibles are cannabis products too. Driving after using any cannabis is illegal for all ages.'),

  ('wa-q-impaired-new-medicine-a', 'wa-q-impaired-new-medicine', 1, 'Wait to drive until you know how it affects you', true,
   'Right. Do not drive when you start a new prescription. Wait until you know how it affects your judgment, coordination and reaction time.'),
  ('wa-q-impaired-new-medicine-b', 'wa-q-impaired-new-medicine', 2, 'Drive as usual, since it is a legal prescription', false,
   'Not quite. Just because a drug is legal does not mean it is safe to use while driving.'),
  ('wa-q-impaired-new-medicine-c', 'wa-q-impaired-new-medicine', 3, 'Drive, but only on short trips near home', false,
   'A short trip is still driving. Do not drive until you know how the new medicine affects you.'),
  ('wa-q-impaired-new-medicine-d', 'wa-q-impaired-new-medicine', 4, 'Drive, but only during the daytime', false,
   'Not quite. Do not drive at all until you know how the new medicine affects you.'),

  ('wa-q-impaired-heavy-machinery-a', 'wa-q-impaired-heavy-machinery', 1, 'No, it only means equipment like bulldozers', false,
   'Not quite. Warnings against operating heavy machinery include driving a vehicle.'),
  ('wa-q-impaired-heavy-machinery-b', 'wa-q-impaired-heavy-machinery', 2, 'Yes, driving a car counts', true,
   'Right. Warnings against operating heavy machinery include driving a vehicle. Read all warning labels before you drive.'),
  ('wa-q-impaired-heavy-machinery-c', 'wa-q-impaired-heavy-machinery', 3, 'Only if you drive a large truck', false,
   'The warning covers driving any vehicle, including a regular car.'),

  ('wa-q-impaired-fatigue-sign-a', 'wa-q-impaired-fatigue-sign', 1, 'You cannot remember driving the last few miles', true,
   'Right. Trouble focusing, or not remembering the last few miles, is a sign of fatigue. Pull over and rest.'),
  ('wa-q-impaired-fatigue-sign-b', 'wa-q-impaired-fatigue-sign', 2, 'You check your mirrors every so often', false,
   'Checking your mirrors is a good habit, not a sign of fatigue.'),
  ('wa-q-impaired-fatigue-sign-c', 'wa-q-impaired-fatigue-sign', 3, 'You keep a steady speed in the middle of your lane', false,
   'That is normal driving. Signs of fatigue include drifting from your lane, swerving and hitting rumble strips.'),

  ('wa-q-impaired-tired-alone-a', 'wa-q-impaired-tired-alone', 1, 'Turn up the music and keep going', false,
   'Not quite. If you start to feel tired while traveling alone, pull off the road and take a 20-minute nap.'),
  ('wa-q-impaired-tired-alone-b', 'wa-q-impaired-tired-alone', 2, 'Speed up so you arrive sooner', false,
   'Not quite. Getting there sooner does not help. It is better to stop and sleep than to risk a crash.'),
  ('wa-q-impaired-tired-alone-c', 'wa-q-impaired-tired-alone', 3, 'Open the window and push through', false,
   'Driving tired risks falling asleep at the wheel. Pull off the road and take a 20-minute nap.'),
  ('wa-q-impaired-tired-alone-d', 'wa-q-impaired-tired-alone', 4, 'Pull off the road and take a 20-minute nap', true,
   'Right. If you are traveling alone and start to feel tired, pull off the road and take a 20-minute nap. It is better to stop and sleep than to risk a crash.'),

  ('wa-q-impaired-break-often-a', 'wa-q-impaired-break-often', 1, 'About every 300 miles or 5 hours', false,
   'That is too long between breaks. Plan to stop about every 100 miles or 2 hours.'),
  ('wa-q-impaired-break-often-b', 'wa-q-impaired-break-often', 2, 'About every 100 miles or 2 hours', true,
   'Right. On long trips, plan to stop about every 100 miles or 2 hours, and plan your trip with plenty of time for breaks.'),
  ('wa-q-impaired-break-often-c', 'wa-q-impaired-break-often', 3, 'Only when you need fuel', false,
   'Not quite. Plan regular breaks, about every 100 miles or 2 hours.'),
  ('wa-q-impaired-break-often-d', 'wa-q-impaired-break-often', 4, 'About every 200 miles or 4 hours', false,
   'That is too long between breaks. Plan to stop about every 100 miles or 2 hours.'),

  ('wa-q-impaired-aggressive-a', 'wa-q-impaired-aggressive', 1, 'Leaving extra space around your car', false,
   'Leaving space around your car is a safe habit. Aggressive driving means purposely doing something that endangers people or property.'),
  ('wa-q-impaired-aggressive-b', 'wa-q-impaired-aggressive', 2, 'Signaling before you change lanes', false,
   'Signaling properly is safe driving. It is improper signaling that is linked to aggressive driving.'),
  ('wa-q-impaired-aggressive-c', 'wa-q-impaired-aggressive', 3, 'Driving too close to someone riding a bike', true,
   'Right. Driving too close to someone walking or cycling along the road is linked to aggressive driving, which is a traffic offense.'),
  ('wa-q-impaired-aggressive-d', 'wa-q-impaired-aggressive', 4, 'Slowing down in heavy traffic', false,
   'Slowing down for traffic is not aggressive. Aggressive driving means purposely doing something that endangers people or property.'),

  ('wa-q-impaired-honk-back-a', 'wa-q-impaired-honk-back', 1, 'Honk back so they know how you feel', false,
   'Not quite. Avoid aggressive honking or hand gestures. Take a deep breath and move out of the way.'),
  ('wa-q-impaired-honk-back-b', 'wa-q-impaired-honk-back', 2, 'Get in front of them and slow down', false,
   'Not quite. Passing someone and then slowing down to teach them a lesson is a sign that you may be having feelings of road rage. Distance yourself instead.'),
  ('wa-q-impaired-honk-back-c', 'wa-q-impaired-honk-back', 3, 'Take a breath and move out of the way', true,
   'Right. When another driver acts in anger, take a deep breath, move out of the way and keep your eyes on the road.'),
  ('wa-q-impaired-honk-back-d', 'wa-q-impaired-honk-back', 4, 'Follow them to tell them they are wrong', false,
   'Not quite. Avoid conflict, no matter whose fault it is, and distance yourself from angry drivers.'),

  ('wa-q-impaired-followed-a', 'wa-q-impaired-followed', 1, 'Pull over on a quiet side street to let them pass', false,
   'Not quite. Drive to an area where there are other people and open businesses, not a quiet spot.'),
  ('wa-q-impaired-followed-b', 'wa-q-impaired-followed', 2, 'Stop and get out to talk it over with them', false,
   'Avoid conflict, no matter whose fault it is. Drive to an area with other people and open businesses.'),
  ('wa-q-impaired-followed-c', 'wa-q-impaired-followed', 3, 'Speed up and weave through traffic to lose them', false,
   'Not quite. Avoid aggressive speeding. Weaving in and out of traffic is one sign that you may be having feelings of road rage. Drive to an area with other people and open businesses instead.'),
  ('wa-q-impaired-followed-d', 'wa-q-impaired-followed', 4, 'Drive to an area with other people and open businesses', true,
   'Right. If you feel you are being followed or harassed, drive to an area where there are other people and open businesses. Call the police if necessary, and report road rage that is happening now by calling 911.'),

  ('wa-q-impaired-hold-phone-a', 'wa-q-impaired-hold-phone', 1, 'Yes, adults with driving experience may', false,
   'Not quite. The rule applies to all drivers, regardless of age or experience.'),
  ('wa-q-impaired-hold-phone-b', 'wa-q-impaired-hold-phone', 2, 'No, no driver may hold one while driving', true,
   'Right. In Washington you cannot hold any electronic device while driving, such as a phone, tablet or gaming device. This applies to all drivers.'),
  ('wa-q-impaired-hold-phone-c', 'wa-q-impaired-hold-phone', 3, 'Yes, if you only use it for directions', false,
   'Holding it for directions is still holding it. You cannot hold any electronic device while driving.'),
  ('wa-q-impaired-hold-phone-d', 'wa-q-impaired-hold-phone', 4, 'Yes, if you keep it below the window', false,
   'Where you hold it does not matter. You cannot hold any electronic device while driving.'),

  ('wa-q-impaired-permit-handsfree-a', 'wa-q-impaired-permit-handsfree', 1, 'Yes, hands-free calls are fine for every driver', false,
   'Not quite. Drivers with an instruction permit or intermediate license cannot use a phone while driving, even hands-free.'),
  ('wa-q-impaired-permit-handsfree-b', 'wa-q-impaired-permit-handsfree', 2, 'Yes, as long as the call is short', false,
   'The length of the call does not matter. With a permit, you cannot use a phone while driving, even hands-free.'),
  ('wa-q-impaired-permit-handsfree-c', 'wa-q-impaired-permit-handsfree', 3, 'No, not even with a hands-free device', true,
   'Right. With an instruction permit or intermediate license, you cannot use a cell phone or any mobile electronic device while driving, even if it is hands-free.'),

  ('wa-q-impaired-repeat-fine-a', 'wa-q-impaired-repeat-fine', 1, 'It can be doubled', true,
   'Right. A distracted driving ticket can mean heavy fines, and fines after your first violation can be doubled.'),
  ('wa-q-impaired-repeat-fine-b', 'wa-q-impaired-repeat-fine', 2, 'It is cut in half', false,
   'Not quite. Fines after your first violation can be doubled, not reduced.'),
  ('wa-q-impaired-repeat-fine-c', 'wa-q-impaired-repeat-fine', 3, 'It stays the same as the first', false,
   'Not quite. Fines after your first violation can be doubled.'),
  ('wa-q-impaired-repeat-fine-d', 'wa-q-impaired-repeat-fine', 4, 'It turns into a warning', false,
   'Not quite. A later violation can bring a bigger fine: fines after your first violation can be doubled.'),

  ('wa-q-impaired-over-shoulder-a', 'wa-q-impaired-over-shoulder', 1, 'Glance at your rearview mirror only', false,
   'One mirror is not enough. Before turning, check your side mirrors and look over your shoulder.'),
  ('wa-q-impaired-over-shoulder-b', 'wa-q-impaired-over-shoulder', 2, 'Turn on your signal and start the turn', false,
   'Signaling is important, but it does not show you who is beside you. Check your side mirrors and look over your shoulder first.'),
  ('wa-q-impaired-over-shoulder-c', 'wa-q-impaired-over-shoulder', 3, 'Honk to warn anyone who might be nearby', false,
   'Not quite. Before turning, check your side mirrors and do an over-the-shoulder check.'),
  ('wa-q-impaired-over-shoulder-d', 'wa-q-impaired-over-shoulder', 4, 'Check your side mirrors and look over your shoulder', true,
   'Right. Before turning, check your side mirrors and look over your shoulder for bicyclists or pedestrians who might be beside you or about to cross.'),

  ('wa-q-impaired-parked-cars-a', 'wa-q-impaired-parked-cars', 1, 'Only the car directly ahead of you', false,
   'Not quite. Look beyond the vehicle in front of you, and watch around parked vehicles too.'),
  ('wa-q-impaired-parked-cars-b', 'wa-q-impaired-parked-cars', 2, 'Feet, wheels, shadows and movement around them', true,
   'Right. Look ahead for feet, wheels, shadows and movement in, under and around parked vehicles. Looking ahead helps you avoid last-minute braking or having to swerve suddenly.'),
  ('wa-q-impaired-parked-cars-c', 'wa-q-impaired-parked-cars', 3, 'Empty spaces where you could park', false,
   'Not quite. Look ahead for feet, wheels, shadows and movement in, under and around parked vehicles.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
