//
//  FivePoint.h
//  GBDotMatrix
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MatrixView.h"
#import "DotView.h"
#import "WinnerChecker.h"

#define none        0
#define blackPlayer 1
#define whitePlayer 2


typedef NS_ENUM(NSInteger, gameResult) {
    
    gameResult_None,
    gameResult_BlackWin,
    gameResult_BlackBrokenRule,
    gameResult_WhiteWin,
    gameResult_WhiteBrokenRule
    
};


@class FivePoint;

@protocol FivePointDelegate <NSObject>

- (void)fivePoint:(FivePoint *)fivePoint didTouchDot:(DotView*)dotView martixArray:(NSArray*)matrixArray;
- (void)fivePoint:(FivePoint *)fivePoint didCheckGameResult:(gameResult)gameResult; //True => Black  False => White

@end

@interface FivePoint : NSObject

@property (strong, nonatomic) id<FivePointDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger)row withColumn:(NSInteger)column withDelegate:(id)delegate;
- (void)show;


- (void)resetGame;

@end
