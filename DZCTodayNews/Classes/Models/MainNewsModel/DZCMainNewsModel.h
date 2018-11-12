//
//  DZCMainNewsModel.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
/*
model信息解析
display_url 新闻详细内容链接
label 新闻置顶
media_name 媒体来源
comment_count 评论数
 title 新闻标题
 */

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DZCMainNewsModel : NSObject
@property(nonatomic,copy)NSString *media_name,*title,*display_url,*label;
@property(nonatomic,strong)NSNumber *comment_count;

@end





NS_ASSUME_NONNULL_END
