//
//  WKCollectionWaterfallViewController.h
//  WKWaterfall
//
//  Created by macairwkcao on 15/9/21.
//  Copyright (c) 2015年 CWK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface WKCollectionWaterfallViewController : UIViewController

@property(strong,nonatomic)NSMutableArray *dataSource;
@property (nonatomic,strong)MBProgressHUD *hud;

-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;
-(void)showHUDComplete:(NSString *)title;
-(void)hideHUD;

@end
