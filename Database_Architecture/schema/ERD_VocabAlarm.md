```mermaid
erDiagram
    USERS_PROFILE ||--o{ USER_WORD_PROGRESS : "has progress"
    USERS_PROFILE ||--o{ USER_UNLOCKED_DECKS : "unlocks"
    USERS_PROFILE ||--o{ STUDY_SESSIONS : "creates"
    USERS_PROFILE ||--o{ USER_STUDY_ALARMS : "sets"
    USERS_PROFILE ||--o{ USER_NOTES : "writes"

    DECKS ||--o{ WORDS : "contains"
    DECKS ||--o{ USER_UNLOCKED_DECKS : "is unlocked in"
    DECKS |o--o{ STUDY_SESSIONS : "studied in"

    WORDS ||--o{ USER_WORD_PROGRESS : "tracked in"
    WORDS ||--o{ USER_NOTES : "annotated in"

    DECKS {
        uuid id PK
        string title
        string level
        int word_count
        int price_coins
    }
    WORDS {
        uuid id PK
        uuid deck_id FK
        string word
        string part_of_speech
        string definition
    }
    USER_WORD_PROGRESS {
        uuid id PK
        string user_id FK
        uuid word_id FK
        string status
        int mastery
        datetime next_review_date
    }
    USER_STUDY_ALARMS {
        uuid id PK
        string user_id FK
        string alarm_time
        boolean is_active
    }
    STUDY_SESSIONS {
        uuid id PK
        string user_id FK
        string mode
        int xp_earned
    }
