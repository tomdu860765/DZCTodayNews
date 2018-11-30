//
//  UIImageView+DZCRoundImageView.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/30.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (DZCRoundImageView)
///图片圆形切割方法
///
///*参数一 需要圆形切图的imageview
///*参数二 网络链接路径

-(void)ImageviewcutRound:(UIImageView*)imageview withurl:(NSString*)urlstring;
@end

NS_ASSUME_NONNULL_END
