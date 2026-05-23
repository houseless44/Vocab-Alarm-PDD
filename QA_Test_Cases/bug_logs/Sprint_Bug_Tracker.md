# Sprint Bug Tracking Log

### Bug ID: BUG-VA-01 (Severity: Critical)
* **Title:** Background Alarm rings continuously and does not stop after 1 minute.
* **Sprint:** Sprint 2
* **Description:** When the alarm triggers (e.g., 3:00 PM), it keeps ringing continuously until 3:01 PM instead of firing once.
* **Root Cause:** The `firedRef` state was being reset on every re-render of the React component, causing the system to constantly re-trigger the alarm within the 60-second window.
* **Resolution:** Replaced React state with `sessionStorage` to persist the "fired" status. The alarm now strictly rings once per scheduled time.
* **Status:** 🟢 Resolved & Closed.

### Bug ID: BUG-VA-02 (Severity: High)
* **Title:** "No words available" error when starting a deck that has 500 words.
* **Sprint:** Sprint 2
* **Description:** User clicks to study a seeded deck (e.g., IELTS 500 words), but the UI shows an empty state "This deck has no words".
* **Root Cause:** Row Level Security (RLS) on the global `Word` entity was incorrectly restricted to `created_by = user.email`. Users could not read the global dictionary words created by the Admin.
* **Resolution:** Changed the RLS policy of the `Word` entity to `read: {}` (Public Read), allowing all users to fetch dictionary words while maintaining strict RLS on the `UserWordProgress` table.
* **Status:** 🟢 Resolved & Closed.

### Bug ID: BUG-VA-03 (Severity: Medium)
* **Title:** Base44Error: Error in field alarm_time: Field required.
* **Sprint:** Sprint 3
* **Description:** App crashes when attempting to toggle an alarm ON/OFF in the Alarms Page.
* **Root Cause:** The `toggleAlarm` handler was sending an incomplete payload during the update mutation, dropping the `alarm_time` string.
* **Resolution:** Updated `toggleAlarm` to spread the full alarm object `({...alarm, is_active: !alarm.is_active})` ensuring `alarm_time` is always preserved during updates.
* **Status:** 🟢 Resolved & Closed.