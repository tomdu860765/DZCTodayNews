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
 video_detail_info 视频详细内容
 video_id 视频请求id
 read_count 阅读数量
 gallary_image_count 图片数量
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface middle_image : NSObject



@property(nonatomic,copy)NSString *url;

@end

@interface large_image_list : NSObject

@property(nonatomic,copy)NSString *url;

@end

@interface video_detail_info : NSObject

@property(nonatomic,copy)NSString * video_id;

@property(nonatomic,copy)NSString *video_watch_count;

@end

@interface image_list : NSObject

@property(nonatomic,copy)NSString *url;

@end

@interface DZCMainNewsModel : NSObject

@property(nonatomic,copy)NSString *media_name, *title, *display_url, *label,*read_count ;

@property(nonatomic,strong)NSNumber *comment_count ;

@property(nonatomic,assign)NSInteger publish_time,video_duration,gallary_image_count;

@property(nonatomic,assign,getter=ishot)BOOL  hot;

@property(nonatomic,assign,getter=ishas_video)BOOL has_video;

@property(nonatomic,strong)middle_image *middle_image;

@property(nonatomic,strong)large_image_list *large_image_list;

@property(nonatomic,strong)video_detail_info *video_detail_info;

@property(nonatomic,strong)image_list *image_list;
@end






NS_ASSUME_NONNULL_END
