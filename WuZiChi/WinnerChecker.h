//
//  WinnerChecker.h
//  WuZiChi
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNone       0
#define kWinner     1
#define kBrokenRule 2

@interface WinnerChecker : NSObject

+ (NSInteger)checkWinnerWithIndexPath:(NSIndexPath*)indexPath withMatrix:(NSArray*)matrix;

@end
