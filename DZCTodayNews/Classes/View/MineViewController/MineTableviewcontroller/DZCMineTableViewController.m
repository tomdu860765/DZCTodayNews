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
#import "DZCNetsTools.h"
#import "UIImageView+DZCRoundImageView.h"
@interface DZCMineTableViewController ()

@property (strong, nonatomic) IBOutlet UIButton *signoutbtn;//登出按钮
@property(strong,nonatomic)DZCWeiboUsermodel *cellusermodel;//cell模型
@property (strong, nonatomic) IBOutlet UIImageView *signimageview;//头像
@property (strong, nonatomic) IBOutlet UILabel *namelabel;//名字
@property (strong, nonatomic) IBOutlet UILabel *deataillabel;//描述
@property (strong, nonatomic) IBOutlet UITableViewRowAction *onecell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellnumone;//未登录的cell
@property (strong, nonatomic) IBOutlet UITableViewCell *issignincell;//已经登录的cell
@property(strong,nonatomic)UITableViewController *tableviewcontroller;

@end

@implementation DZCMineTableViewController
-(UITableViewController*)tableviewcontroller
{
    if (_tableviewcontroller==nil) {
        UIStoryboard *minesb=[UIStoryboard storyboardWithName:@"DZCMineViewController" bundle:nil];
        _tableviewcontroller= [minesb instantiateViewControllerWithIdentifier:@"minestoryborad"];
    }
    
    
    return _tableviewcontroller;
}


- (IBAction)signoutaction:(UIButton *)sender {


    
    //载入新视图
    [self.view addSubview:self.tableviewcontroller.view];

   
    //判断是否含有登录文件并删除登录文件
    NSString *filepath=[DocumentpathString stringByAppendingPathComponent:@"weibojson"];
    
    
    
    if ([[NSFileManager defaultManager]isDeletableFileAtPath:filepath]) {
        
        [[NSFileManager defaultManager]removeItemAtPath:filepath error:nil];
        NSLog(@"登录文件已经删除");
        
    }
    
}



-(void)setCellusermodel:(DZCWeiboUsermodel *)cellusermodel{
    _cellusermodel=cellusermodel;
    
    self.namelabel.text=cellusermodel.screen_name;
    
    self.deataillabel.text=cellusermodel.userdescription;
    
    [self.signimageview ImageviewcutRound:self.signimageview withurl:cellusermodel.avatar_large];
    
}

//微博登录
- (IBAction)weibologin:(UIButton *)sender {
    //发出网络请求
    [self loadLoginviewController];
    
}

///载入网页登录页面请求
-(void)loadLoginviewController{
    
    UIStoryboard *loginvcsb=[UIStoryboard storyboardWithName:@"DZCWeiboLoginController" bundle:nil];
    
    DZCWeiboLoginController *loginvc=[loginvcsb instantiateViewControllerWithIdentifier:@"LoginController"];
    
    //改成根控制器来推出登录视图
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginvc animated:YES completion:nil];
    
    
    //回调block 重新加载页面
    
    loginvc.vcblock = ^(id model) {
        
        //注册并显示cell
        [self registcellForsignin:model];
        
    };

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    
    //如果有登录token,执行网络方法
    if ( [[NSUserDefaults standardUserDefaults]boolForKey:@"usersign"]) {
        //执行网络方法
        [self networksetuser];
    }
    
    
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

//执行网络方法加载个人信息
-(void)networksetuser{
    NSString *filepath=[DocumentpathString stringByAppendingPathComponent:@"weibojson"];
    
    NSData *jsondata=[NSData dataWithContentsOfFile:filepath];
    
    NSDictionary *dictjson=  [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:nil];
    NSString *strtoken=  [dictjson valueForKey:@"access_token"] ;
    NSString *uidstr=[dictjson valueForKey:@"uid"];
    [DZCNetsTools WeiboUserinfo:strtoken uidstring:uidstr FinishBlock:^(id cellmodel) {
        
        self.cellusermodel=cellmodel;
        
    }];
}
//登出删除登录文件方法


@end
