import Foundation

public enum AIFeature: String, CaseIterable, Sendable {
    case autoCutSceneDetection
    case backgroundMatting
    case generativeBRoll
    case dynamicAutoCaptions
    case frameInterpolation
    case photoBackgroundRemoval
    case generativeFillErase
    case smartAutoEnhance
    case aiUpscaling
}

public struct AITask: Sendable {
    public var feature: AIFeature
    public var sourceAssetIDs: [String]

    public init(feature: AIFeature, sourceAssetIDs: [String]) {
        self.feature = feature
        self.sourceAssetIDs = sourceAssetIDs
    }
}

public final class AIEditingController {
    public init() {}

    public func enqueue(_ task: AITask) {
        // TODO: Forward through bridge to Metal/CoreML execution layer.
    }
}
