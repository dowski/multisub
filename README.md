# MultiSub

A demo app for testing multiple concurrent [Convex](https://www.convex.dev/) real-time subscriptions from a Swift iOS client.

The app displays 10 different types of randomly generated data (dice rolls, colors, animals, weather, playing cards, coordinates, scores, moods, words, and planets) across three tabs. Pressing the "Trigger Updates" button kicks off a 60-second cycle where each data type updates on its own independent schedule (every 5-10 seconds). The iOS app subscribes to these queries via the [ConvexMobile](https://github.com/get-convex/convex-swift) SDK, and only maintains active subscriptions for the currently visible tab.

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
