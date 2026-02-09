# Taskify 🗂️

Taskify is a collaborative task management mobile application built with **Flutter**. It allows users to create boards (projects), manage tasks, assign members, and track progress in real-time with offline support.

---

## ✨ Features

* 🔐 **Authentication** (Sign up / Sign in)
* 📋 **Boards (Projects)** creation and management
* ✅ **Task management** with status tracking (To do / In progress / Done)
* 👥 **Member assignment** per board
* 🗓️ **Due dates** for tasks
* 🔄 **Real-time updates** using Firebase Firestore streams
* 📱 **Offline-first experience** with hive_ce

---

## 🧱 Architecture Approach

The app follows a **clean, feature-first architecture** inspired by Clean Architecture principles.

```
lib/
 └── src/
     ├── features/
     │   ├── auth/
     │   │   ├── data/
     │   │   ├── domain/
     │   │   └── presentation/
     │   ├── boards/
     │   ├── tasks/
     ├── core/
     │   ├── common/
     │   ├── services/
     │   └── utils/
     └── config/
```

### Key Principles

* **Separation of concerns** (UI, business logic, data)
* **Feature isolation** for scalability
* API / Firestore logic is kept out of UI layers
* Models are decoupled from presentation

---

## 🧠 State Management

**Provider** is used for state management.

### Why Provider?

* Lightweight and easy to reason about
* Works well with Firestore streams
* Clear lifecycle management
* Minimal boilerplate

---

## ☁️ Backend

### Firebase Firestore

* Acts as the primary backend
* Stores users, boards, and tasks
* Uses **real-time streams** for data synchronization

Firestore is used with:

* `snapshots()` for live updates
* Document references via `uid` / `docId`
* Server timestamps for consistency

---

## 📦 Offline Handling Strategy

Taskify is designed as an **offline-first app**.

### Hive CE

* **Hive CE** is used for local data persistence
* Caches boards and tasks locally
* Ensures data availability without internet

### Offline Flow

1. Firestore streams update local state
2. Data is cached in Hive
3. UI reads from local cache when offline
4. Firestore syncs automatically when connection is restored

No manual sync is required.

---

## 🔁 Retry Handling Strategy

A custom retry mechanism is **not implemented**.

### Reason

* Firestore streams handle reconnection automatically
* Firebase SDK retries network calls internally
* Stream-based architecture ensures data consistency

This keeps the app simpler and more reliable.

---

## 🔐 Authentication

* Firebase Authentication
* Email & password based login
* User `uid` is used as the primary identifier
* User data is mapped to Firestore documents

---

## 📅 Task Status Flow

Tasks can have the following states:

* **To do**
* **In progress**
* **Done**

Status changes are reflected instantly across all connected clients.

---

## ⚠️ Known Limitations

* ❌ No push notifications
* ❌ No file attachments for tasks

---

## 🚀 Future Improvements

* 🔔 Push notifications for task updates
* 📎 Attachments & comments on tasks
* 📊 Analytics dashboard

---

## 🛠️ Tech Stack

* **Flutter**
* **Firebase Authentication**
* **Firebase Firestore**
* **Provider** (state management)
* **Hive CE** (offline storage)

---

## 👨‍💻 Author

Developed by **Faiz SR**.

---

## 📄 License

This project is for evaluation and learning purposes.
