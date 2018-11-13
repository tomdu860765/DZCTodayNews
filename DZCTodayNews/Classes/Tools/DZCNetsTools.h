//
//  DZCNetsTools.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCNewsNetWorkTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZCNetsTools : DZCNewsNetWorkTools
//请求网络滚动视图模型方法
+(void)titlescrollView:(void(^)(NSArray *,NSArray *))isuccessBlock failure:(void(^)(void))isfailureBlock;
//请求网络新闻模型方法
+(void)MainNewsNetwork:(void(^)(NSArray*,NSError*))ComplitionBlock;

@end

NS_ASSUME_NONNULL_END
