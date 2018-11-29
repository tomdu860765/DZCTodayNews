//
//  DZCVideoTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCVideoTableViewController.h"
#import "DZCVideoCell.h"


@interface DZCVideoTableViewController ()
@property(nonatomic,strong)NSMutableArray *MainVCarray;
@property(nonatomic,strong)DZCVideoCell *cellmark;


@end

@implementation DZCVideoTableViewController

-(void)setMainVCarray:(NSMutableArray *)MainVCarray{
    _MainVCarray=MainVCarray;
   
    [self.tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
 
 
}


-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSLog(@"横向滚动消失");
    [self.cellmark cellsubViewsshow];
}







//重写点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
