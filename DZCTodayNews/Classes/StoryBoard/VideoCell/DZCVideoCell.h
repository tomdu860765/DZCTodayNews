//
//  DZCVideoCell.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/16.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZCMainNewsModel;
@class DZCVideolistModel;
NS_ASSUME_NONNULL_BEGIN

@interface DZCVideoCell : UITableViewCell
@property(strong,nonatomic) DZCMainNewsModel *model;

@property(assign,nonatomic,getter=isvisiblemark)BOOL visiblemark;

@end

NS_ASSUME_NONNULL_END
