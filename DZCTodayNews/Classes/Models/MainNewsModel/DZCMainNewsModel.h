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
 middle_image 图片链接
 has_video 是否有视频
 hot 热点
 large_image_list 大图链接
 video_duration 视频时间
 */

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface middle_image : NSObject



@property(nonatomic,copy)NSString *url;

@end

@interface large_image_list : NSObject

@property(nonatomic,copy)NSString *url;

@end



@interface DZCMainNewsModel : NSObject

@property(nonatomic,copy)NSString *media_name, *title, *display_url, *label,*has_video;

@property(nonatomic,strong)NSNumber *comment_count;

@property(nonatomic,assign)NSInteger publish_time;

@property(nonatomic,assign,getter=ishot)BOOL  hot;


@property(nonatomic,strong)middle_image *middle_image;

@property(nonatomic,strong)large_image_list *large_image_list;

@end






NS_ASSUME_NONNULL_END
