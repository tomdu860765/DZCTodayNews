//
//  UIImage+DZCImageround.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/30.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DZCImageround)
///图片圆形截图办法
///
///*参数一 传入图片
///*返回值一 返回截图后图片

-(UIImage*)CutRoundImageView:(UIImage*)image;
@end

NS_ASSUME_NONNULL_END
