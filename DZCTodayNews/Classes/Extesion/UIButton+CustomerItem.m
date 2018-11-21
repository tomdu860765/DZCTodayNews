//
//  UIButton+CustomerItem.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/21.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "UIButton+CustomerItem.h"

@implementation UIButton (CustomerItem)

///自定义按钮方法,用来避免在导航栏,工具栏被系统渲染
///
///*参数一 返回按钮
///*参数二 图片名字

+(UIButton*)ButtonForCustomerstyle:(NSString*)picString{
    UIButton *btn=[[UIButton alloc]init];
    
    UIImage *image=[[UIImage imageNamed:picString]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    
    
    [btn sizeToFit];
    return btn;
}
@end
