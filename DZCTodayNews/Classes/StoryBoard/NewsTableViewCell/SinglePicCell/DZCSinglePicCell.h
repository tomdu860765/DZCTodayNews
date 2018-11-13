//
//  DZCSinglePicCell.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZCMainNewsModel;
NS_ASSUME_NONNULL_BEGIN

@interface DZCSinglePicCell : UITableViewCell
//模型
@property(strong,nonatomic) DZCMainNewsModel *model;
@end

NS_ASSUME_NONNULL_END
