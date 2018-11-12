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
        //添加了请求10秒时,和基本url
        NSURL *baseUrl=[NSURL URLWithString:@"http://ic.snssdk.com/"];
        
        NSURLSessionConfiguration *configuation=[NSURLSessionConfiguration defaultSessionConfiguration];
        configuation.timeoutIntervalForRequest=10;
        defualtManager=[[self alloc]initWithBaseURL:baseUrl sessionConfiguration:configuation];
    });
    

    return defualtManager;
}

//网络h滚动栏请求方法
+(void)titleScrollViewNetwork:(NSString *)Urlstring successblcok:(void(^)(NSArray *))issuccess failureblock:(void(^)(void))isfailure{
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:Urlstring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (issuccess) {
            NSMutableArray *marry=NSMutableArray.array;
            dataModel *model=[dataModel yy_modelWithDictionary:responseObject[@"data"] ];
            [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marry addObject:[obj valueForKey:@"name"]];
            }];
            issuccess(marry.copy);
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isfailure) {
            
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
        
        
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);}
    }];
    

}





@end
