# Core System Test Cases - Vocab Alarm

**Tester:** Huỳnh Đăng Khoa (QA Lead)
**Environment:** Physical Android & iOS Devices
**Platform:** Base44 BaaS

| Test ID | Test Scenario | Input / Action | Expected Output | Status |
| :--- | :--- | :--- | :--- | :--- |
| **TC-01** | Verify Background Persistence of the core alarm service. | Device placed in sleep mode (Lock-screen); system clock passes the scheduled alarm threshold. | The background service successfully triggers push notifications and hardware vibration. The screen wakes up and forces the full-screen Alarm UI above the OS lock layer. | ✅ Pass |
| **TC-02** | Audit AI Hallucination risks during linguistic data generation. | Input the vocabulary word "Mitigate", configuring system prompts to request an "IT" context at a "B2" proficiency level. | The API returns a perfectly formatted JSON object. The generated example is restricted to under 15 words and accurately centers on information technology terminology. | ✅ Pass |
| **TC-03** | Validate the enforcement and user experience of the Anti-Snooze flow. | Alarm is ringing. User attempts an OS gesture swipe, Home button press, or Back button press to exit. User subsequently presses "Study Now". | The system intercepts OS navigation commands, denies application exit, and maintains the alarm audio. **Upon pressing "Study Now", the alarm is completely silenced**, and the user is seamlessly routed into the quiet study interface. | ✅ Pass |
| **TC-04** | Audit Base44 Row Level Security (RLS) data isolation policies. | Authenticate with a valid session token belonging to User A, then issue an API query targeting the `user_word_progress` table belonging to User B. | The Base44 Native PostgreSQL engine explicitly rejects the request with an Access Denied (403) error, proving zero cross-user data leakage. | ✅ Pass |
| **TC-05** | Verify numerical accuracy of the Spaced Repetition System (SRS) algorithm. | User completes a flashcard review session and taps the "Hard" button. | The word's Mastery score is reduced by exactly 40 points, and the record is instantly indexed into the RAM Local Queue for accelerated re-display. | ✅ Pass |