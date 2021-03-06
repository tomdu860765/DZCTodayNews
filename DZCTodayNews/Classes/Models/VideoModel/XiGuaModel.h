//
//  XiGuaModel.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/25.
//  Copyright © 2018 tomdu. All rights reserved.
// 该模型为视频详情模型

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN




@interface XiGuaModel : NSObject
//播放链接,标题,标题详情,播放时间,分类
@property(nonatomic,copy)NSString *playUrl,*title,*descriptionPgc,*category;
@property(nonatomic,assign)NSInteger duration;
@property(nonatomic,strong)NSDictionary *cover,*tags;
@end





NS_ASSUME_NONNULL_END
