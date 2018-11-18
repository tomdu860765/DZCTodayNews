//
//  DZCNewshotTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCNewshotTableViewController.h"
#import "DZCRereshControl.h"
#import "DZCMainNewsModel.h"
#import "DZCTopNewsCell.h"
#import "DZCSinglePicCell.h"
#import "DZCNetsTools.h"
#import "DZCMainnewsViewController.h"
#import "DZCHotNewsTableViewCell.h"
@interface DZCNewshotTableViewController ()
@property(nonatomic,strong)NSMutableArray *MainVCarray;
@end

@implementation DZCNewshotTableViewController
-(void)setMainVCarray:(NSMutableArray *)MainVCarray{
    _MainVCarray=MainVCarray;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self networkForMainview];
    [self registerClass];
    [self addrefreshWithview:self.MainVCarray];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(responseNewsnetwork:)
                                                name:@"ScrollViewOffset" object:nil];
}
//接受通知并进行网络请求
-(void)responseNewsnetwork:(NSNotification *) noti{
    //对比控制器名称是否一致,一致则请求网络更新
    
    DZCMainnewsViewController *viewcontorller=(DZCMainnewsViewController*)noti.object;
    NSString *stringVC=NSStringFromClass([self class]);
    NSString *stringChildVC=NSStringFromClass([viewcontorller.childViewControllers[viewcontorller.btnmark.tag] class]);
    
    
    if ([stringVC isEqualToString:stringChildVC]) {
        
        
        [self refreshloaddata:self.MainVCarray];
        
        [self.tableView setContentOffset:CGPointMake(0, 0)];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.MainVCarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DZCMainNewsModel *model=self.MainVCarray[indexPath.row];
    
    if (model.middle_image.url) {
        DZCSinglePicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"singlepiccell"];
        cell.model=model;
        
        return cell;
    }else if (model.ishot==YES){
        
        DZCHotNewsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"hotnewscell"];

        cell.model=self.MainVCarray[indexPath.row];

        return cell;

    }
    
    DZCTopNewsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"topnewsid"];
    
    cell.model=self.MainVCarray[indexPath.row];
    
    return cell;
    
}
-(void)registerClass{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
    UINib *uib=[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    
    [self.tableView registerNib:uib forCellReuseIdentifier:@"topnewsid"];
    
    UINib *singleuib=[UINib nibWithNibName:@"SinglePicCell" bundle:nil];
    
    [self.tableView registerNib:singleuib forCellReuseIdentifier:@"singlepiccell"];
    
    
    UINib *hotnewsuib=[UINib nibWithNibName:@"DZCHotNewsTableViewCell" bundle:nil];
    [self.tableView registerNib:hotnewsuib forCellReuseIdentifier:@"hotnewscell"];
    
}
//按照分类加载新闻
-(void)networkForMainview{
    
    
    [DZCNetsTools NetworHotNews:^(NSArray * array) {
        if (array) {
            
        
        self.modelArray=[NSMutableArray arrayWithArray:array];
            self.MainVCarray=self.modelArray;}
    } WithKeyworks:@(1)];
    
    
    
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
    

    [DZCNetsTools NetworHotNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.MainVCarray insertObject:obj atIndex:0];
                
            }];
            
            [self.tableView reloadData];}
    } WithKeyworks:@(1)];
    
    
    
}
//向上拉刷新数据
-(void)pullrefreshloaddata:(NSMutableArray*)marray{
  
    [DZCNetsTools NetworHotNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.MainVCarray addObject:obj];          
            }];
            [self.tableView reloadData];}
    } WithKeyworks:@(1)];
    
    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
