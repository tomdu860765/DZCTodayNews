//
//  DZCMineTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/15.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMineTableViewController.h"
#import "DZCWeiboLoginController.h"
#import "DZCSigninCell.h"
#import "DZCWeiboUsermodel.h"
@interface DZCMineTableViewController ()
@property (strong, nonatomic) IBOutlet UITableViewRowAction *onecell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellnumone;//未登录的cell
@property(strong,nonatomic)DZCWeiboUsermodel *cellusermodel;//cell模型
@end

@implementation DZCMineTableViewController

-(DZCWeiboUsermodel*)cellusermodel{
    if (_cellusermodel==nil) {
        _cellusermodel=DZCWeiboUsermodel.new;
    }
    
    return _cellusermodel;
}

//微博登录
- (IBAction)weibologin:(UIButton *)sender {
    //发出网络请求
    
    UIStoryboard *loginvcsb=[UIStoryboard storyboardWithName:@"DZCWeiboLoginController" bundle:nil];
    
    DZCWeiboLoginController *loginvc=[loginvcsb instantiateViewControllerWithIdentifier:@"LoginController"];
    
    
    [self presentViewController:loginvc animated:YES completion:nil];
    
    
    //回调block 重新加载页面
  
    loginvc.vcblock = ^(id model) {
       
        //注册并显示cell
        [self registcellForsignin:model];
        
    };
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    
   
    
}
//注册一个登录cell
-(void)registcellForsignin:(DZCWeiboUsermodel*)model{
    //移除旧有子视图
    for (UIView *view in self.cellnumone.subviews) {
        
        [view removeFromSuperview];
        
    }
    DZCSigninCell *cell=[[NSBundle mainBundle]loadNibNamed:@"Signincell" owner:self options:nil].lastObject;
    cell.usermodel=model;
    
    //添加新的子视图
    [self.cellnumone addSubview:cell.contentView];
}



@end
