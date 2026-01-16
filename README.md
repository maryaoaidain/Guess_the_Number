# 🎯 Guess the Number Game (QtSpim)

A simple **Guess the Number** game written in **MIPS Assembly** and designed to run on **QtSpim**. The program generates a pseudo-random number between **1 and 100**, then asks the user to guess it while providing feedback and counting attempts.

---

## 🛠 Features

* Runs on **QtSpim** (no unsupported random syscalls)
* Pseudo-random number generation (LCG algorithm)
* Input validation (only numbers **1–100** allowed)
* Feedback for each guess (Too high / Too low)
* Counts number of attempts
* Option to **play again** or exit

---

## ▶️ How to Run

1. Open **QtSpim**
2. Load the file: `guess_number.asm`
3. Click **Run** (or press **F5**)
4. Follow the on-screen instructions

---

## ⚙️ Technical Notes

* Uses a **Linear Congruential Generator (LCG)** for randomness
* No use of syscalls 30 / 40 / 42 (not supported by QtSpim)
* Random range is normalized to **1–100**

---

## 📚 Educational Purpose

This project is useful for learning:

* MIPS system calls (I/O)
* Loops and conditional branching
* Functions and registers
* Basic algorithm tracing in Assembly

---

## 👩‍💻 Author

**Maria**

---


