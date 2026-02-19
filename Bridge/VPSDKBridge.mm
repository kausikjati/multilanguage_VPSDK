#import "VPSDKBridge.h"

#include "../CoreMediaEngine/MediaEngine.hpp"

@implementation VPSDKBridge {
    vp::MediaEngine *_engine;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _engine = new vp::MediaEngine();
    }
    return self;
}

- (void)dealloc {
    delete _engine;
}

- (void)bootstrapEngine {
    _engine->initialize();
}

- (void)submitTimelineJSON:(NSString *)timelineJSON {
    _engine->updateTimeline([timelineJSON UTF8String]);
}

- (void)runAIFeature:(NSString *)feature payloadJSON:(NSString *)payloadJSON {
    _engine->runAIFeature([feature UTF8String], [payloadJSON UTF8String]);
}

- (void)exportWithOutputPath:(NSString *)outputPath codec:(NSString *)codec {
    _engine->exportMedia([outputPath UTF8String], [codec UTF8String]);
}

@end
