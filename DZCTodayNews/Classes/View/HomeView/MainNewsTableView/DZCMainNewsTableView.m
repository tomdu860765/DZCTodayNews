//
//  DZCMainNewsTableView.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/8.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainNewsTableView.h"
#import "MJRefresh.h"
#import "Masonry.h"
@interface DZCMainNewsTableView()

@end
@implementation DZCMainNewsTableView
//dropdown_loading_00 -15
//sendloading_18x18_0 -07
//新闻表视图方法
+(UITableView *)SetupNewsTableview:(DZCHomeViewVC* )controller tableviewrect:(CGRect)rect{
    
    
    
    UITableView *tableview =[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    
    tableview.delegate=(id)controller;
    tableview.dataSource=(id)controller;
    tableview.showsVerticalScrollIndicator=NO;
    [DZCMainNewsTableView addRefreshControl:tableview];
    [tableview.tableFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tableview.mas_bottom).offset(-SCREENHEIGHT);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(44);
        
    }];
    
    return tableview;
}

//加入刷新控件,添加刷新控件动画
+(void)addRefreshControl:(UITableView *)tableview{
    
    
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            [DZCMainNewsTableView refreshloaddata];
            [tableview.mj_header endRefreshing];
            
        });
        
    }];
    [header setTitle:@"正在载入数据" forState:MJRefreshStateRefreshing];
    [header setTitle:@"数据载入完成" forState:MJRefreshStateIdle];
    NSMutableArray *imagesarray=NSMutableArray.array;
    for (int i=0; i<16; i++) {
        NSString *imagestr=[NSString localizedStringWithFormat:@"dropdown_loading_0%d",i];
        UIImage *images=[UIImage imageNamed:imagestr];
        
        [imagesarray addObject:images];
    }
    
    [header setImages:imagesarray.copy duration:0.5 forState:MJRefreshStateRefreshing];
    [header setImages:@[[UIImage imageNamed:@"dropdown_loading_00"]] forState:MJRefreshStateIdle];
    header.lastUpdatedTimeText = ^NSString *(NSDate *lastUpdatedTime) {
        
        NSDateFormatter *datemater=NSDateFormatter.new;
        [datemater setDateFormat:@"HH:mm"];
        NSString *str=[datemater stringFromDate:lastUpdatedTime];
        NSString *timestr=[NSString stringWithFormat:@"最近加载时间是:%@",str];
        
        return timestr;
    };
    MJRefreshAutoGifFooter *footer=[MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [DZCMainNewsTableView refreshfooterloaddata];
            [tableview.mj_footer endRefreshing];
        });
    }];
    NSMutableArray *sendloadarray=NSMutableArray.array;
    for (int i=0; i<8; i++) {
        NSString *imagestr=[NSString localizedStringWithFormat:@"sendloading_18x18_%d",i];
        UIImage *images=[UIImage imageNamed:imagestr];
        
        [imagesarray addObject:images];
    }
    [footer setImages:sendloadarray.copy duration:0.5 forState:MJRefreshStateRefreshing];
    [footer setImages:@[[UIImage imageNamed:@"sendloading_18x18_0"]] forState:MJRefreshStateIdle];
    
    [footer setTitle:@"正在载入数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"数据载入完成" forState:MJRefreshStateIdle];
    
    tableview.mj_footer=footer;
    
    tableview.mj_header = header;
    
    
}

//FIXME刷新方法待用,注意数据是插入最前面
+(void)refreshloaddata{
    
    NSLog(@"载入数据");
}

+(void)refreshfooterloaddata{
    NSLog(@"向上刷新");
}


@end
