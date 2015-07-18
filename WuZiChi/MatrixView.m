//
//  MatrixView.m
//  GBDotMatrix
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import "MatrixView.h"

#define kDotGap     2

@interface MatrixView ()

@property (assign, nonatomic) NSInteger totalRow;
@property (assign, nonatomic) NSInteger totalColumn;
@property (strong, nonatomic) NSMutableArray *dotViewArray;

@end

@implementation MatrixView

#pragma mark -
#pragma mark - Initialize MatrixView
#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger)row withColumn:(NSInteger)column{
    
    self = [super initWithFrame:frame];
    
    
    //Creat DotView and store in dotViewArray
    CGSize dotSize = [self getDotSizeWithFrame:frame withRow:row withColumn:column];
    CGSize matrixSize = [self getMatrixSizeWithDotSize:dotSize withRow:row withColumn:column];
    
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, matrixSize.width, matrixSize.height);
    
    
    self.dotViewArray = [NSMutableArray array];
    
    
    for (int r = 0; r < row; r++) {
        
        NSMutableArray *columnArray = [NSMutableArray array];
        
        for (int c = 0; c < column; c++) {
            
            CGPoint dotCenterPoint = [self getDotCenterPointWithDotSize:dotSize withRow:r withColumn:c];
            CGRect dotViewRect = CGRectMake(0, 0, dotSize.width, dotSize.height);
            
            DotView *dotView = [[DotView alloc]initWithFrame:dotViewRect
                                                   withImage:nil
                                                     withRow:r
                                                  withColumn:c
                                                     handler:^(DotView *dotView) {
                                                         
                                                         if (self.delegate) {
                                                             [self.delegate matrixView:self didTouchDot:dotView];
                                                         }
                                                         
                                                     }];

            [self addSubview:dotView];
            dotView.center = dotCenterPoint;
            
            [columnArray addObject:dotView];

        }
        
        [self.dotViewArray addObject:columnArray];
    }
    
    //set total row & column
    self.totalRow = row;
    self.totalColumn = column;
    
    
    return self;
}

#pragma mark -
#pragma mark - Set Matrix
#pragma mark -

- (void)setMatrixWithArray:(NSArray*)array{
    
    // Wait For Custom
    
}

- (void)resetMatrix{
    
    for (NSMutableArray *columnArray in self.dotViewArray) {
        
        for (DotView *dotView in columnArray) {
            
            [dotView changeBackgroundColorWithColor:[UIColor lightGrayColor]];
            [dotView changeBackgroundOpacityWithAlpha:0.2];
            
        }
        
    }
    
}


#pragma mark -
#pragma mark - Matrix Imformation
#pragma mark -

- (NSInteger)getMatrixNumberOfRow{
    return self.totalRow;
}
- (NSInteger)getMatrixNumberOfColumn{
    return self.totalColumn;
}

- (DotView*)getDotViewWithIndexPath:(NSIndexPath*)indexPath{
    
    DotView *dotView = self.dotViewArray[indexPath.row][indexPath.section];
    
    return dotView;
}

#pragma mark -
#pragma mark Size Calculate
#pragma mark -
- (CGSize)getDotSizeWithFrame:(CGRect)frame withRow:(NSInteger)row withColumn:(NSInteger)column {
    
    CGSize  dotSize;
    CGFloat width   = frame.size.width;
    CGFloat heigth  = frame.size.height;
    
    CGFloat dotWidth;
    CGFloat dotHeight;
    
    dotWidth    = (width - (kDotGap * 2 * column))/column;
    dotHeight   = (heigth - (kDotGap * 2 * row))/row;
    
    if (dotHeight >= dotWidth) {
        
        dotSize = CGSizeMake(dotWidth, dotWidth);
        
    }else{
        
        dotSize = CGSizeMake(dotHeight, dotHeight);
    }
    
    return dotSize;
    
}

- (CGSize)getMatrixSizeWithDotSize:(CGSize)dotSize withRow:(NSInteger)row withColumn:(NSInteger)column {
    
    CGSize matrixSize;
    
    CGFloat matrixWidth     = (dotSize.width * column) + (column * 2 * kDotGap);
    CGFloat matrixHeigth    = (dotSize.height * row) + (row* 2 * kDotGap);
    
    matrixSize = CGSizeMake(matrixWidth, matrixHeigth);
    
    return matrixSize;
}

- (CGPoint)getDotCenterPointWithDotSize:(CGSize)dotSize withRow:(NSInteger)row withColumn:(NSInteger)column{
    
    CGPoint dotCenterPoint;
    
    CGFloat centerX = (dotSize.width * (column+1)) - (dotSize.width/2) + (((2*(column+1))-1)*kDotGap);
    CGFloat CenterY = (dotSize.height * (row+1)) - (dotSize.height/2) + (((2*(row+1))-1)*kDotGap);
    
    dotCenterPoint = CGPointMake(centerX, CenterY);
    
    return dotCenterPoint;
}



@end
