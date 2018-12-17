//
//  DZCMineTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/15.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMineTableViewController.h"
#import "DZCWeiboLoginController.h"
@interface DZCMineTableViewController ()


@end

@implementation DZCMineTableViewController
//微博登录
- (IBAction)weibologin:(UIButton *)sender {
    //发出网络请求
    DZCWeiboLoginController *loginvc=DZCWeiboLoginController.new;
    
    
   
    [self.navigationController pushViewController:loginvc animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
}



@end
