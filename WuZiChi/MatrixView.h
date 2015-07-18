//
//  MatrixView.h
//  GBDotMatrix
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotView.h"

@class MatrixView;
@class DotView;


#pragma mark - MatrixView Delegate
@protocol MatrixViewDelegate <NSObject>

@required
- (void)matrixView:(MatrixView*)matrix didTouchDot:(DotView*)dotView;

@end


@interface MatrixView : UIView

@property (strong, nonatomic) id<MatrixViewDelegate> delegate;


#pragma mark - Matrix Imformation
- (NSInteger)getMatrixNumberOfRow;
- (NSInteger)getMatrixNumberOfColumn;
- (DotView*)getDotViewWithIndexPath:(NSIndexPath*)indexPath;

#pragma mark - Initialize MatrixView
- (instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger)row withColumn:(NSInteger)column;

#pragma mark - Set Matrix
- (void)setMatrixWithArray:(NSArray*)array;
- (void)resetMatrix;


@end
