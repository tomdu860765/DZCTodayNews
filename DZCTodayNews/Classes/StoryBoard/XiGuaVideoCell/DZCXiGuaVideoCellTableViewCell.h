//
//  DZCXiGuaVideoCellTableViewCell.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/25.
//  Copyright © 2018 tomdu. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>
@class XiGuaModel;

NS_ASSUME_NONNULL_BEGIN

@interface DZCXiGuaVideoCellTableViewCell : UITableViewCell
@property(nonatomic,strong)XiGuaModel *cellmodel;



///显示子按钮隐和藏播放器
-(void)setHiddenavplayer;
@end

NS_ASSUME_NONNULL_END
