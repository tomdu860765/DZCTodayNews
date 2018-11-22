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
#import "NSData+CRC32.h"
#import "DZCVideoModel.h"
#import "DZCXiGuaVideoModel.h"
@implementation DZCNetsTools
///滚动标题视图模型网络请求
///
///*参数一 返回name数组
///*参数二 返回category数组
///*参数三 监听目标
///*参数四 回调错误

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
///推荐新闻数据网络请求,该方法调用了两次网络请求,暂时弃用.
///
///*参数一 返回主页新闻数组
///*参数二 返回错误代码
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
///主新闻界面请求方法
///
///*参数一 返回主页新闻数组
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
///主新闻界面滚动视图请求方法
///
///*参数一 返回name数组
///*参数二 返回category数组
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
///主界面推荐新闻界面请求方法
///
///*参数一 返回分类新闻详细信息数组
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
///主新闻界面请求方法
///
///*参数一 返回分类新闻详细信息数组
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
///获取video网络请求方法
///
/// 拼接字符串请务必一致否则会没有返回数据
///*参数一 返回为视频真实链接字符串

+(void)NetworVideo:(NSString*)Videoidstring finishBlock:(void(^)(NSString*))callback{

    int r=arc4random();
    NSString *video_id=Videoidstring;
    NSString *string=@"/video/urls/v/1/toutiao/mp4/";
    NSString *str=[@"?r=" stringByAppendingFormat:@"%@",@(r)];
    
    NSString *urlstr=[string stringByAppendingString:video_id];
    NSString *realstr=[urlstr stringByAppendingString:str];
    //把链接处理为二进制
    NSData *data = [realstr dataUsingEncoding:NSUTF8StringEncoding];
   //处理crc32验证
    UInt64  crc32=  data.getCRC32;
    if (crc32 <0) {
        crc32 += 0x100000000;
    }
   
    NSString *crc32str=[@"&s=" stringByAppendingFormat:@"%@",@(crc32)];
    
    NSString *requeststring=[realstr stringByAppendingString:crc32str];
    
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:requeststring parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
           
            if ([NSJSONSerialization isValidJSONObject:responseObject]) {
               
                DZCVideolistModel *model=[DZCVideolistModel yy_modelWithJSON:responseObject[@"data"]];
                NSDictionary *dict=[NSDictionary dictionaryWithDictionary:[model.video_list valueForKey:@"video_1"]];
                [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    if ([key isEqualToString:@"main_url"]) {
                        //编译base64
                        NSData *data = [[NSData alloc]initWithBase64EncodedString:obj options:NSDataBase64DecodingIgnoreUnknownCharacters];
                        NSString *realurl64=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        callback(realurl64);
                        *stop=YES;
                        return ;
                    }
                }];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        
    }
     ];
    
}
///西瓜视频网络请求
///
///*参数一 返回一个标题数组

+(void)netWorkForXiGuaVideo:(void(^)(NSArray*))finishBlock{
    NSString *urlstring=@"https://api.apiopen.top/videoHomeTab";
    [[DZCNewsNetWorkTools NewsNetWorkDefualt]GET:urlstring parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array=[NSArray yy_modelArrayWithClass:[DZCXiGuaVideoModel class] json:[responseObject valueForKey:@"result"]];
        if (array) {
            finishBlock(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response=(NSHTTPURLResponse*)task.response;
        
          NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
 
    }];
    

}



@end
