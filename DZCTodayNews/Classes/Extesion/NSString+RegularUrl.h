//
//  NSString+RegularUrl.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RegularUrl)


///正则表达式提取链接方法
///
///*参数一 返回正则表达式链接
///*参数二 原始链接


+(NSString*)stringWithUrl:(NSString*)urlstring;


@end

NS_ASSUME_NONNULL_END
