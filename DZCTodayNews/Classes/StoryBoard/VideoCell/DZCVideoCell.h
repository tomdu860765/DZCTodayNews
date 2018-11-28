//
//  DZCVideoCell.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/16.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZCMainNewsModel;
#import  <AVFoundation/AVFoundation.h>
#import  <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DZCVideoCell : UITableViewCell
@property(strong,nonatomic) DZCMainNewsModel *model;
@property(nonatomic,strong)AVPlayerViewController *AVPlayerViewController;

@end

NS_ASSUME_NONNULL_END
