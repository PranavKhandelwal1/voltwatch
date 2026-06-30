# VoltWatch

## Overview
VoltWatch is a Flutter-based battery management utility that monitors battery percentage, charging state, historical logs, and threshold alerts.

## Features
- Real-time battery monitoring
- Animated battery gauge
- Persistent battery logging
- Battery analytics chart
- Threshold notifications
- Background tracking using Workmanager

## Architecture
- Clean Architecture
- Riverpod state management
- Repository pattern

## Tech Stack
- Flutter
- Riverpod
- Hive
- Workmanager
- fl_chart
- battery_plus
- flutter_local_notifications

## Setup
flutter pub get
flutter run

## Build APK
flutter build apk --release

## Background Notes
Workmanager stops when app is force-stopped due to Android limitations.
