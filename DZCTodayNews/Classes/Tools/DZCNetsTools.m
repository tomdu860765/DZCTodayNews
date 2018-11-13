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
//推荐新闻数据网络请求
+(void)MainNewsNetwork:(void(^)(NSArray*,NSError*))ComplitionBlock{
    //min_behot_time    Int    下拉刷新的参数
    //max_behot_time    Int    加载更多的参数
    NSString *string=@"api/news/feed/v64/?";
    
    NSMutableArray *marry=NSMutableArray.array;
    [DZCNewsNetWorkTools NetWorkManagerMethod:string selectWithmenthod:GET_METHOD withparame:@[] Complition:^(id  _Nonnull result, NSError * _Nonnull error) {
        if (!error) {
            NSArray *array=(NSArray*)result[@"data"];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
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
//block调用了两次 需要更改


@end
