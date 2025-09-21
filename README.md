# 📱 Posts App

A Flutter application built with **Clean Architecture** and **Bloc State Management**.  
This app demonstrates how to fetch and manage posts data from a remote API in a scalable and maintainable way.

---

## 🚀 Features
- 🏗️ **Clean Architecture**: Separation of concerns into layers (Data, Domain, Presentation).
- ⚡ **Bloc**: Reactive and predictable state management.
- 🌐 **API Integration**: Fetch posts data from a REST API using repository pattern.
- 🎨 Simple and responsive UI.

---

## 🛠️ Tech Stack
- **Flutter** (UI Framework)
- **Bloc / Flutter_Bloc** (State Management)
- **Dio / http** (for API calls – depending on implementation)
- **Clean Architecture Layers**
  - Data Layer → Models, API calls
  - Domain Layer → Entities, Use Cases
  - Presentation Layer → Bloc, Widgets

---
## 🔗 API
The app fetches posts from a remote REST API:  
`https://jsonplaceholder.typicode.com/posts`

---

## ▶️ How to Run
1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd posts_app
