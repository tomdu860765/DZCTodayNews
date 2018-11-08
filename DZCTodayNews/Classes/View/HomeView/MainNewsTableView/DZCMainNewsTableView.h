//
//  DZCMainNewsTableView.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/8.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZCHomeViewVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface DZCMainNewsTableView : UITableView

+(UITableView *)SetupNewsTableview:(DZCHomeViewVC* )controller tableviewrect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
