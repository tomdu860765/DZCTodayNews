//
//  DZCRepostModel.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/2.
//  Copyright © 2018 tomdu. All rights reserved.
//转发微博模型

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZCRepostModel : NSObject
@property(nonatomic,copy)NSString *rich_content,*content_unescape;//转发微头条内容
@property(nonatomic,copy)NSArray *ugc_cut_image_list;//图片链接数组
@property(nonatomic,copy)NSDictionary *user;//转发微头条用户的信息


@end

NS_ASSUME_NONNULL_END
