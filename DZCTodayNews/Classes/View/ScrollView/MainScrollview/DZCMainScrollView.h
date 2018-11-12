//
//  DZCMainScrollView.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZCMainViewController;
NS_ASSUME_NONNULL_BEGIN

@interface DZCMainScrollView : UIScrollView
+(UIScrollView*)addMainScrollview:(DZCMainViewController *)viewcontroller addTableview:(UITableView *)tableView withScrollview:(UIScrollView *)navisview;

@end

NS_ASSUME_NONNULL_END
