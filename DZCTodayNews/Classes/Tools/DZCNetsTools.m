//
//  DZCNetsTools.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCNetsTools.h"
#import "DZCTitleScrollViewModel.h"
#import "YYModel.h"
#import "DZCMainNewsModel.h"

@implementation DZCNetsTools
//滚动标题视图模型网络请求
+(void)titlescrollView:(void(^)(NSArray *,NSArray *))isuccessBlock failure:(void(^)(void))isfailureBlock{
    NSString *string=@"article/category/get_subscribed/v9/?";
    NSMutableArray *marry=NSMutableArray.array;
    NSMutableArray *marraycategory=NSMutableArray.array;
    [DZCNewsNetWorkTools NetWorkManagerMethod:string selectWithmenthod:GET_METHOD withparame:@[] Complition:^(id  _Nonnull result, NSError * _Nonnull error) {
        if (!error) {
            dataModel *model=[dataModel yy_modelWithDictionary:result[@"data"] ];
            
            [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [marry addObject:[obj valueForKey:@"name"]];
                [marraycategory addObject:[obj valueForKey:@"category"]];
            }];
            isuccessBlock(marry.copy,marraycategory.copy);
        }else{
            NSLog(@"%@",error);
        }
    }];
    
}
//推荐新闻数据网络请求,该方法调用了两次网络请求,暂时弃用.
+(void)MainNewsNetwork:(void(^)(NSArray*,NSError*))ComplitionBlock{
    
    NSString *string=@"api/news/feed/v64/?";
    
    
    [DZCNewsNetWorkTools NetWorkManagerMethod:string selectWithmenthod:GET_METHOD withparame:@[] Complition:^(id  _Nonnull result, NSError * _Nonnull error) {
        if (!error) {
            NSArray *array=(NSArray*)result[@"data"];
            NSMutableArray *marry=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
                if([model.title isEqualToString:@""]){
                    return ;
                }
                if (model) {
                    
                    [marry addObject:model];
                }
                
            }];
            ComplitionBlock(marry.copy,nil);
        }else{
            ComplitionBlock(nil,error);
        }
        
    }];
    
}
//网络请求主新闻页面方法
+(void)NetworkMainNews:(void(^)(NSArray*))callback{
    NSString *string=@"api/news/feed/v64/?";
    
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:string parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *array=(NSArray*)responseObject[@"data"];
            NSMutableArray *marry=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
                if([model.title isEqualToString:@""]){
                    return ;
                }
                if (model) {
                    
                    [marry addObject:model];
                    
                }
                
            }];
            callback(marry.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        
    }
     ];}
//标题滚动视图网络请求
+(void)ScrollviewSttitle:(void(^)(NSArray*,NSArray*))finishblock{
    NSString *string=@"article/category/get_subscribed/v9/?";
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:string parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSMutableArray *marry=NSMutableArray.array;
     NSMutableArray *marraycategory=NSMutableArray.array;
            dataModel *model=[dataModel yy_modelWithDictionary:responseObject[@"data"] ];
            
            [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                [marry addObject:[obj valueForKey:@"name"]];
                [marraycategory addObject:[obj valueForKey:@"category"]];
            }];
        finishblock(marry.copy,marraycategory.copy);
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (error) {
       NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
                                                  
       NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
       }
         }
     ];
    
}
//分类新闻请求
+(void)NetworHotNews:(void(^)(NSArray*))callback{
    
    
    NSString *string=@"api/news/feed/v64/?";
    NSDictionary * dict=@{@"category":@"__all__"};
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:string parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *array=(NSArray*)responseObject[@"data"];
            NSMutableArray *marry=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
                
                if([model.title isEqualToString:@""]){
                    return ;
                }
                if (model) {
                    
                    [marry addObject:model];
                }
                
            }];
            callback(marry.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        
    }
     ];
    
}
//分类新闻网络请求,附加分类字典
+(void)NetworHotNews:(void(^)(NSArray*))callback WithKeyworks:(id)keyworks{
    
    
    NSString *string=@"api/news/feed/v64/?";
    NSDictionary *stringdict=@{@0:@"all", @1:@"news_hot",@2:@"news_local",@3:@"video",@4:@"photos",@5:@"news_entertainment",
                               @6:@"news_tech",@7:@"news_car",@8:@"news_finance",@9:@"news_military",
                               @10:@"news_sports",@11:@"news_world",
                               @12:@"news_health",@13:@"jinritemai",
                               @14:@"news_house",@15:@"traditional_culture"};
    
    NSDictionary * dict=@{@"category":stringdict[keyworks]};
   
    
    
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:string parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *array=(NSArray*)responseObject[@"data"];
            NSMutableArray *marry=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
               
                if([[model.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
                    
                    return;
                }
                
                if (model) {
                    
                    [marry addObject:model];
                }
                
            }];
            callback(marry.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        
    }
     ];
    
}



@end
