//
//  DZCRereshControl.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/9.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCRereshControl.h"
#import "MJRefresh.h"

@implementation DZCRereshControl
//加入头部刷新控件,添加刷新控件动画
-(void)addRefreshControlheader:(UITableView*)tableview vcblock:(void(^)(void))viewblock{
   
    
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingBlock:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          
            viewblock();
           
            [tableview.mj_header endRefreshing];
        });

    }];
    //设置头部动态图片
    [self setHeadertimeAndimage:header];
  
    
    
    tableview.mj_header = header;
  
    
}
//添加脚步刷新控件
-(void)addfooterRefresh:(UITableView *)tableview vcblock:(void(^)(void))viewblock{
    
    MJRefreshAutoGifFooter *footer=[MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            viewblock();
            [tableview.mj_footer endRefreshing];
            
        });
    }];
    //添加脚部刷新控件
    [self setFootterimageAndstring:footer];
    
    tableview.mj_footer=footer;
    
    
}
//添加collectionview刷新头部
-(void)setupCollectionviewrefreshcontroll:(UICollectionView*)collectionview refreshblock:(void(^)(void))viewblock{
    
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            viewblock();
            
            [collectionview.mj_header endRefreshing];
        });
        
    }];
    //设置头部动态图片
    [self setHeadertimeAndimage:header];
    
    collectionview.mj_header=header;
}
//添加collectionview刷新尾部
-(void)setupCollectionviewfootter:(UICollectionView*)collectionview refreshblock:(void(^)(void))viewblock{
    
    MJRefreshAutoGifFooter *footer=[MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            viewblock();
            [collectionview.mj_footer endRefreshing];
            
        });
    }];
    //添加脚部刷新控件
    [self setFootterimageAndstring:footer];
    
    collectionview.mj_footer=footer;
}


//头部刷新控件图片,时间设定
-(void)setHeadertimeAndimage:(MJRefreshGifHeader *)header{
    
    [header setTitle:@"正在载入数据" forState:MJRefreshStateRefreshing];
    [header setTitle:@"数据载入中" forState:MJRefreshStateIdle];
    [header setTitle:@"放手就刷新" forState:MJRefreshStatePulling];
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
    
    
}

-(void)setFootterimageAndstring:(MJRefreshAutoGifFooter*)footer{
    
    NSMutableArray *sendloadarray=NSMutableArray.array;
    for (int i=0; i<8; i++) {
        NSString *imagestr=[NSString localizedStringWithFormat:@"sendloading_18x18_%d",i];
        UIImage *images=[UIImage imageNamed:imagestr];
        
        [sendloadarray addObject:images];
    }
    [footer setImages:sendloadarray.copy duration:0.25 forState:MJRefreshStateRefreshing];
    [footer setImages:@[[UIImage imageNamed:@"sendloading_18x18_0"]] forState:MJRefreshStateIdle];
    
    [footer setTitle:@"正在载入数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"数据载入中" forState:MJRefreshStateIdle];
    
}



@end
