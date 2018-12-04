//
//  NSAttributedString+DZCEmojiAttributedstring.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (DZCEmojiAttributedstring)
///emoji表情替换方法
///
///*参数一 需要处理表情的字符串
///*参数二 返回富文本字符串
+(NSMutableAttributedString*)StringWithemoji:(NSString*)repostText;

@end

NS_ASSUME_NONNULL_END
