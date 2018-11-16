//
//  DZCVideoModel.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/16.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///该模型中链接video_1  video_2 video_3 对应三个清晰度链接360p 480p 720p

@interface video_1 : NSObject
@property(nonatomic,copy)NSString *main_url;
@end

@interface video_list : NSObject

@property(nonatomic,strong)video_1 *video_1;

@end




@interface DZCVideolistModel : NSObject
//主链接
@property(nonatomic,copy)NSString  *video_duration;

@property(nonatomic,copy)video_list *video_list;



@end



NS_ASSUME_NONNULL_END
