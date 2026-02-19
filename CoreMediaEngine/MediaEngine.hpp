#pragma once

#include <string>

namespace vp {

class MediaEngine {
public:
    void initialize();
    void updateTimeline(const std::string& timelineJSON);
    void runAIFeature(const std::string& feature, const std::string& payloadJSON);
    void exportMedia(const std::string& outputPath, const std::string& codec);
};

} // namespace vp
