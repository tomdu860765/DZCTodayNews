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
@interface DZCBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,assign)BOOL markYcount;
@end

@implementation DZCBaseTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self SetupTableviewnib];
    [self.tableView reloadData];
    [self addrefreshWithview:self.modelArray];
    
}
//改写初始化方法使用固定初始化式启动
- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStylePlain];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid=@"topnewsid";

    DZCMainNewsModel *model=self.modelArray[indexPath.row];
    if (model.middle_image.url) {
        DZCSinglePicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"singlepiccell"];
        cell.model=model;

        return cell;
    }

    DZCTopNewsCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];

    cell.model=self.modelArray[indexPath.row];
   
   
    return cell;
    
}

-(void)SetupTableviewnib{
    
   self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentScrollableAxes;
    UINib *uib=[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    
    [self.tableView registerNib:uib forCellReuseIdentifier:@"topnewsid"];
    
    UINib *singleuib=[UINib nibWithNibName:@"SinglePicCell" bundle:nil];
    
    [self.tableView registerNib:singleuib forCellReuseIdentifier:@"singlepiccell"];
    

}

//滚动视图控制器监控
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //如果有上下拉动不执行该通知.
    // 用bool 拉伸y滚动的真假,最后结束返回假
   
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
-(void)refreshloaddata:(NSMutableArray *)marray{
    
    [DZCNetsTools NetworkMainNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marray insertObject:obj atIndex:0];
                
            }];
            [self.tableView reloadData];
        }
    }];
    
}
//向上拉刷新数据
-(void)pullrefreshloaddata:(NSMutableArray *)marray{
    [DZCNetsTools NetworkMainNews:^(NSArray * newsmodel)  {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marray addObject:obj];
            }];
            [self.tableView reloadData];
        }
        
    }];
}
//销毁通知
-(void)dealloc{
    
   
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
@end
