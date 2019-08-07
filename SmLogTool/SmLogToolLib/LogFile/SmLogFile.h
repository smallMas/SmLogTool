//
//  SmLogFile.h
//  SmLogTool
//
//  Created by love on 2019/7/31.
//  Copyright © 2019 love. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmLogFile : NSObject

+ (NSString *)todayString;
+ (NSString *)logFolderPath;
// 列举出日志目录下的所有日志文件，是否除去今天的日志
+ (NSArray *)allLogFilesIsExceptToday:(BOOL)isExceptToday;

@end

NS_ASSUME_NONNULL_END
