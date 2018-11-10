//
//  DZCRereshControl.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/9.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZCRereshControl : UIView
-(void)addRefreshControlheader:(UITableView *)tableview vcblock:(void(^)(void))viewblock;
-(void)addfooterRefresh:(UITableView *)tableview vcblock:(void(^)(void))viewblock;
@end

NS_ASSUME_NONNULL_END
