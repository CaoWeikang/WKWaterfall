//
//  WKCollectionWaterfallViewController.m
//  WKWaterfall
//
//  Created by macairwkcao on 15/9/21.
//  Copyright (c) 2015年 CWK. All rights reserved.
//

#import "WKCollectionWaterfallViewController.h"
#import "WKCollectionViewLayout.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "ImageInfo.h"
#import "WKCollectionViewCell.h"
#import "MJRefresh.h"
#import "XNShowImageView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
@interface WKCollectionWaterfallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    int _page;
    XNShowImageView *_showImageView;
    NSInteger _loadImageCount;
}

@end

@implementation WKCollectionWaterfallViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _loadImageCount = 0;
    [self showHUD:@"正在加载图片..." isDim:NO];
    [self loadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WKCollectionWaterfall";
    self.dataSource = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionView = [self collectionView];
    [_collectionView addHeaderWithTarget:self action:@selector(loadData)];
    [_collectionView addFooterWithTarget:self action:@selector(loadMoreData)];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_collectionView];
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        WKCollectionViewLayout * flowLayout = [[WKCollectionViewLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[WKCollectionViewCell class] forCellWithReuseIdentifier:@"WKCollectionViewCell"];
        _collectionView.backgroundView.backgroundColor = [UIColor whiteColor];
        return collectionView;
    }
    return _collectionView;
}

-(void)loadData
{
    _loadImageCount = 0;
    _page = 1;
    NSDictionary *dict = @{@"key":@"a23HmMiWZJeVmZiUlpSUk5ScyGOYxshsmGmZapVmnW9xmZ6ek2WWacOblGmSZ5o=",@"returntype":@"json",@"p":[NSNumber numberWithInt:_page],@"cid":@"1"};
    [HttpTool getHttpWithURL:APiForImageList params:dict host:HOST success:^(id json) {
        [ImageInfo setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
         self.dataSource = [ImageInfo objectArrayWithKeyValuesArray:json[@"pic"]];
        [_collectionView reloadData];
        [_collectionView headerEndRefreshing];
        [self hideHUD];

        _page++;
    } failure:^(NSError *error) {
        [_collectionView headerEndRefreshing];
        [self showHUDComplete:@"加载图片失败"];
    }];
}


-(void)loadMoreData
{
    if (_loadImageCount < self.dataSource.count) {
        [_collectionView footerEndRefreshing];
        return;
    }
    
    NSDictionary *dict = @{@"key":@"a23HmMiWZJeVmZiUlpSUk5ScyGOYxshsmGmZapVmnW9xmZ6ek2WWacOblGmSZ5o=",@"returntype":@"json",@"p":[NSNumber numberWithInt:_page],@"cid":@"1"};
    [HttpTool getHttpWithURL:APiForImageList params:dict host:HOST success:^(id json) {
        [ImageInfo setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        [self.dataSource addObjectsFromArray:[ImageInfo objectArrayWithKeyValuesArray:json[@"pic"]]];
        [_collectionView reloadData];
        [_collectionView footerEndRefreshing];
        _page++;
    } failure:^(NSError *error) {
        [_collectionView footerEndRefreshing];

    }];
}

#pragma mark - UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"WKCollectionViewCell";
    WKCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ImageInfo *imageInfo = self.dataSource[indexPath.row];

    
    [cell fillData:imageInfo finishedBlock:^{
        _loadImageCount++;
    }];
    return cell;
    

}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageInfo *imageInfo = self.dataSource[indexPath.row];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-12)/3.0;
    CGFloat height = imageInfo.height/imageInfo.width*width;
    imageInfo.height = height;
    imageInfo.width = width;
    return CGSizeMake(width,height);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}


#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WKCollectionViewCell *cell = (WKCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    
    if (_showImageView == nil) {
        _showImageView = [[XNShowImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _showImageView.backgroundColor = [UIColor blackColor];
    }
    if (![_showImageView superview])
    {
        CGRect bounds = [cell.imageView convertRect:cell.imageView.bounds toView:self.view ];
        [_showImageView showInView:self.view.window image:cell.imageView.image bounds:bounds];
    }
}


-(void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground = isDim;
    self.hud.labelText = title;
}
-(void)showHUDComplete:(NSString *)title
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
    [self hideHUD];
}

-(void)hideHUD
{
    [self.hud hide:YES afterDelay:0.3];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
