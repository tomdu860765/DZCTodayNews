//
//  UIImage+DZCImageround.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/30.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "UIImage+DZCImageround.h"

@implementation UIImage (DZCImageround)
-(UIImage*)CutRoundImageView:(UIImage*)image{
    
    
    //开启绘图上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //绘制贝塞尔路径
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //按照路径截图
    [path addClip];
    //按路径绘图
    [image drawAtPoint:CGPointMake(0, 0)];
    
    
    UIImage *resultimage=UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    
    
    return resultimage;
    
}

@end
