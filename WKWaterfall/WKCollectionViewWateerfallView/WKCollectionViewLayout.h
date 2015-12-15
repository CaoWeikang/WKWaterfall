//
//  WKCollectionViewLayout.h
//  WKWaterfall
//
//  Created by macairwkcao on 15/9/22.
//  Copyright (c) 2015年 CWK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, assign) NSInteger cellCount;//cell的个数
@property (nonatomic, strong) NSMutableArray *colArr;//存放列的高度
@property (nonatomic, strong) NSMutableDictionary *attributeDict;//存放cell的位置信息
@end
