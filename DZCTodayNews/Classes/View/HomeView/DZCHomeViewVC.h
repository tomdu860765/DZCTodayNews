//
//  DZCHomeViewVC.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZCHomeViewVC : DZCMainViewController
@property(nonatomic,strong)UIScrollView *mainScrollview ;
@property(nonatomic,strong)UIScrollView  *naviScrollview;
//添加刷新方法
-(void)refreshloaddata;
@end

NS_ASSUME_NONNULL_END
