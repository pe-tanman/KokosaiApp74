# 🎪 Kokosai 74 App (第74回鯱光祭アプリ)

> *The official guide app for the 74th Kokosai, Asahigaoka High School's school festival.*

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)
![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20Android-lightgrey)


## 🌟 Highlights

- 🗓️ **Every event in one place** — the sports festival, cultural festival, stage shows, eve and closing festivals, a debate forum and club workshops, each with its own schedule
- 🏅 **Live sports festival scoreboard** — the team point table updates as organizers enter results
- 🗺️ **Campus map** and a **digital pamphlet** (PDF viewer)
- 🎵 **The festival theme song** and event videos, playable in the app
- 📖 **Art book reservations** — reserve the festival art book in the app, with an admin screen for managing orders
- 🔔 **Announcements feed** for up-to-the-minute updates from the committee
- 🈶 **Authentic vertical Japanese text (縦書き)** rendering for a traditional look


## ℹ️ Overview

**鯱光祭 (Kokosai)** is the annual festival of Aichi Prefectural Asahigaoka High School in Nagoya. It includes a sports festival, a cultural festival, stage performances and several other events. This Flutter app was the festival's official guide for its 74th edition. Students and visitors could check schedules, scores and announcements in one place instead of relying on printed programs.

Most of the app requires signing in; the cultural festival pages are open to everyone. Special accounts (the festival committee) get extra screens for managing the point table and art book orders.

The following year's app, [**kokosai-app-75**](https://github.com/AsahigaokaProhen/kokosai-app-75), builds on this one for the 75th-anniversary festival.


### ✍️ Authors

Built by the Asahigaoka High School student app team, including [Yuki Ishihara](https://github.com/pe-tanman).


## 🚀 What's Inside

| Area | Screens |
| --- | --- |
| **Events** | 体育祭 (sports) · 文化祭 (culture) · 舞台 (stage) · 前夜祭 (eve) · 後夜祭 (after-party) · 討論会 (debate forum) · 文化会 (club workshops) |
| **Info** | Home, schedule, map, pamphlet (PDF), theme song, announcements |
| **Committee tools** | Sports festival point table management, art book order management |
| **Settings** | Privacy policy, terms of service, credits, bug report |


## ⬇️ Building from Source

Requirements: [Flutter](https://docs.flutter.dev/get-started/install) **3.x with Dart 2.17–2.19** (the project predates Dart 3), plus Xcode or Android Studio.

```bash
git clone https://github.com/pe-tanman/KokosaiApp74.git
cd KokosaiApp74
flutter pub get
flutter run
```

The app uses Firebase Auth and Cloud Firestore. To point it at your own Firebase project, run `flutterfire configure`.


## 💭 Feedback

This repository is kept as an archive of the 74th festival app. Future committees are welcome to use it as a reference, and questions can go in [Issues](https://github.com/pe-tanman/KokosaiApp74/issues).
