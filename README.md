# MultiSub

A SwiftUI iOS app that subscribes to real-time data from a Convex backend.

## Prerequisites

- Xcode 15+
- Node.js 18+
- A free [Convex](https://www.convex.dev/) account (or use the local dev server)

## Setup

### Backend

```bash
npm install
npx convex dev --local
```

This starts the Convex dev server on `http://127.0.0.1:3210`.

### iOS App

Open the Xcode project:

```bash
open ios/MultiSub/MultiSub.xcodeproj
```

Build and run on the iOS Simulator (Cmd+R).

### Running on a physical device

Update the deployment URL in `ios/MultiSub/App/ConvexClientProvider.swift` to your machine's LAN IP address (e.g. `http://192.168.1.100:3210`) so the device can reach the Convex dev server.
