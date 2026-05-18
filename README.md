---




# AI Voice Summarizer 🎙️🧠

AI Voice Summarizer is a local-first mobile voice-note application designed to record, store, and automatically distill audio notes into concise, actionable text summaries. Built entirely with an offline-first architecture, it isolates sensitive raw notes on-device while managing heavy processing via asynchronous remote LLM inference pipelines.

---

## 🚀 Core Features

- **On-Device Audio Capture:** Native audio recorder pipeline optimizing compression formats for minimal local storage footprints.
- **Local-First Architecture:** Complete structural storage of note meta-data, file paths, and generated summary histories managed via a reactive, ultra-fast **Isar Database**—requiring zero cloud databases.
- **Asynchronous API Handling:** Isolates heavy network I/O, audio streaming, and text-based LLM payloads off the main thread to guarantee flawless **60 FPS UI responsiveness** during active processing states.
- **Complete Note Lifecycle Management:** Intuitive UX supporting real-time playback, note renaming, secure deletion cascades, and historical summaries.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** Flutter (Dart)
- **Local Database:** Isar Database (NoSQL, high-performance local compilation)
- **AI Integration:** Asynchronous LLM REST APIs (Audio Transcription & Summary Extraction Models)
- **Design Pattern:** MVVM (Model-View-ViewModel) paired with clean state controllers.

---

## 📂 Repository Structure

```text
lib/
├── models/         # Isar Database Collections (VoiceNote data schemas)
├── views/          # Responsive UI Layouts (Note list, recording dashboards)
├── viewmodels/     # Business logic layers, UI state controllers
└── services/       # Audio Recording, File system, and REST API Service clients
