//
//  SmLogOperation.m
//  SmLogTool
//
//  Created by love on 2019/7/31.
//  Copyright © 2019 love. All rights reserved.
//

#import "SmLogOperation.h"

@implementation SmLogOperation

- (void)main {
    // 想log写入文件
    //    fprintf (stderr, "%s\n", [logString UTF8String]);
    const char *path = [self.filePath cStringUsingEncoding:NSUTF8StringEncoding];
    const char *log_text = [self.logString UTF8String];
    FILE *file = fopen(path,"a");
    if (file) {
        fprintf(file, "%s\n", log_text);
        fclose(file);
    }
}

- (BOOL)isAsynchronous {
    return YES;
}

@end
