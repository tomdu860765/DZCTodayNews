//
//  DZCMineViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMineViewController.h"
#import "DZCMineTableViewController.h"

@interface DZCMineViewController ()
@property(nonatomic,strong)DZCMineTableViewController *minetableviewvc;
@end

@implementation DZCMineViewController
-(DZCMineTableViewController*)minetableviewvc{
    if (_minetableviewvc==nil) {
        UIStoryboard *minesb=[UIStoryboard storyboardWithName:@"DZCMineViewController" bundle:nil];
        //判断是否登录载入不同页面控制器
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"usersign"]) {
            _minetableviewvc =[minesb instantiateViewControllerWithIdentifier:@"SinginViewcontroller"];
        }else{
            
            _minetableviewvc =[minesb instantiateViewControllerWithIdentifier:@"minestoryborad"];}
    }
    
    return _minetableviewvc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //未登录
    [self setupMinetableview];
    
}
//添加登录表视图控制器
-(void)setupMinetableview{
    [self addChildViewController:self.minetableviewvc];

    [self.view addSubview:self.minetableviewvc.view];

    
}


@end
