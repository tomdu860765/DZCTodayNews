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
///时间戳方法转字符串方法
///
///*参数一 传入时间参数
///*返回值一 返回字符串
+(NSString *)time_timestampToString:(NSInteger)timestamp;
///时间戳方法转字符串方法,会计算发布时效
///
///*参数一 传入时间参数
///*返回值一 返回字符串
+(NSString *)updateTimeForRow:(NSInteger)createTime ;
@end

NS_ASSUME_NONNULL_END
