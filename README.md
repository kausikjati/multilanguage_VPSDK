# Multilanguage_VPSDK

Initial implementation scaffold for a multilayer iOS AI video/photo editing SDK.

## Implemented foundation

- Swift API and headless timeline abstractions in `Sources/VPSDK`
- Objective-C++ bridge contract in `Bridge/`
- C++ media engine interfaces in `CoreMediaEngine/`
- Metal shader + render pipeline contracts in `RenderingEngine/`
- Delivery roadmap in `docs/implementation-plan.md`

This commit focuses on **architecture-first bootstrapping** so language layers can evolve in parallel.
