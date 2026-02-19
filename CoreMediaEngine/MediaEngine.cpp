#include "MediaEngine.hpp"

#include <iostream>

namespace vp {

void MediaEngine::initialize() {
    std::cout << "MediaEngine initialized" << std::endl;
}

void MediaEngine::updateTimeline(const std::string& timelineJSON) {
    std::cout << "Timeline updated: " << timelineJSON << std::endl;
}

void MediaEngine::runAIFeature(const std::string& feature, const std::string& payloadJSON) {
    std::cout << "Run AI feature: " << feature << " payload=" << payloadJSON << std::endl;
}

void MediaEngine::exportMedia(const std::string& outputPath, const std::string& codec) {
    std::cout << "Export " << outputPath << " with codec " << codec << std::endl;
}

} // namespace vp
