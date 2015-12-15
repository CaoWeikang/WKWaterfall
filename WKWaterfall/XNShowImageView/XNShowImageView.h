//
//  XNShowImageView.h
//  ALian
//
//  Created by macairwkcao on 15/9/17.
//  Copyright (c) 2015年 xunniao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width




@interface XNShowImageView : UIScrollView<UIScrollViewDelegate>

@property(strong,nonatomic)UIImage *image;
@property(assign,nonatomic)CGRect removeBounds;
-(void)showInView:(UIView *)view image:(UIImage *)image bounds:(CGRect)bounds;
@end
