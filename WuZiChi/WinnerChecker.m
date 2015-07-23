//
//  WinnerChecker.m
//  WuZiChi
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import "WinnerChecker.h"
#import <UIKit/UIKit.h>
#import "FivePoint.h"

@implementation WinnerChecker

+ (NSInteger)checkWinnerWithIndexPath:(NSIndexPath*)indexPath withMatrix:(NSArray*)matrix{
    
//    NSInteger isShowUpWinner = 0;
    
//    int rowCount        = (int)[matrix count];
//    int columnCount     = (int)[[matrix firstObject] count];  //Default is 19;
    
    int nowRow = (int)indexPath.row;
    int nowColumn = (int)indexPath.section;
    
    int checkPlayer = [[[matrix objectAtIndex:nowRow] objectAtIndex:nowColumn] intValue];
    
    
    NSInteger checkHorizontal = [self checkHorizontalWithNowRow:nowRow
                                                  withNowColumn:nowColumn
                                                withCheckPlayer:checkPlayer
                                                     withMatrix:matrix];
    
    NSInteger checkVertical = [self checkVerticalWithNowRow:nowRow
                                              withNowColumn:nowColumn
                                            withCheckPlayer:checkPlayer
                                                 withMatrix:matrix];
    
    NSInteger checkUpperRight = [self checkUpperRightWithNowRow:nowRow
                                                  withNowColumn:nowColumn
                                                withCheckPlayer:checkPlayer
                                                     withMatrix:matrix];
    
    NSInteger checkUpperLeft = [self checkUpperLeftWithNowRow:nowRow
                                                withNowColumn:nowColumn
                                              withCheckPlayer:checkPlayer
                                                   withMatrix:matrix];
    
    if (checkHorizontal == kBrokenRule || checkVertical == kBrokenRule ||
        checkUpperLeft == kBrokenRule || checkUpperRight ==  kBrokenRule) {

        return kBrokenRule;
        
    }else if (checkHorizontal == kWinner || checkVertical == kWinner ||
              checkUpperLeft == kWinner || checkUpperRight ==  kWinner){
        
        return kWinner;
    }
    
    
    return kNone;
}

+ (NSInteger)checkHorizontalWithNowRow:(int)nowRow withNowColumn:(int)nowColumn withCheckPlayer:(int)checkPlayer withMatrix:(NSArray*)matrix{
    
    int     bingoCount = 0;
    int     lastPoint  = 0;
    
    NSIndexPath  *startPoint;
    NSIndexPath  *endPoint;
    BOOL    fourPointWinCheck = NO;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountCloumn = nowColumn - (4-i);
        
        if (nowCountCloumn>=0 && nowCountCloumn<[matrix count]) {
            
            int martixPoint = [[[matrix objectAtIndex:nowRow] objectAtIndex:nowCountCloumn] intValue];
            
            
            //Four Point Check Setting Start Point & End Point
            if (nowCountCloumn>0 && nowCountCloumn<[matrix count] && martixPoint == checkPlayer) {
                
                if (bingoCount == 0 && lastPoint == 0) {
                    startPoint = [NSIndexPath indexPathForItem:nowRow inSection:nowCountCloumn];
                    fourPointWinCheck = YES;
                }

            }else if (nowCountCloumn>0 && nowCountCloumn<[matrix count] && martixPoint != checkPlayer){
                
                if (bingoCount == 4 && lastPoint == checkPlayer) {
                    endPoint = [NSIndexPath indexPathForItem:nowRow inSection:nowCountCloumn -1];
                }else{
                    fourPointWinCheck = NO;
                    startPoint = nil;
                }
                
            }
            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5 && !fourPointWinCheck){
                bingoCount = 0;
            }
            
            if (endPoint == nil) {
                //Store lastPoint
                lastPoint = martixPoint;
            }

            
        }
        
    }
    
    if (bingoCount == 5) {
        return kWinner;
    }else if (bingoCount>5){
        
        if (checkPlayer == 2) {
            return kWinner;
        }
        return kBrokenRule;
    }else if (bingoCount == 4 && startPoint != nil && endPoint != nil){
        
        int beforeStartPoint = [matrix[startPoint.row][startPoint.section - 1] intValue];
        int afterEndPoint    = [matrix[endPoint.row][endPoint.section + 1] intValue];
        
        if (beforeStartPoint == 0 && afterEndPoint == 0) {
            return kWinner;
        }

    }
    
    return kNone;
}

