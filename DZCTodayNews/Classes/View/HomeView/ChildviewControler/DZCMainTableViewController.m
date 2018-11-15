//
//  DZCMainTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//
#import "DZCRereshControl.h"
#import "DZCMainTableViewController.h"
#import "DZCMainNewsModel.h"
#import "DZCTopNewsCell.h"
#import "DZCSinglePicCell.h"
#import "DZCNetsTools.h"
#import "DZCMainnewsViewController.h"
@interface DZCMainTableViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *MainVCarray;
@property(nonatomic,strong)DZCRereshControl *refreshcontrol;
@end

@implementation DZCMainTableViewController
//加载网络模型后刷新视图
-(void)setMainVCarray:(NSMutableArray *)MainVCarray{
    _MainVCarray=MainVCarray;
    
    [self.tableView reloadData];
}
-(DZCRereshControl*)refreshcontrol{
    if (_refreshcontrol==nil) {
      _refreshcontrol = DZCRereshControl.new;
    }
    return _refreshcontrol;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self networkForMainview];
    [self registerClass];
    [self addrefreshWithview:self.MainVCarray];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(sound:)
                                                name:@"ScrollViewOffset" object:self];
}
//接受通知并进行网络请求
-(void)sound:(NSNotification *) noti{
    DZCMainnewsViewController *vc= noti.object;
    NSLog(@"接受通知%@",@(vc.btnmark.tag));
    [self refreshloaddata:self.MainVCarray];
    [self.tableView setContentOffset:CGPointMake(0, 0)];
    
}
#pragma mark - Table view data source


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.MainVCarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"topnewsid";
    
    
    DZCMainNewsModel *model=self.MainVCarray[indexPath.row];
    if (model.middle_image.url) {
        DZCSinglePicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"singlepiccell"];
        cell.model=model;
        
        return cell;
    }
    
    DZCTopNewsCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    
    cell.model=self.MainVCarray[indexPath.row];
    
    return cell;
    
}
//注册cell
-(void)registerClass{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
    UINib *uib=[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    
    [self.tableView registerNib:uib forCellReuseIdentifier:@"topnewsid"];
    
    UINib *singleuib=[UINib nibWithNibName:@"SinglePicCell" bundle:nil];
    
    [self.tableView registerNib:singleuib forCellReuseIdentifier:@"singlepiccell"];
    
}
//按照分类加载新闻
-(void)networkForMainview{
 

    [DZCNetsTools NetworkMainNews:^(NSArray * array) {
        if (array) {
            
        
        self.modelArray=[NSMutableArray arrayWithArray:array];
            self.MainVCarray=self.modelArray;
            
        }
        
    }];
    
}
//添加刷新控件方法
-(void)addrefreshWithview:(NSMutableArray *)marray{
    
    DZCRereshControl *rereshControl=DZCRereshControl.new;
    
    [rereshControl addRefreshControlheader:self.tableView vcblock:^{
        [self refreshloaddata:marray];
         
        NSLog(@"上拉刷新");
    }];
    
    [rereshControl addfooterRefresh:self.tableView vcblock:^{
        [self pullrefreshloaddata:marray];
        NSLog(@"上拉刷新");
    }];
    

}


//向下刷新方法,注意数据是插入最前面
-(void)refreshloaddata:(NSMutableArray*)marray{
    
    [DZCNetsTools NetworkMainNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.MainVCarray insertObject:obj atIndex:0];
                
            }];
           
            [self.tableView reloadData];
        }
    }];
    
}
//向上拉刷新数据
-(void)pullrefreshloaddata:(NSMutableArray*)marray{
    [DZCNetsTools NetworkMainNews:^(NSArray * newsmodel)  {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.MainVCarray addObject:obj];
              
            }];
            [self.tableView reloadData];
        }
        
    }];
}
//注销通知中心
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
