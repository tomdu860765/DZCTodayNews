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
 使用id的网络请求方法获取最后的播放地址{
 let r = arc4random() // 随机数
 
 let url: NSString = "/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)" as NSString
 let data: NSData = url.data(using: String.Encoding.utf8.rawValue)! as NSData
 // 使用 crc32 校验
 var crc32: UInt64 = UInt64(data.getCRC32())
 // crc32 可能为负数，要保证其为正数
 if crc32 < 0 { crc32 += 0x100000000 }
 // 拼接 url
 let realURL = "http://i.snssdk.com/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)&s=\(crc32)"
 //使用上面链接获取json 然后 base64解析成最终链接就可以用播放器使用
 视频id v02004d00000bfmm6gd9688km4nle2ag
 }
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

@interface video_detail_info : NSObject

@property(nonatomic,copy)NSString * video_id;

@end


@interface DZCMainNewsModel : NSObject

@property(nonatomic,copy)NSString *media_name, *title, *display_url, *label,*has_video;

@property(nonatomic,strong)NSNumber *comment_count;

@property(nonatomic,assign)NSInteger publish_time;

@property(nonatomic,assign,getter=ishot)BOOL  hot;


@property(nonatomic,strong)middle_image *middle_image;

@property(nonatomic,strong)large_image_list *large_image_list;

@property(nonatomic,strong)video_detail_info *video_detail_info;

@end






NS_ASSUME_NONNULL_END
