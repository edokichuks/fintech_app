# Flutter Mobile Assessment – Implementation Plan / README

## Project Overview

This project is a **Flutter mobile application** that implements the **Dashboard** and **Cards** sections from the provided Figma design using **mocked real-time data**.

- figma link
https://www.figma.com/design/ooumekXFabNCGgE0xKtiga/Fintech-App-Dark-UI-Design--Community-?node-id=68-19&p=f

The objective is to deliver a **pixel-accurate, responsive, animated, and maintainable UI** that demonstrates strong Flutter engineering practices.

## Scope

### Included

* Dashboard screen UI
* Card components from Figma
* Mock API / mocked live data updates
* Responsive mobile layouts
* Animations and transitions
* Clean architecture
* State management
* Testing (unit/widget where relevant)

### Excluded

* Authentication
* Backend services
* Full application flows outside Dashboard/Cards unless required for navigation demo

---

# Technical Goals

## 1. Accuracy to Design

Implementation should closely match the Figma design:

* Typography
* Spacing
* Colors
* Shadows
* Border radius
* Icon sizing
* Card proportions
* Consistent layout behavior

## 2. Smooth UX

Animations should feel polished:

* Card entrance animations
* Value update transitions
* Loading skeletons
* Navigation transitions
* Micro-interactions on tap/press states

## 3. Clean Architecture

Use scalable Flutter architecture with separation of concerns.

Recommended structure:

```text
lib/
 ├── core/
 │   ├── theme/
 │   ├── utils/
 │   └── constants/
 ├── data/
 │   ├── models/
 │   ├── repositories/
 │   └── mock/
 ├── features/
 │   └── dashboard/
 │       ├── presentation/
 │       ├── widgets/
 │       └── state/
 └── main.dart
```

---

# Recommended Stack

## Framework

* Flutter (latest stable)

## State Management

Use one of:

* Riverpod (**recommended**)
* Bloc
* Provider

## Testing

* flutter_test
* mocktail / Mockito

## Optional Enhancements

* freezed + json_serializable
* go_router
* lints package

---

# Core Features

## Dashboard Screen

* Header / greeting section
* Summary metrics
* Scrollable content
* Responsive spacing

## Cards Section

Reusable cards supporting:

* Title
* Subtitle
* Balance / metric
* Trend indicator
* Icon/avatar
* Action state

## Real-Time Mock Data

Simulate updates using:

```dart
Stream.periodic(...)
Timer.periodic(...)
```

Examples:

* Balance changes
* Live metrics
* Status changes

## Error Handling

* Empty states
* Retry states
* Loading states
* Mock disconnection simulation

---

# Performance Requirements

* Smooth 60fps scrolling
* Minimal rebuilds
* Use `const` widgets where possible
* Use selectors/providers to reduce re-renders
* Lazy lists (`ListView.builder`)
* Image/icon optimization

---

# Testing Strategy

## Unit Tests

* Models
* Formatters
* Repositories
* State logic

## Widget Tests

* Dashboard renders correctly
* Cards display mocked data
* Loading/error states
* Tap interactions

---

# Responsive Design

Support:

* Small phones
* Standard phones
* Large devices

Use:

* `LayoutBuilder`
* `MediaQuery`
* Flexible / Expanded widgets
* Adaptive padding

---

# Git Workflow

Use meaningful commits showing progress:

```text
feat: setup project structure
feat: implement dashboard layout
feat: add reusable card widget
feat: integrate mock realtime stream
feat: add animations
test: add dashboard widget tests
docs: update README with demo
```

---

# README Deliverables

Repository should include:

## Setup

```bash
flutter pub get
flutter run
```

## Demo

Include:

* GIF
  or
* MP4 screen recording

## Notes

* Architecture decisions
* Packages used
* Known tradeoffs
* Future improvements

---

# Evaluation Strategy (How to Score High)

## Prioritize These First

1. Pixel-perfect UI
2. Smooth animations
3. Reusable widgets
4. Real-time updates with efficient rebuilds
5. Clean folder structure
6. Tests
7. Strong README

---

# Recommended Final Deliverable

A polished Flutter app that feels production-ready despite using mocked data.
