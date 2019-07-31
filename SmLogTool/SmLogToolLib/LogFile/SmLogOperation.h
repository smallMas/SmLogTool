//
//  SmLogOperation.h
//  SmLogTool
//
//  Created by love on 2019/7/31.
//  Copyright © 2019 love. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmLogOperation : NSOperation

// 文件路径
@property (nonatomic, strong) NSString *filePath;

// 文本
@property (nonatomic, strong) NSString *logString;

@end

NS_ASSUME_NONNULL_END
