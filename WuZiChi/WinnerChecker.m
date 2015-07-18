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
    
    int bingoCount = 0;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountCloumn = nowColumn - (4-i);
        
        if (nowCountCloumn>=0 && nowCountCloumn<19) {
            
            int martixPoint = [[[matrix objectAtIndex:nowRow] objectAtIndex:nowCountCloumn] intValue];
            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5){
                bingoCount = 0;
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
    }
    
    return kNone;
}

+ (NSInteger)checkVerticalWithNowRow:(int)nowRow withNowColumn:(int)nowColumn withCheckPlayer:(int)checkPlayer withMatrix:(NSArray*)matrix{
    
    int bingoCount = 0;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountRow = nowRow - (4-i);
        
        if (nowCountRow>=0 && nowCountRow<[matrix count]) {
            
            int martixPoint = [[[matrix objectAtIndex:nowCountRow] objectAtIndex:nowColumn] intValue];
            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5){
                bingoCount = 0;
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
    }
    
    return kNone;
}

+ (NSInteger)checkUpperRightWithNowRow:(int)nowRow withNowColumn:(int)nowColumn withCheckPlayer:(int)checkPlayer withMatrix:(NSArray*)matrix{
    
    int bingoCount = 0;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountRow = nowRow - (i-4);
        int nowCountColumn = nowColumn - (4-i);
        
        if (nowCountRow>=0 && nowCountColumn>=0 && nowCountRow <[matrix count] && nowCountColumn <[matrix count]) {
            
            int martixPoint = [[[matrix objectAtIndex:nowCountRow] objectAtIndex:nowCountColumn] intValue];
            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5){
                bingoCount = 0;
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
    }
    
    return kNone;
}

+ (NSInteger)checkUpperLeftWithNowRow:(int)nowRow withNowColumn:(int)nowColumn withCheckPlayer:(int)checkPlayer withMatrix:(NSArray*)matrix{
    
    int bingoCount = 0;
    
    for (int i = 0; i<9; i++) {
        
        int nowCountRow = nowRow - (i-4);
        int nowCountColumn = nowColumn - (i-4);
        
        if (nowCountRow>=0 && nowCountColumn>=0 && nowCountRow <[matrix count] && nowCountColumn <[matrix count]) {
            
            int martixPoint = [[[matrix objectAtIndex:nowCountRow] objectAtIndex:nowCountColumn] intValue];
            
            if (martixPoint == checkPlayer) {
                bingoCount++;
            }else if(bingoCount<5){
                bingoCount = 0;
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
    }
    
    return kNone;
}



@end
