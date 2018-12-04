//
//  NSAttributedString+DZCEmojiAttributedstring.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "NSAttributedString+DZCEmojiAttributedstring.h"
#import <UIKit/UIKit.h>
@implementation NSAttributedString (DZCEmojiAttributedstring)

+(NSMutableAttributedString*)StringWithemoji:(NSString*)repostText{
    //空字符串立即返回
    if (repostText==nil) {
        return nil;
    }
    
    //正则表达式
    NSString *pattern=@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    //截取多个需要的字符串
    NSRegularExpression *regular=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    //把字符串建立成数组
    NSArray *textarray=[regular matchesInString:repostText options:0 range:NSMakeRange(0, repostText.length)];
    //载入表情文件
    NSString *bundelstring=[[NSBundle mainBundle]pathForResource:@"emojis.plist" ofType:nil];
    
    NSArray *emojiarray=[NSArray arrayWithContentsOfFile:bundelstring];
    
    NSMutableAttributedString *attributestring=[[NSMutableAttributedString alloc]initWithString:repostText];
    //获取字符大小
    UIFont *font=[UIFont systemFontOfSize:14];
    
    CGSize imagesize=CGSizeMake(font.lineHeight, font.lineHeight);
    NSLog(@"%@",font);
    //反向循环获取数组的元素
    for (NSTextCheckingResult *result in [textarray reverseObjectEnumerator]) {
        //更换表情字符范围
        NSRange resultrang=[result range];
        
        NSString *resultstr=[repostText substringWithRange:resultrang];
        
        
        [emojiarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //循环匹配表情
            if ([resultstr isEqualToString:[obj valueForKey:@"name"]]) {
                
                
                NSTextAttachment *attachment=[[NSTextAttachment alloc]init];
                
                UIImage *imageemoji= [UIImage imageNamed:[obj valueForKey:@"png"]];
                //开启图片剪切上下文
                UIGraphicsBeginImageContext(imagesize);
                
                [imageemoji drawInRect:CGRectMake(0, 0, imagesize.width, imagesize.height)];
                
                UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
                
                attachment.image=image;
                
                NSAttributedString *imagestring=[NSAttributedString attributedStringWithAttachment:attachment];
                
                [attributestring replaceCharactersInRange:resultrang withAttributedString:imagestring];
            }
            
        }];
        
        
    }
    
    
    return attributestring ;
}
@end
