//
//  WKCollectionReusableView.m
//  WKWaterfall
//
//  Created by macairwkcao on 15/9/21.
//  Copyright (c) 2015年 CWK. All rights reserved.
//

#import "WKCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ImageInfo.h"
@interface WKCollectionViewCell()
{
    UIImageView *_imageView;
}
@end
@implementation WKCollectionViewCell
@synthesize imageView = _imageView;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiConfig];
    }
    return self;
}

-(void)uiConfig
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
//    NSLog(@"%@",NSStringFromCGSize(self.contentView.frame.size));
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _imageView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_imageView];
    
}

-(void)fillData:(ImageInfo *)imageInfo finishedBlock:(void(^)())finshed
{
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-12)/3.0;
    
    CGFloat height = imageInfo.height/imageInfo.width*width;
    _imageView.frame = CGRectMake(0, 0, width, height);
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageInfo.linkurl] placeholderImage:[UIImage imageNamed:@"37x-Checkmark"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _imageView.image = image;
        if (!imageInfo.isDownload) {
            imageInfo.isDownload = YES;
            finshed();
        }
    }];
    
}

@end
