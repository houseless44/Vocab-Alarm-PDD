# Vocab Alarm - Advanced Vocabulary Learning & Micro-Discipline Mobile Application

[![Project Methodology](https://img.shields.io/badge/Methodology-Prompt--Driven%20Development%20%28PDD%29-blueviolet)](https://github.com/houseless44/Vocab-Alarm-PDD)
[![Project Framework](https://img.shields.io/badge/Framework-Agile%2FScrum-blue)](https://vocabalarm.atlassian.net/)
[![Database Architecture](https://img.shields.io/badge/Database-3NF%20PostgreSQL%20%28Base44%29-green)](https://github.com/houseless44/Vocab-Alarm-PDD)

[cite_start]An advanced Educational Technology (EdTech) mobile application developed for the **Software Project Management** course at Vietnam - Korea University of Information and Communication Technology (VKU)[cite: 7, 79, 140].

* [cite_start]**Instructor:** Dr. Nguyen Thanh Tuan [cite: 80]
* [cite_start]**Course:** Software Project Management (Spring 2026) [cite: 7]
* [cite_start]**Development Team (Team 14):** 1. Bui Le The Hieu (Student ID: 22IT086) - Product Owner & Lead Prompt Engineer [cite: 8, 158]
  2. [cite_start]Huynh Dang Khoa (Student ID: 21SE5) - Scrum Master & System/QA Engineer [cite: 9, 158]

---

## 📌 Project Overview

[cite_start]**Vocab Alarm** aims to completely redesign an unavoidable daily routine—waking up—into a seamless and personalized micro-learning experience[cite: 166]. [cite_start]Traditional language learning solutions often suffer from high abandonment rates due to lack of learner self-discipline[cite: 91, 92]. 

To thoroughly resolve this, Vocab Alarm leverages the morning alarm ritual to establish a strict yet frictionless habit loop:
1. [cite_start]**The Core Trigger:** When the scheduled alarm rings, the UI forces a full-screen overlay and blocks standard OS dismissal gestures[cite: 263, 265].
2. [cite_start]**The Micro-Discipline:** The user must press **"Study Now" (Học ngay)** to completely silence the ringing audio and restore a quiet environment[cite: 266].
3. [cite_start]**The Learning Loop:** The application immediately redirects the user into a Spaced Repetition System (SRS) flashcard sequence and a 15-second Mini Quiz to activate cognitive faculties right at the start of the day[cite: 96, 297].

---

## ⚡ Core Technical Highlight: Prompt-Driven Development (PDD)

[cite_start]This project completely bypassed traditional manual coding[cite: 102]. [cite_start]The entire production-ready system architecture, database layer, and frontend interface were synthesized entirely through natural language commands (Prompts) on top of **Base44** (Backend-as-a-Service) and **React/Tailwind CSS**[cite: 102, 103]. 

[cite_start]To secure this AI-driven pipeline, the team introduced the **Prompt_Ledger** concept—a version-controlled, production-grade repository folder that houses all architectural meta-commands and system prompt sequences to guarantee system reproducibility and tackle LLM hallucinations[cite: 147, 251, 252, 258].

---

## 📂 Repository Structure

[cite_start]The architecture of this repository directly mirrors the artifacts generated throughout our 4-Sprint lifecycle:

```text
.
├── Assets/                        # Customized UI assets (Custom Coin Icons, Graphics)
├── Database_Architecture/         # 3NF Relational Database Layer
│   ├── csv/                       # Seed dataset files for 10 Decks and 10,000+ words
│   └── schema/                    # Native PostgreSQL SQL scripts and ERD diagrams
├── Demo/                          # End-to-End mobile workflow screen recording (.mp4)
├── Docs/                          # Final Project Management Report and Jira exports
├── Prompt_Ledger/                 # Structural Meta-Commands for AI (PDD Core Assets)
│   ├── Sprint1/                   # 3NF Schema & Anti-Snooze core prompt configurations
│   ├── Sprint2/                   # SRS mastery algorithm & Background engine prompts
│   ├── Sprint3/                   # Quiz engine & Micro-economy token prompts
│   └── Sprint4/                   # Release packaging and final logic audit prompts
├── QA_Test_Cases/                 # Test Plans, Bug Trackers, and QA Documentation
│   ├── bug_logs/                  # Sprint-by-Sprint resolved bug records
│   ├── test_cases/                # Core UAT functional scripts (TC-01 to TC-05)
│   └── test_reports/              # Final acceptance sign-off documentation
├── UI_Wireframes_Flows/           # Design Blueprints
│   ├── flowcharts/                # Mermaid.js behavioral control flows
│   ├── mockups/                   # Glassmorphism dark mode screen wireframes
│   └── user_flows/                # Habit loop traversal schemas
└── README.md                      # General repository documentation
