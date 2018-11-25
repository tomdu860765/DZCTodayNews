//
//  XiGuaBaseTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/23.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "XiGuaBaseTableViewController.h"
#import "DZCRereshControl.h"
#import "XiGuaModel.h"
#import "DZCNetsTools.h"
#import "DZCXiGuaVideoCellTableViewCell.h"
@interface XiGuaBaseTableViewController ()
@property(nonatomic,strong)NSMutableArray *VideoArray;
@end

@implementation XiGuaBaseTableViewController

-(void)setVideoArray:(NSMutableArray *)VideoArray{
    _VideoArray=VideoArray;
    
     [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addrefreshWithview:self.VideoArray];
    [self registervideoCell];
    [self netWorkForXiGuaVideoController];
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
}
//基类表视图执行网络方法
-(void)netWorkForXiGuaVideoController{
    [DZCNetsTools netWorkForXiGuaVideoWithModel:^(id modelarray) {
        self.VideoArray=[NSMutableArray arrayWithArray:modelarray];
         
        
    } WithControllerString:NSStringFromClass([self class])];
   
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.VideoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DZCXiGuaVideoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xiguavideocell" forIndexPath:indexPath];
    
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"DZCXiGuaVideoCellTableViewCell" owner:nil options:nil].lastObject;
    }
    XiGuaModel *videomodel=self.VideoArray[indexPath.row];
    
    cell.cellmodel=videomodel;
    return cell;
}
-(void)registervideoCell{
    
 
    
    UINib *videonib=[UINib nibWithNibName:@"DZCXiGuaVideoCellTableViewCell" bundle:nil];
    [self.tableView registerNib:videonib forCellReuseIdentifier:@"xiguavideocell"];
    
    
}

//添加刷新控件方法
-(void)addrefreshWithview:(NSMutableArray *)marray{
    
    DZCRereshControl *rereshControl=DZCRereshControl.new;
    
    [rereshControl addRefreshControlheader:self.tableView vcblock:^{
       [self refreshloaddata:marray];
        
        NSLog(@"下拉西瓜视频刷新");
    }];
    
    [rereshControl addfooterRefresh:self.tableView vcblock:^{
        [self pullrefreshloaddata:marray];
        NSLog(@"上拉西瓜x视频刷新");
    }];

}
//向下刷新方法,注意数据是插入最前面
-(void)refreshloaddata:(NSMutableArray*)marray{
    [DZCNetsTools netWorkForXiGuaVideoWithModel:^(id model) {
        if (model) {
            [model enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.VideoArray insertObject:obj atIndex:0];
                
            }];
            
            [self.tableView reloadData];
        }
    } WithControllerString:NSStringFromClass([self class])] ;

}
//向上拉刷新数据
-(void)pullrefreshloaddata:(NSMutableArray*)marray{
    
    [DZCNetsTools netWorkForXiGuaVideoWithModel:^(id model) {
        if (model) {
            [model enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.VideoArray addObject:obj];
                
            }];
            [self.tableView reloadData];
        }
    } WithControllerString:NSStringFromClass([self class])] ;
    
}


@end
