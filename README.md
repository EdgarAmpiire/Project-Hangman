# Hangman Game (Ruby) – The Odin Project

This is a command-line **Hangman game** built with Ruby as part of the [Ruby Programming curriculum](https://www.theodinproject.com/paths/full-stack-ruby-on-rails) from **The Odin Project**.

The game lets you guess a secret word letter-by-letter with limited attempts. You can save and load your progress using YAML serialization.

---

## 🔧 Skills & Concepts Practiced

- Object-Oriented Programming (OOP) in Ruby
- File I/O
- YAML serialization and deserialization
- Working with external word lists
- User input and command-line interaction
- Game loop and state management

---

## 🎮 Features

- Random word selection (5–12 letters) from the [google-10000-english](https://github.com/first20hours/google-10000-english) word list.
- Tracks:
  - Correct guesses and their positions
  - Incorrect guesses
  - Remaining attempts (6 total)
- Case-insensitive guessing
- Save game progress anytime
- Load saved games from previous sessions

---

## 📁 Project Structure
``` bash
hangman/
├── hangman.rb # Main game logic
├── google-10000-english-no-swears.txt # Dictionary file
└── saves/ # Auto-created folder for saved games
```

---

## 📥 Setup Instructions

 **Install Ruby**  
   Make sure Ruby is installed:
   ```bash
   ruby -v
```

## ▶️ How to Run
Open your terminal, navigate to the folder where hangman.rb is located, and run:

```bash
ruby hangman.rb
```
You’ll be asked to:

- Start a new game, or

- Load a previously saved game

## 💾 Saving and Loading
- During gameplay, type save to save your progress.

- Saved files are stored as .yml in the saves/ folder.

- When the game starts, choose “Load Game” to resume a saved file.
