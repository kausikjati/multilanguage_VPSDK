import Foundation

public final class EditorSDK {
    public let timeline: TimelineController
    public let ai: AIEditingController

    public init(timeline: TimelineController = TimelineController(),
                ai: AIEditingController = AIEditingController()) {
        self.timeline = timeline
        self.ai = ai
    }

    public func initialize() {
        // Startup hooks for bridge/bootstrap orchestration.
    }
}

public struct SDKConfiguration: Sendable {
    public var enablePrebuiltUI: Bool
    public var enableHeadlessMode: Bool
    public var preferredExportCodec: ExportCodec

    public init(enablePrebuiltUI: Bool = true,
                enableHeadlessMode: Bool = true,
                preferredExportCodec: ExportCodec = .hevcH265) {
        self.enablePrebuiltUI = enablePrebuiltUI
        self.enableHeadlessMode = enableHeadlessMode
        self.preferredExportCodec = preferredExportCodec
    }
}

public enum ExportCodec: String, Sendable {
    case hevcH265
    case h264
}
