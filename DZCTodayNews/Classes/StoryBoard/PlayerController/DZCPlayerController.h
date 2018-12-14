//
//  DZCPlayerController.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/8.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DZCPlayerController : UIViewController
//播放链接
@property(nonatomic,strong)NSURL *urlstring;
//播放视频控制器的大小
@property(nonatomic,strong)UIView *videoviewframe;

@end

NS_ASSUME_NONNULL_END
