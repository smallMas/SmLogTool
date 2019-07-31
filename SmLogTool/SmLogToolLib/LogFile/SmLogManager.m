//
//  SmLogManager.m
//  SmLogTool
//
//  Created by love on 2019/7/31.
//  Copyright © 2019 love. All rights reserved.
//

#import "SmLogManager.h"
#import "SmLogFile.h"
#import "SmLogOperation.h"

void SM_LogString (SmLogLevel level, NSString *string)
{
    if (DEBUG) {
        NSLog(@"%@",string);
    }
    [[SmLogManager sharedInstance] writeLogString:string level:level];
}

void SM_Log (SmLogLevel level, NSString *format, ...)
{
    NSString *string;
    {
        va_list argList;
        va_start(argList, format);
        string = [[NSString alloc] initWithFormat:format arguments:argList];
        va_end(argList);
    }
    SM_LogString(level, string);
}

@interface SmLogManager ()

@property (nonatomic, strong) NSOperationQueue *writeQueue;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSDateFormatter *dateFormatter1;
@property (nonatomic, assign) SmLogLevel level;

@end

@implementation SmLogManager

+ (instancetype)sharedInstance {
    static SmLogManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [SmLogManager new];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _writeQueue = [NSOperationQueue new];
        _writeQueue.maxConcurrentOperationCount = 1;
        dispatch_queue_t queue = dispatch_queue_create("SM_LOG", DISPATCH_QUEUE_SERIAL);
        _writeQueue.underlyingQueue = queue;
        self.level = SmLogLevelInfo;
        
        [self createDefaultPath];
    }
    return self;
}

#pragma mark - 懒加载
- (NSString *)fileName {
    if (!_fileName) {
        _fileName = [SmLogFile todayString];
    }
    return _fileName;
}

- (NSDateFormatter *)dateFormatter1 {
    if (!_dateFormatter1) {
        _dateFormatter1 = [[NSDateFormatter alloc] init];
        _dateFormatter1.locale = [NSLocale currentLocale];
        _dateFormatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    }
    return _dateFormatter1;
}

#pragma mark - 内部方法
- (void)createDefaultPath {
    NSString *name = [NSString stringWithFormat:@"%@.log",self.fileName];
    self.filePath = [[SmLogFile logFolderPath] stringByAppendingPathComponent:name];
    NSLog(@"日志路径 : %@",self.filePath);
}

#pragma mark - 外部方法
- (void)configLevel:(SmLogLevel)level {
    _level = level;
}

- (void)writeLogString:(NSString *)logString level:(SmLogLevel)level {
    if (level <= self.level) {
        if (self.filePath) {
            NSString *string = [self stringWithLogInfo:logString level:level];
            SmLogOperation *operation = [SmLogOperation new];
            operation.filePath = self.filePath;
            operation.logString = string;
            [self.writeQueue addOperation:operation];
        }
    }
}

- (NSString *)stringWithLogInfo:(NSString *)logInfo level:(SmLogLevel)level {
    NSString *timestamp = [self.dateFormatter1 stringFromDate:[NSDate date]];
    NSString *string = [NSString stringWithFormat:@"%@ [%@] %@", timestamp, [self stringWithLevel:level], logInfo];
    return string;
}

- (NSString *)stringWithLevel:(SmLogLevel)level {
    NSString *str = @"";
    switch (level) {
        case SmLogLevelError:
            str = @"ERROR";
            break;
            
        case SmLogLevelWarn:
            str = @"WARN";
            break;
            
        case SmLogLevelInfo:
            str = @"INFO";
            break;
            
        case SmLogLevelDebug:
            str = @"DEBUG";
            break;
            
        case SmLogLevelVerbose:
            str = @"VERBOSE";
            break;
            
        default:
            break;
    }
    return str;
}

@end
