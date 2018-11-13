//
//  DZCNewsNetWorkTools.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/10.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCNewsNetWorkTools.h"
#import "YYModel.h"
#import "DZCTitleScrollViewModel.h"

@implementation DZCNewsNetWorkTools
//创建网络工具单例
+(instancetype)NewsNetWorkDefualt{
    static id defualtManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //添加了请求10秒超时,和基本url
        NSURL *baseUrl=[NSURL URLWithString:@"http://is.snssdk.com/"];
        
        NSURLSessionConfiguration *configuation=[NSURLSessionConfiguration defaultSessionConfiguration];
        configuation.timeoutIntervalForRequest=10;
        defualtManager=[[self alloc]initWithBaseURL:baseUrl sessionConfiguration:configuation];
    });
    

    return defualtManager;
}


//二次封装的get,post网络方法
+(void)NetWorkManagerMethod:(NSString *)Urlstring selectWithmenthod:(NetWorksMethod)Methods withparame:(id)parames Complition:(void(^)(id result, NSError *error))Complitionbolck{
   
    
    switch (Methods) {
        case GET_METHOD:{
           
            [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:Urlstring parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                Complitionbolck(responseObject,nil);
              
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {


                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
                Complitionbolck(nil,error);
                NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
                
            }
             ];}
        case POST_METHOD:{
            [[DZCNewsNetWorkTools NewsNetWorkDefualt]POST:Urlstring parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            Complitionbolck(responseObject,nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            Complitionbolck(nil,error);
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
            
        }];}
            
          
        default:
          
         break;
    }
    
}
    
   
  





@end
