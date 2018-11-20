//
//  DZCnewsLocalTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCnewsLocalTableViewController.h"
#import "DZCRereshControl.h"
#import "DZCMainNewsModel.h"
#import "DZCTopNewsCell.h"
#import "DZCSinglePicCell.h"
#import "DZCNetsTools.h"
#import "DZCMainnewsViewController.h"
#import "DZCHotNewsTableViewCell.h"
#import "DZCThreePicCell.h"
@interface DZCnewsLocalTableViewController ()
@property(nonatomic,strong)NSMutableArray *MainVCarray;
@property(nonatomic,strong)UITableViewCell *cellmark;
@end

@implementation DZCnewsLocalTableViewController
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
    
    if (model.gallary_image_count==1) {
        DZCSinglePicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"singlepiccell"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"SinglePicCell" owner:nil options:nil].lastObject ;
        }
        cell.model=model;
        
        return cell;
    }else if (model.ishot==YES&&model.gallary_image_count<3){
        
        DZCHotNewsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"hotnewscell"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"DZCHotNewsTableViewCell" owner:nil options:nil].lastObject ;
        }
        
        cell.model=model;
        
        return cell;
        
    }else if (model.gallary_image_count>=3&&model.image_list){
        
         DZCThreePicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"threepiccell" forIndexPath:indexPath];

        
        self.cellmark=cell;
        cell.model=model;
        
        return cell;
    }
    
    DZCTopNewsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"topnewsid"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil].lastObject ;
    }
    cell.model=model;
    
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
    
    UINib *threepic=[UINib nibWithNibName:@"ThreePiccell" bundle:nil];
    
    [self.tableView registerNib:threepic forCellReuseIdentifier:@"threepiccell"];
    
    
    
}
//按照分类加载新闻
-(void)networkForMainview{
    
    
    [DZCNetsTools NetworHotNews:^(NSArray * array) {
        if (array) {
            
            
            self.modelArray=[NSMutableArray arrayWithArray:array];
            self.MainVCarray=self.modelArray;
            [self.tableView reloadData];
        }
    } WithKeyworks:@(2)];
    
    
    
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
    } WithKeyworks:@(2)];
    
    
    
}
//向上拉刷新数据
-(void)pullrefreshloaddata:(NSMutableArray*)marray{
    
    [DZCNetsTools NetworHotNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.MainVCarray addObject:obj];
            }];
            [self.tableView reloadData];}
    } WithKeyworks:@(2)];
    
    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
