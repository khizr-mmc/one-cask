# One Cask Collection App

A Flutter demo app showcasing an offline-first “My Collection” feature using BLoC/Cubit, mock JSON, connectivity-aware fetching, and local caching.

## Features

* **Flutter Stable & Null Safety**
* **Mock JSON**: `assets/my_collection_mock.json` loaded via `rootBundle`
* **Connectivity Check**: `connectivity_plus` ensures fetch only when online
* **Offline Cache**: `CacheClient` (using `shared_preferences`) stores raw JSON for offline use
* **State Management**: `flutter_bloc` (Cubit + `GeneralApiState`) for clear loading/loaded/error states
* **Pull-to-Refresh**: `RefreshIndicator` to re-fetch data on swipe
* **Online/Offline SnackBars**: real-time feedback on connectivity changes

## Project Structure

```text
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
│       └── views.dart    # MyCollectionPage UI
├── utils/
│   └── cache_client.dart # shared CacheClient path dependency
└── main.dart

packages/               # path dependency for shared components (themes, icons)
```

## Getting Started

### Prerequisites

* Flutter SDK (stable channel, 3.x+)
* Dart SDK (>=2.18)

### Installation

```bash
git clone https://github.com/khizr-mmc/one-cask.git
cd one-cask
flutter pub get
flutter run
```

## Architecture & Packages

* **Feature-Based Modules**: models, repository, cubit, and view separated per feature
* **Path Dependency**: top-level `packages/` folder for shared widgets and utilities

**Packages Used**:

* `connectivity_plus`: real-time network status
* `shared_preferences`: lightweight JSON caching
* `flutter_bloc`: BLoC/Cubit state management

## Data & Networking Flow

1. **Online**: load JSON from assets → cache raw string → decode & emit
2. **Offline**: read cached string → decode & emit (throws if no cache)
3. **Pull-to-Refresh**: re-invokes the same flow on swipe
