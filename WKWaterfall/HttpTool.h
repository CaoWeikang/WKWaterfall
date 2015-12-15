//
//  HttpTool.h
//  ALian
//  http底层请求

//  Created by macairwkcao on 15/7/2.
//  Copyright (c) 2015年 xunniao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HttpApI.h"

typedef void(^HttpRequestSuccess)(id json);
typedef void(^HttpRequestFailure)(NSError *error);

@interface HttpTool : NSObject

/**
 * 发送get请求
 */
+ (AFHTTPRequestOperation*)getHttpWithURL:(RequestMethod)MethodString params:(NSDictionary *)params host:(NSString *)host success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;


/**
 * 发送post请求
 */
+ (AFHTTPRequestOperation*)postHttpWithURL:(RequestMethod)MethodString params:(NSDictionary *)params host:(NSString *)host success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

@end
