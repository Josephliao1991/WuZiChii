//
//  DotView.m
//  GBDotMatrix
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import "DotView.h"

typedef void(^DotDidTouch)(DotView *dotVIew);

@interface DotView ()

{
    DotDidTouch     dotDidTouchBlock;
}


@end

@implementation DotView

#pragma mark -
#pragma mark Initialize Part
#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage*)image withRow:(NSInteger)row withColumn:(NSInteger)column handler:(void(^)(DotView *dotView))aBlock
{
    
    self = [super initWithFrame:frame];
    
    self.indexPath = [NSIndexPath indexPathForItem:row inSection:column];
    
    [self addUIImageViewWithImage:image];
    
    self.layer.cornerRadius = frame.size.width/2;
    self.backgroundColor = [UIColor clearColor];
    
    dotDidTouchBlock = aBlock;
    
    return self;
}

#pragma mark -
#pragma mark View
#pragma mark -

- (void)addUIImageViewWithImage:(UIImage*)image{
    
    self.imageView = [[UIImageView alloc]init];
    
    //set image can Change cornerRedu
    self.clipsToBounds = YES;
    
    if (image) {
        self.imageView.image = image;
    }else{
        self.imageView.backgroundColor = [UIColor lightGrayColor];
        self.imageView.alpha = 0.2;
    }
    
    
    //add constrain
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constrain_top = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0];
    
    NSLayoutConstraint *constrain_bottom = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0];
    
    NSLayoutConstraint *constrain_left = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:0];
    
    NSLayoutConstraint *constrain_right = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:0];
    
    [self addConstraints:@[constrain_top, constrain_bottom, constrain_left, constrain_right]];
    
    
}

#pragma mark -
#pragma mark View Change
#pragma mark -
- (void)changeBackgroundColorWithColor:(UIColor*)color{
    
    self.imageView.image = nil;
    self.imageView.backgroundColor = color;
    
}

- (void)changeBackgroundImageWithImage:(UIImage*)image{
    
    self.imageView.image = image;
    
}

- (void)changeBackgroundOpacityWithAlpha:(float)alpha{
    
    self.imageView.alpha = alpha;
    
}

#pragma mark -
#pragma mark ViewDid Touch Begin Delegate
#pragma mark -


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (dotDidTouchBlock) {
        dotDidTouchBlock(self);
    }
    
}

@end
