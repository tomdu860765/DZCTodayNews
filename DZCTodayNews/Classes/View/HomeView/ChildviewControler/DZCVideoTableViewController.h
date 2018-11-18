//
//  DZCVideoTableViewController.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCBaseTableViewController.h"
#import  <AVFoundation/AVFoundation.h>
#import  <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DZCVideoTableViewController : DZCBaseTableViewController
@property(nonatomic,strong)NSURL *videourl;
@end

NS_ASSUME_NONNULL_END