+ (NSInteger)checkVerticalWithNowRow:(int)nowRow withNowColumn:(int)nowColumn withCheckPlayer:(int)checkPlayer withMatrix:(NSArray*)matrix{
    
    int bingoCount = 0;
    int lastPoint  = 0;
    NSIndexPath  *startPoint;
    NSIndexPath  *endPoint;
    BOOL    fourPointWinCheck = NO;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountRow = nowRow - (4-i);
        
        if (nowCountRow>=0 && nowCountRow<[matrix count]) {
            
            int martixPoint = [[[matrix objectAtIndex:nowCountRow] objectAtIndex:nowColumn] intValue];
            
            //Four Point Check Setting Start Point & End Point
            if (nowCountRow>0 && nowCountRow<[matrix count] && martixPoint == checkPlayer) {
                
                if (bingoCount == 0 && lastPoint == 0) {
                    startPoint = [NSIndexPath indexPathForItem:nowCountRow inSection:nowColumn];
                    fourPointWinCheck = YES;
                }
                
            }else if (nowCountRow>0 && nowCountRow<[matrix count] && martixPoint != checkPlayer){
                
                if (bingoCount == 4 && lastPoint == checkPlayer) {
                    endPoint = [NSIndexPath indexPathForItem:nowCountRow -1 inSection:nowColumn];
                }else{
                    fourPointWinCheck = NO;
                    startPoint = nil;
                }
                
            }

            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5 && !fourPointWinCheck){
                bingoCount = 0;
            }
            
            
            if (endPoint == nil) {
                //Store lastPoint
                lastPoint = martixPoint;
            }
        }
        
    }
    
    if (bingoCount == 5) {
        return kWinner;
    }else if (bingoCount>5){
        
        if (checkPlayer == 2) {
            return kWinner;
        }
        return kBrokenRule;
    }else if (bingoCount == 4 && startPoint != nil && endPoint != nil){
        
        int beforeStartPoint = [matrix[startPoint.row -1][startPoint.section] intValue];
        int afterEndPoint    = [matrix[endPoint.row +1][endPoint.section] intValue];
        
        if (beforeStartPoint == 0 && afterEndPoint == 0) {
            return kWinner;
        }
        
    }
    
    return kNone;
}

