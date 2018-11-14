//
//  DZCMainNewsTableView.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/8.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainNewsTableView.h"
#import "DZCRereshControl.h"
#import "Masonry.h"
#import "DZCHomeViewVC.h"
@interface DZCMainNewsTableView()

@end
@implementation DZCMainNewsTableView

//新闻表视图方法
+(UITableView *)SetupNewsTableview:(DZCHomeViewVC* )controller tableviewrect:(CGRect)rect{
    

    UITableView *tableview =[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    
    UINib *uib=[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    [tableview registerNib:uib forCellReuseIdentifier:@"topnewsid"];
    UINib *singleuib=[UINib nibWithNibName:@"SinglePicCell" bundle:nil];
    [tableview registerNib:singleuib forCellReuseIdentifier:@"singlepiccell"];
    
    tableview.showsVerticalScrollIndicator=NO;
    tableview.estimatedRowHeight=100;
    
    return tableview;
}


+(void)addcategoryNewstableview:(NSArray*)array  controller:(DZCHomeViewVC*)controller{
    
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGRect rect=CGRectMake(SCREENWIDTH*idx, 0, SCREENWIDTH, SCREENHEIGHT);
        UITableView *tableview=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        [controller.mainScrollview  addSubview:tableview];
        
        UINib *uib=[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
        [tableview registerNib:uib forCellReuseIdentifier:@"topnewsid"];
        UINib *singleuib=[UINib nibWithNibName:@"SinglePicCell" bundle:nil];
        [tableview registerNib:singleuib forCellReuseIdentifier:@"singlepiccell"];
        
        tableview.showsVerticalScrollIndicator=NO;
        tableview.estimatedRowHeight=100;
            [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(controller.naviScrollview.mas_bottom).offset(0);
                make.left.equalTo(controller.view.mas_left).offset(SCREENWIDTH*idx);
                make.width.mas_equalTo(SCREENWIDTH);
                make.height.mas_equalTo(SCREENHEIGHT);
            }];
        
        
    }];
    NSLog(@"加载tableview");
}



@end
