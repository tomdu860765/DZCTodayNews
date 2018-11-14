//
//  DZCMainScrollView.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainScrollView.h"
#import "Masonry.h"
#import "DZCMainViewController.h"
@implementation DZCMainScrollView

//主视图滚动视图
+(UIScrollView*)addMainScrollview:(DZCMainViewController *)viewcontroller addTableview:(UITableView *)tableView withScrollview:(UIScrollView *)navisview{
    UIScrollView *sv=[[UIScrollView alloc]initWithFrame:SCREENBOUNDS];
    
    sv.backgroundColor = UIColor.whiteColor;
    sv.pagingEnabled=YES;
    sv.bounces=NO;
    sv.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentScrollableAxes;
   [sv addSubview:tableView];
   
   
    return sv;
}

@end
