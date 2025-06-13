One Cask Collection App

A Flutter demo app showcasing an offline-first “My Collection” feature following a BLoC/Cubit architecture, mock data loading, connectivity-aware fetch, and local JSON caching.

Features

Flutter Stable & Null Safety

Mock JSON: assets/my_collection_mock.json loaded via rootBundle

Connectivity Check: connectivity_plus ensures fetch only when online

Offline Cache: CacheClient (built on shared_preferences) stores raw JSON for offline use

State Management: flutter_bloc (Cubit + GeneralApiState) for clear loading/loaded/error states

Pull-to-Refresh: RefreshIndicator to re-fetch data on swipe

Online/Offline SnackBars: realtime feedback on connectivity changes

Project Structure

lib/
├── collection/
│   ├── models/
│   │   └── collection_model.dart
│   ├── repository/
│   │   └── collection_repository.dart
│   ├── cubit/
│   │   ├── collection_cubit.dart
│   │   └── collection_state.dart
│   └── view/
│       └── views.dart  # MyCollectionPage UI
├── utils/
│   └── cache_client.dart  # shared CacheClient path dependency
└── main.dart
packages/  # linked as a path dependency for shared components (themes, icons)

Getting Started

Prerequisites

Flutter SDK (stable channel, 3.x+)

Dart SDK (>=2.18)

Installation

# Clone the repo
git clone https://github.com/khizr-mmc/one-cask.git
cd one-cask

# Fetch dependencies
flutter pub get

# Run on device or emulator
flutter run

Architecture & Packages

Feature-Based Modules: keeps models, repository, cubit, and view separated per feature

Path Dependency: a top-level packages/ folder houses shared widgets and utilities as if it were a third-party library

Packages Used:

connectivity_plus: real-time network status checks

shared_preferences: lightweight JSON caching via CacheClient

flutter_bloc: BLoC/Cubit state management

Data & Networking Flow

Online: load JSON from assets → cache raw string → decode & emit

Offline: read cached string → decode & emit (throws if no cache)

Pull-to-Refresh: re-invokes the same flow on swipe

Time Tracking

Task

Time Spent

Project setup & JSON integration

1h

Connectivity & caching logic

1h

BLoC/Cubit & state handling

1h

UI implementation & refresh/snackbar

1h
