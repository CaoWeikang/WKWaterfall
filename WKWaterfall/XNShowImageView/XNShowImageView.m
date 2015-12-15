//
//  XNShowImageView.m
//  ALian
//
//  Created by macairwkcao on 15/9/17.
//  Copyright (c) 2015年 xunniao. All rights reserved.
//

#import "XNShowImageView.h"


@interface XNShowImageView()
{
    UIImageView *_imageView;
    UIView *_headerView;
    BOOL _isBounds;
}
@end

@implementation XNShowImageView

@synthesize image = _image;
@synthesize removeBounds = _removeBounds;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        [self uiConfig];
    }
    return self;
}


-(void)uiConfig
{
    

    
    self.maximumZoomScale = 4.0;
    self.minimumZoomScale = 1.0;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _imageView.backgroundColor = [UIColor blackColor];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
    doubleTap.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *onceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onceTapClick:)];
    onceTap.numberOfTapsRequired = 1;
    [_imageView addGestureRecognizer:onceTap];
    [self addSubview:_imageView];
    
    
    
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _headerView.backgroundColor = [UIColor clearColor];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    backView.alpha = 0.5;
    backView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:backView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(20, 27, 40, 30)];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.alpha = 1.0;
    [_headerView addSubview:button];
    _headerView.userInteractionEnabled = YES;
    _headerView.hidden = YES;
}


-(void)setRemoveBounds:(CGRect)removeBounds
{
    _isBounds = YES;
    _removeBounds = removeBounds;
}

-(void)setImage:(UIImage *)image
{
    if (_image != image) {
        
        _imageView.image = image;
    }
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        CGFloat orginX = _imageView.frame.origin.x;
        CGFloat orginY = _imageView.frame.origin.y;

        CGFloat scale = 1;
        if (height/kScreenHeight >= width/kScreenWidth)
        {
            scale = height/kScreenHeight;
        }
        else
        {
            scale = width/kScreenWidth;
        }
        
        width = width/scale;
        height = height/scale;
//        if (width < kScreeWidth) {
            orginX = (kScreenWidth-width)/2.0;
//        }
//        if (height < kScreeHeight) {
            orginY = (kScreenHeight-height)/2.0;
//        }
        _imageView.frame = CGRectMake(0, 0, width,  height);
        _image = image;
        self.contentInset = UIEdgeInsetsMake(orginY, orginX, 0, 0);
        self.contentSize = _imageView.frame.size;
        _headerView.hidden = YES;

    
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale; // scale between minimum and maximum. called after any 'bounce' animations
{
//    view.center= CGPointMake(self.contentSize.width/2.0, self.contentSize.height
//                             /2.0);
    
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    CGFloat orginX = 0;
    CGFloat orginY = 0;
    
    

    if (width <= kScreenWidth) {
        orginX = (kScreenWidth-width)/2.0;
    }
    else
    {
        orginX = 0;
    }
    if (height <= kScreenHeight) {
        orginY = (kScreenHeight-height)/2.0;
    }
    else
    {
        orginY = 0;
    }
//    [UIView animateWithDuration:0.3 animations:^{
        self.contentInset = UIEdgeInsetsMake(orginY, orginX, 0, 0);
//    }];
//    _imageView.userInteractionEnabled = YES;

    for (UIGestureRecognizer* gestureRecognizer in view.gestureRecognizers) {
        gestureRecognizer.enabled = YES;
    }
    NSLog(@"%@---orginX:%g----orginY:%g",NSStringFromCGRect(view.frame),orginX,orginY);
}


-(void)doubleTapClick:(UITapGestureRecognizer *)tap
{
    
    
    if (self.zoomScale == 1.0) {
        [self setZoomScale:2.0 animated:YES];
    }
    else
    {
        NSLog(@"--------");
        [self setZoomScale:1.0 animated:YES];
    }
    CGFloat width = _imageView.frame.size.width;
    CGFloat height = _imageView.frame.size.height;
    CGFloat orginX = 0;
    CGFloat orginY = 0;
    
    
    
    if (width <= kScreenWidth) {
        orginX = (kScreenWidth-width)/2.0;
    }
    else
    {
        orginX = 0;
    }
    if (height <= kScreenHeight) {
        orginY = (kScreenHeight-height)/2.0;
    }
    else
    {
        orginY = 0;
    }
    self.contentInset = UIEdgeInsetsMake(orginY, orginX, 0, 0);
    [_imageView becomeFirstResponder];
//    _imageView.userInteractionEnabled = YES;
    tap.enabled = YES;
    _headerView.hidden = YES;
}

-(void)onceTapClick:(UITapGestureRecognizer *)tap
{
    if (!_headerView.superview) {
        [self.superview addSubview:_headerView];
    }
    _headerView.hidden = !_headerView.hidden;
}

-(void)backAction:(UIButton *)sender
{
    [_headerView removeFromSuperview];
    if (_isBounds) {
        
        [self setZoomScale:1.0 animated:NO];
        [UIView animateWithDuration:0.4 animations:^{
            self.frame = _removeBounds;
            NSLog(@"%@",NSStringFromCGRect(self.bounds));
        }completion:^(BOOL finished) {
            [self removeFromSuperview];

        }];
    }
    else
    {
        [self removeFromSuperview];
    }
}

-(void)showInView:(UIView *)view image:(UIImage *)image bounds:(CGRect)bounds
{
    [view addSubview:self];
    self.image = image;
    self.frame = bounds;
    self.removeBounds = bounds;
    [UIView animateWithDuration:0.4 animations:^{
        [UIApplication sharedApplication].statusBarHidden = YES;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];

}

-(UIImage *)image
{
    return _image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
