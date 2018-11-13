//
//  NSString+NSString_TimeToString.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSString_TimeToString)
//时间戳方法转字符串方法
+(NSString *)time_timestampToString:(NSInteger)timestamp;
//对比现在时间戳方法
+(NSString *)updateTimeForRow:(NSInteger)createTime ;
@end

NS_ASSUME_NONNULL_END
