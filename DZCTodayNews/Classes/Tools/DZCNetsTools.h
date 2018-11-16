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

//请求网络新闻模型方法
+(void)NetworkMainNews:(void(^)(NSArray*))callback;
//请求网络滚动视图模型方法
+(void)ScrollviewSttitle:(void(^)(NSArray*,NSArray*))finishblock;
//刷新热点新闻
+(void)NetworHotNews:(void(^)(NSArray*))callback;
//分类新闻网络请求,该方法同时使用可能会产生冲突
+(void)NetworHotNews:(void(^)(NSArray*))callback WithKeyworks:(id)keyworks;
//视频网络请求
+(void)NetworVideo:(void(^)(NSString*))callback;
@end

NS_ASSUME_NONNULL_END
