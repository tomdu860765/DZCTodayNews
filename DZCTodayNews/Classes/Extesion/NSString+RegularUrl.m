//
//  NSString+RegularUrl.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "NSString+RegularUrl.h"
#import <UIKit/UIKit.h>
@implementation NSString (RegularUrl)
//提取图片链接
+(NSString*)stringWithUrl:(NSString*)urlstring{
    //提取的正则表达式
NSString *pattern=@"(.*?).webp";
    

NSRegularExpression *regular=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];

NSTextCheckingResult *result = [regular firstMatchInString:urlstring options:0 range:NSMakeRange(0, urlstring.length)];
    
NSRange resultRange = [result rangeAtIndex:1];


NSString *resultstr=[urlstring substringWithRange:resultRange];

  return resultstr;
    
}


@end
