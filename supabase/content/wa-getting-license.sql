-- Lesson 13: Getting your license (WA Driver Guide 1.8, 1.9, 1.12, 1.14, 1.15, 2.3).
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
  ('wa-getting-license', 13, 'Getting your license',
   'How to go from a permit to a license, the extra rules for new teen drivers, and why you need insurance.',
   'WA Driver Guide 1.8, 1.9, 1.12, 1.14, 1.15, 2.3', 'draft')
on conflict (id) do update set
  position = excluded.position, title = excluded.title, summary = excluded.summary,
  source = excluded.source, status = 'draft';

-- --------------------------------------------------------------- sections
insert into public.sections (id, lesson_id, position, title, body, source, status) values
  ('wa-getting-license-permit', 'wa-getting-license', 1, 'From permit to first license',
   E'When you can get an instruction permit depends on whether you take a driver training course:\n- With a driver training course, you can apply for your permit as early as 15 years old.\n- Without a course, you can take the knowledge exam after you turn 15 and a half. You get your permit when you pass, but you must wait until you are 18 to take the skills exam and get your license.\n\nYour permit is valid for 1 year, and you can renew it for a fee. Your knowledge exam score is valid for 2 years, so if you wait too long to take the skills exam, you may have to retake the knowledge exam.\n\nTo get your first license at age 16 or 17, you must:\n- Have your instruction permit for at least 6 months.\n- Be at least 16 years old and a Washington resident.\n- Complete a traffic safety course at an approved driver training school.\n- Pass both the knowledge exam and the skills exam.\n- Complete at least 40 hours of day driving and 10 hours of night driving with a licensed driver who has 3 or more years of experience. A parent, guardian or responsible adult must confirm these hours.\n- Have no traffic violations or convictions for 6 months before you apply.\n- Have no alcohol or drug offenses while driving with your permit.',
   'WA Driver Guide 1.8, Instruction permit; Getting your personal driver license: Ages 16 to 17; 1.14', 'draft'),
  ('wa-getting-license-intermediate', 'wa-getting-license', 2, 'Intermediate license rules',
   E'Teens who are 16 or 17 move through 2 restricted phases before they get an unrestricted license: first the instruction permit, then the intermediate license. With an intermediate license, you must follow these rules.\n\nFor the first 6 months:\n- No passengers under age 20, except immediate family members.\n- No driving between 1 a.m. and 5 a.m., unless a parent, guardian or licensed driver at least age 25 is with you.\n\nFrom 6 months until you turn 18 or have had your license for 1 year, whichever comes first:\n- No more than 3 passengers under age 20, except immediate family members.\n- The nighttime rule ends after 1 year of safe driving.\n\nYou may not use a cell phone or other wireless device while driving, even hands-free. The only exception is to report an emergency.\n\nTraffic violations and crashes that are your fault have penalties:\n- 1st violation: your current restrictions apply until you are 18.\n- 2nd violation: your license is suspended for 6 months or until you turn 18, whichever comes first.\n- 3rd violation: your license is suspended until you are 18.\n\nAfter 1 year with no crashes and no traffic offenses, you may drive at any hour, with passengers. When you turn 18, the restrictions are lifted automatically.',
   'WA Driver Guide 1.8, Intermediate driver license', 'draft'),
  ('wa-getting-license-exams', 'wa-getting-license', 3, 'The two exams and your vision',
   E'Before you can be a licensed driver, you have to pass 2 exams:\n- The Driving Knowledge Exam checks your understanding of Washington''s rules of the road. You must pass it first.\n- The Driving Skills Exam checks your ability to apply those rules. After you pass the knowledge exam, you have 2 years to complete the skills exam.\n\nDuring the skills exam, only you and the examiner may be in the vehicle. Service animals and sign language interpreters are the exceptions.\n\nThe vehicle for the skills exam must be legally licensed and registered, have proof of current liability insurance, and be in safe operating condition. Its brake lights, signal lights and seat belts must work. The examiner checks all of this before the exam begins.\n\nDOL will check your vision before issuing your license. If you use glasses or contact lenses, this is recorded on your license.\n- Always wear your glasses or contacts while driving.\n- Have your eyes checked regularly by an eye doctor.\n\nYou can also choose to add disability and medical designations to your license, such as deaf or hard of hearing, or a medical alert. In an emergency, they give first responders helpful information.',
   'WA Driver Guide 1.12, Two exams; 1.9, Vision screenings; 1.9, Medical designations', 'draft'),
  ('wa-getting-license-keeping', 'wa-getting-license', 4, 'Insurance and keeping your license',
   E'Washington requires you to have liability insurance and to keep proof of it with you or in your vehicle. It should pay at least:\n- $25,000 when only 1 person is injured or killed in a collision\n- $50,000 when 2 or more people are injured or killed in any 1 collision\n- $10,000 for damage to other people''s property in any 1 collision\n\nYou can renew your license up to 1 year before it expires. The expiration date is near the bottom of your license. If your license is 8 or more years expired, you will need to retake the knowledge and skills tests.\n\nYou can lose your driving privileges for reasons such as:\n- Driving without insurance\n- Violating intermediate license restrictions\n- Driving under the influence of alcohol or drugs\n- Racing, driving recklessly or running from law enforcement\n- Building up moving violations or unresolved traffic tickets\n\nFor drivers 21 and older, a blood alcohol concentration (BAC) of 0.08% or more is a DUI. If you are under 21, a BAC of 0.02% or more, or any active THC in your blood, has the same potential consequences.',
   'WA Driver Guide 2.3, Insurance required; 1.15, Renewing your driver license; Expired license; Losing your driving privileges; Blood Alcohol Concentration (BAC); THC', 'draft')
