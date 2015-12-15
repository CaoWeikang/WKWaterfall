//
//  ImageInfo.h
//  WKWaterfall
//
//  Created by macairwkcao on 15/9/21.
//  Copyright (c) 2015年 CWK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageInfo : NSObject
//{"id":"17325483",
//"name":"\u6587\u623f\u53e4\u5178\u6c14\u8d28\u7684\u9999\u58a8\u5973\u5b50\u6de1\u96c5\u5982\u83ca(6)",
//"linkurl":"http:\/\/i3.tietuku.com\/77313e8a421bc0b5.jpg",
//"showurl":"http:\/\/tietuku.com\/77313e8a421bc0b5",
//"ext":"jpg",
//"width":"900",
//"height":"600",
//"findurl":"77313e8a421bc0b5",
//"recommend":"0"},

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *linkurl;

@property(nonatomic,copy)NSString *showurl;

@property(nonatomic,copy)NSString *ext;

@property(nonatomic,assign)CGFloat width;

@property(nonatomic,assign)CGFloat height;

@property(nonatomic,copy)NSString *findurl;

@property(nonatomic,copy)NSString *recommend;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)BOOL isDownload;

@end
