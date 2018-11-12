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

@implementation DZCNetsTools

+(void)titlescrollView:(void(^)(NSArray *))isuccessBlock failure:(void(^)(void))isfailureBlock{
    NSString *string=@"article/category/get_subscribed/v9/?";
     NSMutableArray *marry=NSMutableArray.array;
   
    [DZCNewsNetWorkTools NetWorkManagerMethod:string selectWithmenthod:GET_METHOD withparame:@[] Complition:^(id  _Nonnull result, NSError * _Nonnull error) {
        if (!error) {
            dataModel *model=[dataModel yy_modelWithDictionary:result[@"data"] ];
            [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marry addObject:[obj valueForKey:@"name"]];
            }];
            isuccessBlock(marry.copy);
        }else{
            NSLog(@"%@",error);
        }
    }];

}



@end
