//
//  DZCHotNewsTableViewCell.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/15.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZCMainNewsModel;
NS_ASSUME_NONNULL_BEGIN

@interface DZCHotNewsTableViewCell : UITableViewCell
@property(strong,nonatomic) DZCMainNewsModel *model;
@end

NS_ASSUME_NONNULL_END
