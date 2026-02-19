# VPSDK Implementation Plan + Complete Xcode Setup Guide

This document replaces the high-level phase note with a practical, end-to-end setup flow so any engineer can clone the repo and create a working iOS SDK host project with Swift + Objective-C++ + C++ + Metal.

---

## 1) Current repository status

### Implemented foundation

1. Swift API surface and headless timeline abstractions under `Sources/VPSDK/`.
2. Objective-C++ bridge contract in `Bridge/`.
3. C++ media engine stubs in `CoreMediaEngine/`.
4. Metal shader placeholder in `RenderingEngine/`.
5. Swift Package manifest (`Package.swift`) for building the Swift layer.

### Gaps still to implement

- No Xcode project exists yet.
- Objective-C++ / C++ / Metal layers are not yet wired into an iOS app target.
- No FFmpeg integration yet.
- No Core ML / MPSGraph pipeline implementation yet.

---

## 2) Recommended project topology

Create an Xcode workspace with a host app and SDK modules:

- `VPSDKHostApp` (iOS demo app)
- `VPSDKSwift` (Swift package target; already available via `Package.swift`)
- `VPSDKBridge` (Objective-C++ static library target)
- `VPSDKCore` (C++ static library target)
- `VPSDKShaders` (Metal shader bundle compiled in app target)

Suggested source mapping:

- `Sources/VPSDK/**` → included through Swift Package dependency
- `Bridge/VPSDKBridge.h`, `Bridge/VPSDKBridge.mm` → Bridge target
- `CoreMediaEngine/MediaEngine.hpp`, `CoreMediaEngine/MediaEngine.cpp` → Core target
- `RenderingEngine/VideoKernels.metal` → Host app (or dedicated rendering target)

---

## 3) Step-by-step Xcode setup (complete)

## Step A — Create workspace and app

1. Open Xcode → **File > New > Project**.
2. Choose **iOS App** (UIKit or SwiftUI; UIKit recommended for editor UI prototyping).
3. Product Name: `VPSDKHostApp`.
4. Interface: your preference, Language: Swift.
5. Save project at repo root as `VPSDKHostApp.xcodeproj`.
6. Create workspace: **File > Save As Workspace...** → `VPSDK.xcworkspace`.
7. Ensure project is opened inside `VPSDK.xcworkspace`.

## Step B — Add Swift package (existing repo code)

1. Select project in navigator.
2. Go to **Package Dependencies**.
3. Click **+** and choose **Add Local...**.
4. Select repository root (`/workspace/multilanguage_VPSDK`) where `Package.swift` exists.
5. Link product `VPSDK` to `VPSDKHostApp` target.

Validation:
- In app source, `import VPSDK` should compile.

## Step C — Add C++ core static library target

1. **File > New > Target...**
2. macOS/iOS Framework & Library → **Static Library** (or Framework if preferred).
3. Name target: `VPSDKCore`.
4. Language: C++.
5. Add files:
   - `CoreMediaEngine/MediaEngine.hpp`
   - `CoreMediaEngine/MediaEngine.cpp`
6. Build settings for `VPSDKCore`:
   - **C++ Language Dialect**: `GNU++20` or `C++20`.
   - **C++ Standard Library**: `libc++`.
   - **Enable Modules (C and Objective-C)**: `Yes`.

## Step D — Add Objective-C++ bridge target

1. **File > New > Target...** → Static Library.
2. Name target: `VPSDKBridge`.
3. Add files:
   - `Bridge/VPSDKBridge.h`
   - `Bridge/VPSDKBridge.mm`
4. Ensure `.mm` extension remains Objective-C++.
5. In `VPSDKBridge` Build Settings:
   - **Header Search Paths** include:
     - `$(SRCROOT)/CoreMediaEngine`
     - `$(SRCROOT)/Bridge`
   - **Other Linker Flags** include `-lc++`.
6. Link `VPSDKCore` into `VPSDKBridge` (Target Dependencies + Link Binary With Libraries).

## Step E — Expose bridge to Swift host app

For app-level bridge usage:

1. In `VPSDKHostApp`, create `VPSDKHostApp-Bridging-Header.h`.
2. Add:
   ```objc
   #import "VPSDKBridge.h"
   ```
3. In `VPSDKHostApp` Build Settings set:
   - **Objective-C Bridging Header** = `VPSDKHostApp/VPSDKHostApp-Bridging-Header.h`
4. Add `VPSDKBridge` to app target dependencies and link libraries.

Alternative (preferred long-term): wrap bridge in a Swift target and avoid app-level bridging header leakage.

## Step F — Add Metal shader compilation

1. Add `RenderingEngine/VideoKernels.metal` to `VPSDKHostApp` target.
2. Confirm Build Phases contains **Compile Metal Sources**.
3. Ensure app Build Settings:
   - **Metal Compiler - Language Revision**: latest supported.
   - **Enable Metal API Validation**: Yes (Debug), No (Release).

## Step G — Runtime bootstrap smoke test

In app startup (`AppDelegate` or initial view model), verify all layers initialize:

```swift
import VPSDK

let sdk = EditorSDK()
sdk.initialize()

let videoTrack = Track(mediaType: .video)
sdk.timeline.addTrack(videoTrack)
```

If using ObjC++ bridge directly from Swift host:

```swift
let bridge = VPSDKBridge()
bridge.bootstrapEngine()
bridge.submitTimelineJSON("{\"tracks\":[]}")
```

---

## 4) Build configuration matrix

Use consistent settings across targets:

- iOS Deployment Target: `16.0+`
- Swift Version: `5.9+`
- Debug:
  - `SWIFT_OPTIMIZATION_LEVEL = -Onone`
  - Metal API validation ON
- Release:
  - `SWIFT_OPTIMIZATION_LEVEL = -O`
  - dead code stripping ON
  - Metal API validation OFF

---

## 5) CI baseline checks (must pass)

1. `swift build`
2. `xcodebuild -workspace VPSDK.xcworkspace -scheme VPSDKHostApp -configuration Debug -sdk iphonesimulator build`
3. (Later) unit tests + integration render tests on simulator.

---

## 6) Next implementation milestones (engineering)

1. Timeline serialization contract
   - Define JSON schema for tracks/clips/effects.
   - Implement Swift → Bridge translation.
2. Decode pipeline
   - Integrate FFmpeg wrapper for MKV/FLV fallback.
   - Normalize into CVPixelBuffer-compatible frames.
3. AI pipeline
   - Add Core ML model runners.
   - Add MPSGraph-optimized operators for frame-level tasks.
4. Render graph
   - Replace passthrough Metal kernel with effect chain execution.
5. Export pipeline
   - Implement HEVC/H.265 MP4 output and quality presets.

---

## 7) Definition of done for “Xcode setup complete”

Xcode setup is considered complete only when all are true:

- Workspace exists (`VPSDK.xcworkspace`).
- Host app target builds on simulator.
- Local package `VPSDK` resolves and imports in app code.
- Objective-C++ bridge compiles and links with C++ core.
- Metal file compiles via `Compile Metal Sources`.
- Smoke test executes `EditorSDK` init + bridge bootstrap without crash.