+ (NSInteger)checkUpperRightWithNowRow:(int)nowRow withNowColumn:(int)nowColumn withCheckPlayer:(int)checkPlayer withMatrix:(NSArray*)matrix{
    
    int bingoCount = 0;
    
    int lastPoint  = 0;
    NSIndexPath  *startPoint;
    NSIndexPath  *endPoint;
    BOOL    fourPointWinCheck = NO;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountRow = nowRow - (i-4);
        int nowCountColumn = nowColumn - (4-i);
        
        if (nowCountRow>=0 && nowCountColumn>=0 && nowCountRow <[matrix count] && nowCountColumn <[matrix count]) {
            
            int martixPoint = [[[matrix objectAtIndex:nowCountRow] objectAtIndex:nowCountColumn] intValue];
            
            //Four Point Check Setting Start Point & End Point
            if (nowCountRow>0 && nowCountRow<[matrix count]
                &&nowCountColumn>0 && nowCountColumn<[matrix count] && martixPoint == checkPlayer) {
                
                if (bingoCount == 0 && lastPoint == 0) {
                    startPoint = [NSIndexPath indexPathForItem:nowCountRow inSection:nowCountColumn];
                    fourPointWinCheck = YES;
                }
                
            }else if (nowCountRow>0 && nowCountRow<[matrix count]
                      && nowCountColumn>0 && nowCountColumn<[matrix count] && martixPoint != checkPlayer){
                
                if (bingoCount == 4 && lastPoint == checkPlayer) {
                    endPoint = [NSIndexPath indexPathForItem:nowCountRow +1 inSection:nowCountColumn -1];
                }else{
                    fourPointWinCheck = NO;
                    startPoint = nil;
                }
                
            }
            
            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5 && !fourPointWinCheck){
                bingoCount = 0;
            }
            
            
            if (endPoint == nil) {
                //Store lastPoint
                lastPoint = martixPoint;
            }
            
        }
        
        
    }
    
    if (bingoCount == 5) {
        return kWinner;
    }else if (bingoCount>5){
        
        if (checkPlayer == 2) {
            return kWinner;
        }
        return kBrokenRule;
    }else if (bingoCount == 4 && startPoint != nil && endPoint != nil){
        
        int beforeStartPoint = [matrix[startPoint.row +1][startPoint.section -1] intValue];
        int afterEndPoint    = [matrix[endPoint.row -1][endPoint.section +1] intValue];
        
        if (beforeStartPoint == 0 && afterEndPoint == 0) {
            return kWinner;
        }
        
    }
    
    return kNone;
}

+ (NSInteger)checkUpperLeftWithNowRow:(int)nowRow withNowColumn:(int)nowColumn withCheckPlayer:(int)checkPlayer withMatrix:(NSArray*)matrix{
    
    int bingoCount = 0;
    
    int lastPoint  = 0;
    NSIndexPath  *startPoint;
    NSIndexPath  *endPoint;
    BOOL    fourPointWinCheck = NO;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountRow = nowRow - (i-4);
        int nowCountColumn = nowColumn - (i-4);
        
        if (nowCountRow>=0 && nowCountColumn>=0 && nowCountRow <[matrix count] && nowCountColumn <[matrix count]) {
            
            int martixPoint = [[[matrix objectAtIndex:nowCountRow] objectAtIndex:nowCountColumn] intValue];
            
            //Four Point Check Setting Start Point & End Point
            if (nowCountRow>0 && nowCountRow<[matrix count]
                &&nowCountColumn>0 && nowCountColumn<[matrix count] && martixPoint == checkPlayer) {
                
                if (bingoCount == 0 && lastPoint == 0) {
                    startPoint = [NSIndexPath indexPathForItem:nowCountRow inSection:nowCountColumn];
                    fourPointWinCheck = YES;
                }
                
            }else if (nowCountRow>0 && nowCountRow<[matrix count]
                      && nowCountColumn>0 && nowCountColumn<[matrix count] && martixPoint != checkPlayer){
                
                if (bingoCount == 4 && lastPoint == checkPlayer) {
                    endPoint = [NSIndexPath indexPathForItem:nowCountRow +1 inSection:nowCountColumn +1];
                }else{
                    fourPointWinCheck = NO;
                    startPoint = nil;
                }
                
            }
            
            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5 && !fourPointWinCheck){
                bingoCount = 0;
            }
            
            
            if (endPoint == nil) {
                //Store lastPoint
                lastPoint = martixPoint;
            }

            
        }
        
    }
    
    if (bingoCount == 5) {
        return kWinner;
    }else if (bingoCount>5){
        
        if (checkPlayer == 2) {
            return kWinner;
        }
        return kBrokenRule;
    }else if (bingoCount == 4 && startPoint != nil && endPoint != nil){
        
        int beforeStartPoint = [matrix[startPoint.row +1][startPoint.section +1] intValue];
        int afterEndPoint    = [matrix[endPoint.row -1][endPoint.section -1] intValue];
        
        if (beforeStartPoint == 0 && afterEndPoint == 0) {
            return kWinner;
        }
        
    }
    
    
    return kNone;
}



@end
