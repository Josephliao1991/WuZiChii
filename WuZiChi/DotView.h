//
//  DotView.h
//  GBDotMatrix
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DotView : UIView

//@property()

#pragma mark - IndexPath
@property (strong, nonatomic) NSIndexPath   *indexPath;

#pragma matk - View
@property (strong, nonatomic) UIImageView   *imageView;


- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage*)image withRow:(NSInteger)row withColumn:(NSInteger)column handler:(void(^)(DotView *dotView))aBlock;



#pragma mark -
#pragma mark Change UI Method
#pragma mark -

- (void)changeBackgroundColorWithColor:(UIColor*)color;
- (void)changeBackgroundImageWithImage:(UIImage*)image;
- (void)changeBackgroundOpacityWithAlpha:(float)alpha;

@end
