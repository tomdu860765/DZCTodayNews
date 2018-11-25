//
//  XiGuaBaseTableViewController.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/23.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XiGuaModel;
NS_ASSUME_NONNULL_BEGIN

@interface XiGuaBaseTableViewController : UITableViewController
@property(nonatomic,strong)XiGuaModel *model;
@end

NS_ASSUME_NONNULL_END
