//
//  WKCollectionReusableView.h
//  WKWaterfall
//
//  Created by macairwkcao on 15/9/21.
//  Copyright (c) 2015年 CWK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageInfo;
@interface WKCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
-(void)fillData:(ImageInfo *)imageInfo finishedBlock:(void(^)())finshed;
@end
