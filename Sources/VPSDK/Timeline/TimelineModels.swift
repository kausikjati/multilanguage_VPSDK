import Foundation

public struct Timeline: Sendable {
    public var tracks: [Track]

    public init(tracks: [Track] = []) {
        self.tracks = tracks
    }
}

public struct Track: Identifiable, Sendable {
    public let id: UUID
    public var mediaType: MediaType
    public var clips: [Clip]

    public init(id: UUID = UUID(), mediaType: MediaType, clips: [Clip] = []) {
        self.id = id
        self.mediaType = mediaType
        self.clips = clips
    }
}

public struct Clip: Identifiable, Sendable {
    public let id: UUID
    public var sourcePath: String
    public var startSeconds: Double
    public var endSeconds: Double
    public var playbackRate: Double

    public init(id: UUID = UUID(), sourcePath: String, startSeconds: Double, endSeconds: Double, playbackRate: Double = 1.0) {
        self.id = id
        self.sourcePath = sourcePath
        self.startSeconds = startSeconds
        self.endSeconds = endSeconds
        self.playbackRate = playbackRate
    }
}

public enum MediaType: String, Sendable {
    case video
    case audio
    case image
    case text
}

public final class TimelineController {
    public private(set) var timeline = Timeline()

    public init() {}

    public func addTrack(_ track: Track) {
        timeline.tracks.append(track)
    }

    public func upsertClip(_ clip: Clip, trackID: UUID) {
        guard let idx = timeline.tracks.firstIndex(where: { $0.id == trackID }) else { return }
        if let clipIndex = timeline.tracks[idx].clips.firstIndex(where: { $0.id == clip.id }) {
            timeline.tracks[idx].clips[clipIndex] = clip
        } else {
            timeline.tracks[idx].clips.append(clip)
        }
    }
}
