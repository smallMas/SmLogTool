//
//  SmLogManager.h
//  SmLogTool
//
//  Created by love on 2019/7/31.
//  Copyright © 2019 love. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SmLogLevel) {
    // 错误日志
    SmLogLevelError,
    // 警告日志
    SmLogLevelWarn,
    // 信息日志
    SmLogLevelInfo,
    // debug日志
    SmLogLevelDebug,
    // 详细日志
    SmLogLevelVerbose
};

// Define
#ifdef __cplusplus
#define CC_EXTERN  extern "C" __attribute__((visibility ("default")))
#else
#define CC_EXTERN  extern __attribute__((visibility ("default")))
#endif

// 日志宏
#define SmLogError(...) SM_Log (SmLogLevelError, __VA_ARGS__)
#define SmLogWarn(...) SM_Log (SmLogLevelWarn, __VA_ARGS__)
#define SmLogInfo(...) SM_Log (SmLogLevelInfo, __VA_ARGS__)
#define SmLogDebug(...) SM_Log (SmLogLevelDebug, __VA_ARGS__)
#define SmLogVerbose(...) SM_Log (SmLogLevelVerbose, __VA_ARGS__)

// Log
CC_EXTERN void SM_Log (SmLogLevel level, NSString *format, ...);

NS_ASSUME_NONNULL_BEGIN

@interface SmLogManager : NSObject

+ (instancetype)sharedInstance;

// 配置日志level 默认：SmLogLevelInfo
- (void)configLevel:(SmLogLevel)level;

// 日志写入文件
- (void)writeLogString:(NSString *)logString level:(SmLogLevel)level;

@end

NS_ASSUME_NONNULL_END