on conflict (id) do update set
  lesson_id = excluded.lesson_id, position = excluded.position, title = excluded.title,
  body = excluded.body, source = excluded.source, status = 'draft';

-- -------------------------------------------------------------- questions
insert into public.questions (id, section_id, position, prompt, source, status) values
  ('wa-q-license-no-course', 'wa-getting-license-permit', 1,
   'You are 16 and have an instruction permit. You are not enrolling in a driver training course. When can you take the skills exam and get your license?',
   'WA Driver Guide 1.8, If you are not enrolling in a driver training course', 'draft'),
  ('wa-q-license-permit-months', 'wa-getting-license-permit', 2,
   'You are 16 and finished a driver training course. How long must you have had your instruction permit before you can get your first license?',
   'WA Driver Guide 1.8, Getting your personal driver license: Ages 16 to 17', 'draft'),
  ('wa-q-license-practice-hours', 'wa-getting-license-permit', 3,
   'Before you get your first license at 16 or 17, how much practice driving must you do with a licensed driver who has 3 or more years of experience?',
   'WA Driver Guide 1.8, Getting your personal driver license: Ages 16 to 17; 1.14', 'draft'),

  ('wa-q-license-first-passengers', 'wa-getting-license-intermediate', 1,
   'You got your intermediate license 2 months ago. A 17-year-old friend who is not a family member asks you for a ride. Can you drive them?',
   'WA Driver Guide 1.8, Intermediate driver license: From Issue Date to 6 Months', 'draft'),
  ('wa-q-license-night-hours', 'wa-getting-license-intermediate', 2,
   'During the first 6 months of an intermediate license, when are you not allowed to drive unless a parent, guardian or licensed driver at least age 25 is with you?',
   'WA Driver Guide 1.8, Intermediate driver license: From Issue Date to 6 Months', 'draft'),
  ('wa-q-license-phone', 'wa-getting-license-intermediate', 3,
   'You have an intermediate license. When may you use your cell phone while driving?',
   'WA Driver Guide 1.8, Intermediate driver license', 'draft'),

  ('wa-q-license-skills-deadline', 'wa-getting-license-exams', 1,
   'You just passed the Driving Knowledge Exam. How long do you have to complete the Driving Skills Exam?',
   'WA Driver Guide 1.12, The Driving Knowledge Exam', 'draft'),
  ('wa-q-license-exam-vehicle', 'wa-getting-license-exams', 2,
   'You plan to use a family car for your Driving Skills Exam. Which of these must work?',
   'WA Driver Guide 1.12, The Driving Skills Exam', 'draft'),
  ('wa-q-license-glasses', 'wa-getting-license-exams', 3,
   'Your license shows that you use corrective glasses. When should you wear them?',
   'WA Driver Guide 1.9, Vision screenings', 'draft'),

  ('wa-q-license-insurance-proof', 'wa-getting-license-keeping', 1,
   'What does Washington law require about car insurance?',
   'WA Driver Guide 2.3, Insurance required', 'draft'),
  ('wa-q-license-renew', 'wa-getting-license-keeping', 2,
   'Your driver license expires in 10 months. Can you renew it now?',
   'WA Driver Guide 1.15, Renewing your driver license', 'draft'),
  ('wa-q-license-under21-bac', 'wa-getting-license-keeping', 3,
   'You are 17. What is the lowest blood alcohol concentration (BAC) at which you could face the same consequences as a DUI?',
   'WA Driver Guide 1.15, Blood Alcohol Concentration (BAC)', 'draft')
