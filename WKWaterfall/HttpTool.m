//
//  HttpTool.m
//  ALian
//  http底层请求

//  Created by macairwkcao on 15/7/2.
//  Copyright (c) 2015年 xunniao. All rights reserved.
//

#import "HttpTool.h"


@implementation HttpTool

/**
 * 发送get请求
 */
+ (AFHTTPRequestOperation*)getHttpWithURL:(RequestMethod)MethodString params:(NSDictionary *)params host:(NSString *)host success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",host,methods[MethodString]];
    
    if (!params) {
        params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    }
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",nil];
    manager.requestSerializer.timeoutInterval = 20;
    
    AFHTTPRequestOperation * op = [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSDictionary *resDic = (NSDictionary *)responseObject;
            success(resDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
    
    return op;
}


/**
 * 发送post请求
 */
+ (AFHTTPRequestOperation*)postHttpWithURL:(RequestMethod)MethodString params:(NSDictionary *)params host:(NSString *)host success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",host,methods[MethodString]];
    
    if (!params) {
        params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    }
    
    
    
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    NSString *apiInput = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    NSMutableDictionary *apiParam = [NSMutableDictionary dictionary];
//    apiParam[@"api_key"] = @"betafamilyhas";
//    //    apiParam[@"api_target"] = urlString;
//    apiParam[@"api_input"] = apiInput;
//    apiParam[@"api_token"] = @"93572727ae7e4a1fb418b893e5460e2bf5ddeef5dff84bf99f650ec2528ba157";
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",nil];
    
    manager.requestSerializer.timeoutInterval = 20;
    
    AFHTTPRequestOperation * op = [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSDictionary *dict = (NSDictionary*)responseObject;
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
    return op;
}



@end
