//
//  SmLogFile.m
//  SmLogTool
//
//  Created by love on 2019/7/31.
//  Copyright © 2019 love. All rights reserved.
//

#import "SmLogFile.h"

@implementation SmLogFile

+ (NSString *)rootPath {
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return cacheFolder;
}

+ (NSString *)logFolderPath {
    NSString *folder = @"SmLogs";
    NSString *path = [NSString stringWithFormat:@"%@/%@",[self rootPath],folder];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)stringWithDate:(NSDate *)date formatter:(NSString *)dateFormatter {
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter2 setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter2 setDateFormat:dateFormatter];
    NSString *dateStr = [dateFormatter2 stringFromDate:date];
    return dateStr;
}

+ (NSString *)todayString {
    return [self stringWithDate:[NSDate date] formatter:@"yyyy-MM-dd"];
}

+ (NSArray *)allLogFilesIsExceptToday:(BOOL)isExceptToday {
    NSString *today = [self todayString];
    NSMutableArray *array = [NSMutableArray new];
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:[self logFolderPath] error:nil];
    for (NSString *name in files) {
        NSArray *arr = [name componentsSeparatedByString:@"."];
        NSString *suffix = arr.lastObject;
        if ([suffix isEqualToString:@"log"]) {
            BOOL isAdd = YES;
            NSString *date = arr.firstObject;
            if (isExceptToday == YES && [date isEqualToString:today]) {
                isAdd = NO;
            }
            if (isAdd) {
                [array addObject:name];
            }
        }
    }
    return array;
}


@end
