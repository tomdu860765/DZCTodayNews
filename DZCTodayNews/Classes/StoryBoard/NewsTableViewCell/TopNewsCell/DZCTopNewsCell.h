//
//  DZCTopNewsCell.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZCMainNewsModel;
NS_ASSUME_NONNULL_BEGIN

@interface DZCTopNewsCell : UITableViewCell
@property(strong,nonatomic) DZCMainNewsModel *model;
@end

NS_ASSUME_NONNULL_END
