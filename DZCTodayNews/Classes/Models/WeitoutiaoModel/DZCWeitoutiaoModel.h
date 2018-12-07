//
//  DZCWeitoutiaoModel.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/29.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "DZCRepostModel.h"
#import "DZCGroupModel.h"
NS_ASSUME_NONNULL_BEGIN



@interface DZCWeitoutiaoModel : NSObject
@property(nonatomic,assign)BOOL is_repost;//是否转载标记
@property(nonatomic,copy)NSString *rich_content,*content_unescape;//微头条内容,微博内容去取空格
@property(nonatomic,copy)NSArray *ugc_cut_image_list;//图片链接数组
@property(nonatomic,strong)NSNumber *comment_count,*create_time,*forward_count,*digg_count,*read_count;//评论数,创建时间,转载数,点赞数,阅读数
@property(nonatomic,copy)NSDictionary *user;//关注微头条用户信息
@property(nonatomic,strong)DZCRepostModel *origin_thread;//转载模型
@property(nonatomic,strong)DZCGroupModel *group;
@end




NS_ASSUME_NONNULL_END
