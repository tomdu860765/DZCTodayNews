//
//  DZCWeitoutiaoView.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/1.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZCWeitoutiaoModel;
NS_ASSUME_NONNULL_BEGIN

@interface DZCWeitoutiaoView : UIView
///计算微头条高度
///
///*参数一 传入模型
///*返回值一 返回视图高度

-(CGFloat)ninepicturesViewHeight:(DZCWeitoutiaoModel*)modelpics;
@end

NS_ASSUME_NONNULL_END
