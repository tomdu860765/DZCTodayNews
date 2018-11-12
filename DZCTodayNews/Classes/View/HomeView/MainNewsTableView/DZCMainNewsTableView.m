//
//  DZCMainNewsTableView.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/8.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainNewsTableView.h"
#import "DZCRereshControl.h"

@interface DZCMainNewsTableView()

@end
@implementation DZCMainNewsTableView

//新闻表视图方法
+(UITableView *)SetupNewsTableview:(DZCHomeViewVC* )controller tableviewrect:(CGRect)rect{
    

    UITableView *tableview =[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    
    tableview.delegate=(id)controller;
    tableview.dataSource=(id)controller;
    tableview.showsVerticalScrollIndicator=NO;
  
    
    return tableview;
}




@end
