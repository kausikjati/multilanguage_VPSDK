# Implementation Plan (Phase 1 Bootstrap)

## Completed in this phase

1. Defined Swift-facing SDK entrypoint (`EditorSDK`) and headless timeline state APIs.
2. Added AI task and feature abstractions matching 2026 requirements.
3. Added Objective-C++ bridge interface for timeline updates, AI dispatch, and export.
4. Added C++ core engine stubs for decode/process/export orchestration.
5. Added Metal kernel placeholder for GPU rendering pipeline initialization.

## Next milestones

- Add package/build wiring (Swift Package + Xcode project + CMake for C++).
- Implement timeline JSON schema and bridge serializers.
- Add FFmpeg wrapper adapters for FLV/MKV decode fallback.
- Add Core ML + MPS Graph executors for AI feature set.
- Add export graph for HEVC MP4 and format presets.
