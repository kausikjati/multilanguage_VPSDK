#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VPSDKBridge : NSObject

- (void)bootstrapEngine;
- (void)submitTimelineJSON:(NSString *)timelineJSON;
- (void)runAIFeature:(NSString *)feature payloadJSON:(NSString *)payloadJSON;
- (void)exportWithOutputPath:(NSString *)outputPath codec:(NSString *)codec;

@end

NS_ASSUME_NONNULL_END
