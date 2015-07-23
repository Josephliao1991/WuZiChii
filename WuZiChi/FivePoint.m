//
//  FivePoint.m
//  GBDotMatrix
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import "FivePoint.h"

@interface FivePoint ()<MatrixViewDelegate>

{
    
    BOOL isStopNow;
    BOOL nowPlayer; //True is Black // False is White
    NSMutableArray *matrixArray;
    MatrixView *theMatrix;
}

@end


@implementation FivePoint

- (instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger)row withColumn:(NSInteger)column withDelegate:(id)delegate{
    
    self = [super init];
    
    isStopNow   = NO;
    nowPlayer   = YES;
    
    //set Empty Matrix Arrey
    [self setEmptyMatrixWithRow:row withColumn:column];
    
    self.delegate = delegate;
    
    theMatrix = [[MatrixView alloc]initWithFrame:frame withRow:row withColumn:column];
    theMatrix.delegate = self;
    theMatrix.backgroundColor = [UIColor brownColor];
    
    return self;
}

- (void)show{
    
    UIViewController *controller = (UIViewController*)self.delegate;
    
    [controller.view addSubview:theMatrix];
    
}

#pragma mark -
#pragma mark MatrixView Delegate
#pragma mark -

- (void)matrixView:(MatrixView *)matrix didTouchDot:(DotView *)dotView{
    
    if (isStopNow) {
        return;
    }
    
    if (![self checkLegelWithIndexPath:dotView.indexPath]) {
        return;
    }
    
    UIColor     *dotColor;
    NSInteger   player;
    
    if (nowPlayer) {
        dotColor    = [UIColor blackColor];
        player      = 1;
    }else{
        dotColor    = [UIColor whiteColor];
        player      = 2;
    }
    
    
    [dotView changeBackgroundColorWithColor:dotColor];
    [dotView changeBackgroundOpacityWithAlpha:1];
    [self setCheckWithIndexPath:dotView.indexPath withPlayer:player];
    
    //Delegate to ViewController
    if (self.delegate) {
        [self.delegate fivePoint:self didTouchDot:dotView martixArray:matrixArray];
    }
    
    
    //Check is the Winner is show up Or SomeOne Broken Rule
    NSInteger winnerCheck = [WinnerChecker checkWinnerWithIndexPath:dotView.indexPath withMatrix:matrixArray];
    
    
    switch (winnerCheck) {
        case 0:
            //Change Player
            nowPlayer = !nowPlayer;

            break;
            
        case 1:
            //Call View Controller
            if (nowPlayer) {
                [self.delegate fivePoint:self didCheckGameResult:gameResult_BlackWin];
            }else{
                [self.delegate fivePoint:self didCheckGameResult:gameResult_WhiteWin];
            }
            
            //stop the game            
            isStopNow = YES;
            
            //reset Player to Black
            nowPlayer = YES;
            

            break;
            
        case 2:
            //Call View Controller
            if (nowPlayer) {
                [self.delegate fivePoint:self didCheckGameResult:gameResult_BlackBrokenRule];
            }else{
                [self.delegate fivePoint:self didCheckGameResult:gameResult_WhiteBrokenRule];
            }
            
            //stop the game
            isStopNow = YES;
            
            //reset Player to Black
            nowPlayer = YES;
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark -
#pragma mark matrix Check & Setting
#pragma mark -

- (void)setEmptyMatrixWithRow:(NSInteger)row withColumn:(NSInteger)column{
    
    matrixArray = [NSMutableArray array];
    
    for (int r = 0; r < row; r++) {
        
        NSMutableArray *columnArray = [NSMutableArray array];
        
        for (int c = 0; c < column; c++) {
            
            [columnArray addObject:[NSNumber numberWithInteger:0]];
            
        }
        
        
        [matrixArray addObject:columnArray];
        
    }
    
}

- (void)setCheckWithIndexPath:(NSIndexPath*)indexPath withPlayer:(NSInteger)player{
    
    NSMutableArray *columnArray = [matrixArray objectAtIndex:indexPath.row];
    [columnArray replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithInteger:player]];
    [matrixArray replaceObjectAtIndex:indexPath.row withObject:columnArray];
    
}

- (BOOL)checkLegelWithIndexPath:(NSIndexPath*)indexPath{
    
    
    NSMutableArray *columnArray = [matrixArray objectAtIndex:indexPath.row];
    
    int check = [[columnArray objectAtIndex:indexPath.section] intValue];
    if (check == 0) {
        return YES;
    }
    
    return NO;
}

#pragma mark -
#pragma mark Game Controller
#pragma mark -

- (void)resetGame{
    
    //reset Matrix
    [theMatrix resetMatrix];
    [self setEmptyMatrixWithRow:[theMatrix getMatrixNumberOfRow] withColumn:[theMatrix getMatrixNumberOfColumn]];
    
    isStopNow = NO;
}

@end
