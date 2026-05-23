-- ==========================================
-- TẦNG 1: DỮ LIỆU HỆ THỐNG TĨNH (GLOBAL ENTITIES)
-- ==========================================

-- 1. Bảng lưu trữ các bộ từ vựng (Desk)
CREATE TABLE desks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    level TEXT NOT NULL CHECK (level IN ('A1', 'A2', 'B1', 'B2', 'C1', 'C2', 'IELTS', 'TOEIC', 'Business')),
    category TEXT CHECK (category IN ('vocabulary', 'grammar', 'communication', 'business', 'academic', 'travel')),
    word_count INTEGER DEFAULT 0,
    image_url TEXT,
    rating NUMERIC(2,1) DEFAULT 0,
    learner_count INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT false,
    price_coins INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Bảng từ vựng gốc (Word)
CREATE TABLE words (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    deck_id UUID REFERENCES desks(id) ON DELETE CASCADE,
    word TEXT NOT NULL,
    phonetic TEXT,
    part_of_speech TEXT CHECK (part_of_speech IN ('noun', 'verb', 'adjective', 'adverb', 'preposition', 'conjunction', 'pronoun', 'interjection', 'phrase')),
    definition TEXT NOT NULL,
    example_sentence TEXT,
    example_translation TEXT,
    level TEXT CHECK (level IN ('A1', 'A2', 'B1', 'B2', 'C1', 'C2')),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);


-- ==========================================
-- TẦNG 2: NGƯỜI DÙNG & TIẾN ĐỘ CÁ NHÂN (USER-SCOPED ENTITIES)
-- ==========================================

-- (Lưu ý: Giả định Base44 đã có sẵn bảng Users của hệ thống Auth. 
-- Các trường user_id ở dưới dùng kiểu TEXT để lưu Email/ID theo như yêu cầu của bạn, 
-- nếu bạn dùng UUID chuẩn của Supabase auth thì thay TEXT thành UUID).

-- 3. Bảng tiến độ học từ vựng riêng của người dùng (UserWordProgress)
CREATE TABLE user_word_progress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL, 
    word_id UUID REFERENCES words(id) ON DELETE CASCADE NOT NULL,
    deck_id UUID REFERENCES desks(id) ON DELETE SET NULL, -- Denormalized for fast filtering
    status TEXT DEFAULT 'new' CHECK (status IN ('new', 'learning', 'reviewing', 'mastered')),
    mastery INTEGER DEFAULT 0 CHECK (mastery BETWEEN 0 AND 100),
    consecutive_correct INTEGER DEFAULT 0,
    next_review_date TIMESTAMPTZ, 
    review_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    CONSTRAINT unique_user_word_progress UNIQUE (user_id, word_id) -- Đảm bảo 1 user chỉ có 1 dòng tiến độ cho 1 từ
);

-- 4. Bảng ghi chú cá nhân cho từng từ vựng (UserNote)
CREATE TABLE user_notes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    word_id UUID REFERENCES words(id) ON DELETE CASCADE NOT NULL,
    note_text TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    CONSTRAINT unique_user_note UNIQUE (user_id, word_id)
);

-- 5. Bảng quản lý Bộ từ vựng đã mở khóa (UserUnlockedDeck)
CREATE TABLE user_unlocked_decks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    deck_id UUID REFERENCES desks(id) ON DELETE CASCADE NOT NULL,
    deck_title TEXT, -- Denormalized
    unlocked_at TIMESTAMPTZ DEFAULT now(),
    CONSTRAINT unique_user_deck UNIQUE (user_id, deck_id)
);

-- 6. Bảng lưu lịch sử các phiên học (StudySession)
CREATE TABLE study_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    deck_id UUID REFERENCES desks(id) ON DELETE SET NULL,
    deck_title TEXT, -- Denormalized
    mode TEXT DEFAULT 'flashcard' CHECK (mode IN ('flashcard', 'quiz', 'cram', 'quick_study')),
    total_words INTEGER DEFAULT 0,
    correct_answers INTEGER DEFAULT 0,
    duration_seconds INTEGER DEFAULT 0,
    xp_earned INTEGER DEFAULT 0,
    completed BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 7. Bảng quản lý Báo thức cá nhân (StudyAlarm)
CREATE TABLE user_study_alarms (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    deck_id UUID REFERENCES desks(id) ON DELETE SET NULL,
    deck_title TEXT, -- Denormalized
    alarm_time TEXT NOT NULL, -- Format HH:MM
    label TEXT,
    days TEXT[], -- Mảng lưu các ngày, vd: ['Mon', 'Tue']
    slot TEXT CHECK (slot IN ('morning', 'afternoon', 'evening')),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- ==========================================
-- TẦNG 3: INDEXING (TỐI ƯU HIỆU SUẤT TRUY VẤN)
-- ==========================================

-- Tạo các index để tăng tốc độ truy vấn khi dữ liệu lớn
CREATE INDEX idx_words_deck_id ON words(deck_id);
CREATE INDEX idx_progress_user_next_review ON user_word_progress(user_id, next_review_date);
CREATE INDEX idx_alarms_user_time ON user_study_alarms(user_id, alarm_time);
CREATE INDEX idx_sessions_user_id ON study_sessions(user_id);