//
//  ViewController.m
//  WKWaterfall
//
//  Created by macairwkcao on 15/9/21.
//  Copyright (c) 2015年 CWK. All rights reserved.
//

#import "ViewController.h"
#import "WKCollectionWaterfallViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)collectionView:(UIButton *)sender
{
    WKCollectionWaterfallViewController *waterfallVC = [[WKCollectionWaterfallViewController alloc] init];
    [self.navigationController pushViewController:waterfallVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