on conflict (id) do update set
  section_id = excluded.section_id, position = excluded.position, prompt = excluded.prompt,
  source = excluded.source, status = 'draft';

-- ---------------------------------------------------------------- choices
-- Exactly one is_correct per question. Every choice has an explanation.
-- Correct positions, in question order: 3,1,4,2,2,4,1,3,4,1,3,2.
insert into public.choices (id, question_id, position, body, is_correct, explanation) values
  ('wa-q-license-no-course-a', 'wa-q-license-no-course', 1, 'Once you have had your permit for 6 months', false,
   'Not quite. Without a driver training course, having your permit for 6 months is not enough. You must wait until you are 18.'),
  ('wa-q-license-no-course-b', 'wa-q-license-no-course', 2, 'When you turn 17', false,
   'Not quite. Without a driver training course, you need to wait until you are 18 to take the skills exam and get your license.'),
  ('wa-q-license-no-course-c', 'wa-q-license-no-course', 3, 'When you turn 18', true,
   'Right. Without a driver training course, you can get a permit, but you must wait until you are 18 to take the skills exam and get your license.'),
  ('wa-q-license-no-course-d', 'wa-q-license-no-course', 4, 'As soon as you pass the knowledge exam', false,
   'Not quite. Passing the knowledge exam gets you a permit. Without a driver training course, the skills exam and license wait until you are 18.'),

  ('wa-q-license-permit-months-a', 'wa-q-license-permit-months', 1, 'At least 6 months', true,
   'Right. To get your first license at 16 or 17, you must have had your instruction permit for at least 6 months.'),
  ('wa-q-license-permit-months-b', 'wa-q-license-permit-months', 2, 'At least 3 months', false,
   'Not quite. That is too short. You must have had your permit for at least 6 months.'),
  ('wa-q-license-permit-months-c', 'wa-q-license-permit-months', 3, 'At least 1 year', false,
   'Not quite. 1 year is how long a permit is valid. You need to have had it for at least 6 months.'),
  ('wa-q-license-permit-months-d', 'wa-q-license-permit-months', 4, 'There is no minimum time', false,
   'Not quite. There is a minimum: you must have had your permit for at least 6 months.'),

  ('wa-q-license-practice-hours-a', 'wa-q-license-practice-hours', 1, 'At least 20 hours of day driving and 5 hours of night driving', false,
   'Not quite. That is too little. You need at least 40 hours of day driving and 10 hours of night driving.'),
  ('wa-q-license-practice-hours-b', 'wa-q-license-practice-hours', 2, 'At least 50 hours of day driving and no night driving', false,
   'Not quite. Night driving is required too. You need at least 40 hours of day driving and 10 hours of night driving.'),
  ('wa-q-license-practice-hours-c', 'wa-q-license-practice-hours', 3, 'At least 30 hours of driving at any time of day', false,
   'Not quite. You need at least 40 hours of day driving plus 10 hours of night driving.'),
  ('wa-q-license-practice-hours-d', 'wa-q-license-practice-hours', 4, 'At least 40 hours of day driving and 10 hours of night driving', true,
   'Right. You need at least 40 hours of day driving and 10 hours of night driving, and a parent, guardian or responsible adult must confirm it.'),

  ('wa-q-license-first-passengers-a', 'wa-q-license-first-passengers', 1, 'Yes, up to 3 passengers under 20 are allowed', false,
   'Not quite. The limit of 3 passengers under 20 starts after your first 6 months. Before that, you may not carry any passengers under 20, except immediate family.'),
  ('wa-q-license-first-passengers-b', 'wa-q-license-first-passengers', 2, 'No, not during your first 6 months', true,
   'Right. For the first 6 months, you may not carry passengers under age 20, except immediate family members.'),
  ('wa-q-license-first-passengers-c', 'wa-q-license-first-passengers', 3, 'Yes, but only during daylight hours', false,
   'Not quite. The passenger rule applies at any time of day. For the first 6 months, no passengers under 20 except immediate family.'),
  ('wa-q-license-first-passengers-d', 'wa-q-license-first-passengers', 4, 'Yes, as long as they wear a seat belt', false,
   'Seat belts matter, but they do not change this rule. For the first 6 months, no passengers under 20 except immediate family.'),

  ('wa-q-license-night-hours-a', 'wa-q-license-night-hours', 1, 'Between 10 p.m. and 5 a.m.', false,
   'Not quite. The nighttime limit is between 1 a.m. and 5 a.m.'),
  ('wa-q-license-night-hours-b', 'wa-q-license-night-hours', 2, 'Between 1 a.m. and 5 a.m.', true,
   'Right. You may not drive between 1 a.m. and 5 a.m. unless a parent, guardian or licensed driver at least age 25 is with you.'),
  ('wa-q-license-night-hours-c', 'wa-q-license-night-hours', 3, 'Between midnight and 6 a.m.', false,
   'Not quite. The nighttime limit is between 1 a.m. and 5 a.m.'),
  ('wa-q-license-night-hours-d', 'wa-q-license-night-hours', 4, 'Any time after sunset', false,
   'Not quite. The rule does not start at sunset. The nighttime limit is only between 1 a.m. and 5 a.m.'),

  ('wa-q-license-phone-a', 'wa-q-license-phone', 1, 'Any time, if it is hands-free', false,
   'Not quite. With an intermediate license, you cannot use a phone while driving, even with hands-free technology.'),
  ('wa-q-license-phone-b', 'wa-q-license-phone', 2, 'Only for short calls with a parent', false,
   'Not quite. Calls with family are not an exception. You may use your phone only to report an emergency.'),
  ('wa-q-license-phone-c', 'wa-q-license-phone', 3, 'Only to follow a map app', false,
   'Not quite. Maps are not an exception. You may use your phone only to report an emergency.'),
  ('wa-q-license-phone-d', 'wa-q-license-phone', 4, 'Only to report an emergency', true,
   'Right. With an intermediate license, you cannot use a phone while driving, even hands-free, except to report an emergency.'),

  ('wa-q-license-skills-deadline-a', 'wa-q-license-skills-deadline', 1, '2 years', true,
   'Right. After you pass the knowledge exam, you have 2 years to complete the skills exam. Wait longer and you may have to retake the knowledge exam.'),
  ('wa-q-license-skills-deadline-b', 'wa-q-license-skills-deadline', 2, '6 months', false,
   'Not quite. You have 2 years after passing the knowledge exam.'),
  ('wa-q-license-skills-deadline-c', 'wa-q-license-skills-deadline', 3, '1 year', false,
   'Not quite. 1 year is how long your permit is valid. You have 2 years to complete the skills exam.'),
  ('wa-q-license-skills-deadline-d', 'wa-q-license-skills-deadline', 4, 'There is no time limit', false,
   'Not quite. Your knowledge exam score is only valid for 2 years, so you have 2 years to complete the skills exam.'),

  ('wa-q-license-exam-vehicle-a', 'wa-q-license-exam-vehicle', 1, 'The backup camera and parking sensors', false,
   'Not quite. These are not on the list for the exam. The brake lights, signal lights and seat belts must work.'),
  ('wa-q-license-exam-vehicle-b', 'wa-q-license-exam-vehicle', 2, 'The radio and the air conditioning', false,
   'Not quite. These are not on the list for the exam. The brake lights, signal lights and seat belts must work.'),
  ('wa-q-license-exam-vehicle-c', 'wa-q-license-exam-vehicle', 3, 'The brake lights, signal lights and seat belts', true,
   'Right. The vehicle must be in safe operating condition with working brake lights, signal lights and seat belts. It also needs proof of current liability insurance.'),
  ('wa-q-license-exam-vehicle-d', 'wa-q-license-exam-vehicle', 4, 'The cruise control and the GPS screen', false,
   'Not quite. These are not on the list for the exam. The brake lights, signal lights and seat belts must work.'),

  ('wa-q-license-glasses-a', 'wa-q-license-glasses', 1, 'Only when driving at night', false,
   'Not quite. Wear your glasses or contacts every time you drive, day or night.'),
  ('wa-q-license-glasses-b', 'wa-q-license-glasses', 2, 'Only during the vision screening', false,
   'Not quite. The screening records that you use them. You should always wear them while driving.'),
  ('wa-q-license-glasses-c', 'wa-q-license-glasses', 3, 'Only on highways or long trips', false,
   'Not quite. Short trips count too. Always wear your glasses or contacts while driving.'),
  ('wa-q-license-glasses-d', 'wa-q-license-glasses', 4, 'Every time you drive', true,
   'Right. If you use glasses or contacts, always wear them while driving, and have your eyes checked regularly by an eye doctor.'),

  ('wa-q-license-insurance-proof-a', 'wa-q-license-insurance-proof', 1, 'Have liability insurance and carry proof of it', true,
   'Right. Washington requires you to have liability insurance and to keep proof of it with you or in your vehicle.'),
  ('wa-q-license-insurance-proof-b', 'wa-q-license-insurance-proof', 2, 'Get insurance only after your first crash', false,
   'Not quite. Washington requires you to have liability insurance and carry proof of it, not to wait for a crash.'),
  ('wa-q-license-insurance-proof-c', 'wa-q-license-insurance-proof', 3, 'Get insurance only for long road trips', false,
   'Not quite. Insurance is not just for long trips. Washington requires you to have liability insurance and carry proof of it.'),
  ('wa-q-license-insurance-proof-d', 'wa-q-license-insurance-proof', 4, 'Have insurance, but keep the proof at home', false,
   'Not quite. Keep proof of insurance with you or in your vehicle, not at home.'),

  ('wa-q-license-renew-a', 'wa-q-license-renew', 1, 'No, you must wait until it expires', false,
   'Not quite. You do not have to wait. You can renew up to 1 year before your license expires.'),
  ('wa-q-license-renew-b', 'wa-q-license-renew', 2, 'No, only in the last 30 days', false,
   'Not quite. The window is much longer. You can renew up to 1 year before your license expires.'),
  ('wa-q-license-renew-c', 'wa-q-license-renew', 3, 'Yes, you can renew up to 1 year early', true,
   'Right. You can renew your license up to 1 year before it expires. The date is near the bottom of your license.'),
  ('wa-q-license-renew-d', 'wa-q-license-renew', 4, 'Only if you retake the knowledge exam', false,
   'Not quite. You can renew up to 1 year before it expires. Retaking the tests comes up when a license is 8 or more years expired.'),

  ('wa-q-license-under21-bac-a', 'wa-q-license-under21-bac', 1, '0.08% or more', false,
   'Not quite. 0.08% is the level for drivers 21 and older. For drivers under 21, it is 0.02% or more.'),
  ('wa-q-license-under21-bac-b', 'wa-q-license-under21-bac', 2, '0.02% or more', true,
   'Right. Drivers under 21 face the same potential consequences as a DUI with a BAC of 0.02% or more.'),
  ('wa-q-license-under21-bac-c', 'wa-q-license-under21-bac', 3, '0.05% or more', false,
   'Not quite. For drivers under 21, the level is 0.02% or more.'),
  ('wa-q-license-under21-bac-d', 'wa-q-license-under21-bac', 4, '0.10% or more', false,
   'Not quite. That is above even the 0.08% level for drivers 21 and older. For drivers under 21, it is 0.02% or more.')
on conflict (id) do update set
  question_id = excluded.question_id, position = excluded.position, body = excluded.body,
  is_correct = excluded.is_correct, explanation = excluded.explanation;
