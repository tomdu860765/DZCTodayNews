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


@end

@implementation DZCMineTableViewController



- (IBAction)signoutaction:(UIButton *)sender {

    
    //载入新视图
    //[self.view addSubview:self.tableviewcontroller.view];

    [self delesigninfile];
    
    
}
//删除文件方法
-(void)delesigninfile{
    //判断是否含有登录文件并删除登录文件
    NSString *filepath=[DocumentpathString stringByAppendingPathComponent:@"weibojson"];
    
    if ([[NSFileManager defaultManager]isDeletableFileAtPath:filepath]) {
        
        [[NSFileManager defaultManager]removeItemAtPath:filepath error:nil];
        NSLog(@"登录文件已经删除");
        
    }
    //滚到登录视图
    
    if ([self.view.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *sv=(UIScrollView*)self.view.superview;
        
        [sv setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
 
}




-(void)setCellusermodel:(DZCWeiboUsermodel *)cellusermodel{
    _cellusermodel=cellusermodel;
    
    self.namelabel.text=cellusermodel.screen_name;
    
    
    self.deataillabel.text=cellusermodel.userdescription;
    
    [self.signimageview ImageviewcutRound:self.signimageview withurl:cellusermodel.avatar_large];
    
     //刷新视图
    [self.tableView reloadData];
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

    [self.view.window.rootViewController presentViewController:loginvc animated:YES completion:nil];
    
    
    //回调block 重新加载页面
    
    loginvc.vcblock = ^(id model) {
        
        //注册并显示cell
        self.cellusermodel=model;
        
        if ([self.view.superview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *sv=(UIScrollView*)self.view.superview;
            
            [sv setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
        }
       
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


@end
