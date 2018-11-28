//
//  DZCBaseTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCBaseTableViewController.h"
#import "DZCMainNewsModel.h"
#import "DZCTopNewsCell.h"
#import "DZCSinglePicCell.h"
#import "DZCRereshControl.h"
#import "DZCNetsTools.h"
#import "DZCMainnewsViewController.h"
#import "DZCCellDeataleViewController.h"
#import "DZCHotNewsTableViewCell.h"
#import "DZCThreePicCell.h"
#import "DZCVideoCell.h"

@interface DZCBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,assign)BOOL markYcount;
@property(nonatomic,strong)NSMutableArray *MainVCarray;
@property(nonatomic,strong)DZCVideoCell *cellmark;
@end

@implementation DZCBaseTableViewController


-(void)setMainVCarray:(NSMutableArray *)MainVCarray{
    _MainVCarray=MainVCarray;
    
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self SetupTableviewnib];
    
    [self addrefreshWithview];
    [self networkWithHomebaseView];
}
//主视图基类网络方法
-(void)networkWithHomebaseView{
    [DZCNetsTools basetableviewNetworHotNews:^(NSArray * homemodelarray) {
        
        self.MainVCarray=[NSMutableArray arrayWithArray:homemodelarray];
        
    } wihtViewControllerString:NSStringFromClass([self class])];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.MainVCarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        
        
        cell.model=model;
        
        return cell;
    }else if ([@"DZCVideoTableViewController" isEqualToString:NSStringFromClass([self class])]){
        DZCVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"videocell"];
        
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"DZCVideoCell" owner:self options:nil].lastObject;
        }
        
        
        cell.model=model;
        self.cellmark=cell;
        return cell;
        
    }
    
    DZCTopNewsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"topnewsid"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil].lastObject ;
    }
    cell.model=self.MainVCarray[indexPath.row];
    
    return cell;
    
}

-(void)SetupTableviewnib{
    UINib *uib=[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    
    [self.tableView registerNib:uib forCellReuseIdentifier:@"topnewsid"];
    
    UINib *singleuib=[UINib nibWithNibName:@"SinglePicCell" bundle:nil];
    
    [self.tableView registerNib:singleuib forCellReuseIdentifier:@"singlepiccell"];
    
    UINib *hotnewsuib=[UINib nibWithNibName:@"DZCHotNewsTableViewCell" bundle:nil];
    [self.tableView registerNib:hotnewsuib forCellReuseIdentifier:@"hotnewscell"];
    
    UINib *threepic=[UINib nibWithNibName:@"ThreePiccell" bundle:nil];
    
    [self.tableView registerNib:threepic forCellReuseIdentifier:@"threepiccell"];
    
    UINib *videouib=[UINib nibWithNibName:@"DZCVideoCell" bundle:nil];
    
    [self.tableView registerNib:videouib forCellReuseIdentifier:@"DZCVideoCell"];

}

//滚动视图控制器监控
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //如果有上下拉动不执行该通知.
    // 用bool记录拉伸y滚动的真假,最后结束返回假
   
    if (scrollView.contentOffset.x&&self.markYcount==NO) {

    int page= scrollView.contentOffset.x/SCREENWIDTH ;
     
        
    self.page=page;
     [[NSNotificationCenter defaultCenter]postNotificationName:@"offsetForMainscrollview" object:self];
     self.markYcount=NO;
    }else if
        (scrollView.contentOffset.x==0&&self.markYcount==NO&&scrollView.contentOffset.y==0)
    {
        self.page=0;
       
        [[NSNotificationCenter defaultCenter]postNotificationName:@"offsetForMainscrollview" object:self];
        self.markYcount=NO;
    }

}
//通过有y滚动记录下
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y){
        self.markYcount=YES;
    }
}

//添加刷新控件方法
-(void)addrefreshWithview{
    
    DZCRereshControl *rereshControl=DZCRereshControl.new;
    
    [rereshControl addRefreshControlheader:self.tableView vcblock:^{
        [self refreshloaddata:self.MainVCarray];
       
        NSLog(@"上拉刷新");
    }];
    
    [rereshControl addfooterRefresh:self.tableView vcblock:^{
        [self pullrefreshloaddata:self.MainVCarray];
        NSLog(@"上拉刷新");
    }];
    
    
}

//向下刷新方法,注意数据是插入最前面
-(void)refreshloaddata:(NSMutableArray *)marray{
    
  
    [DZCNetsTools basetableviewNetworHotNews:^(NSArray * newsmodel) {
        
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marray insertObject:obj atIndex:0];
                
            }];
           
            [self.tableView reloadData];
        }
        
    } wihtViewControllerString:NSStringFromClass([self class])];
    
    
}
//向上拉刷新数据
-(void)pullrefreshloaddata:(NSMutableArray *)marray{
 
    [DZCNetsTools basetableviewNetworHotNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marray addObject:obj];
            }];
           
            [self.tableView reloadData];
        }
        
    } wihtViewControllerString:NSStringFromClass([self class])];
    
    
}
//销毁通知
-(void)dealloc{
    
   
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UIStoryboard *sbvc=[UIStoryboard storyboardWithName:@"CellDeataleController" bundle:nil];
     DZCCellDeataleViewController *deatalevc=[sbvc instantiateViewControllerWithIdentifier:@"celldeatalecontroller"];
    
    [self presentViewController:deatalevc animated:YES completion:^{
      deatalevc.deatalModel =self.MainVCarray[indexPath.row];
    }];
    
}

@end
