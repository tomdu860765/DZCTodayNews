//
//  DZCMineViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMineViewController.h"
#import "DZCMineTableViewController.h"
#import "Masonry.h"
@interface DZCMineViewController ()
@property(nonatomic,strong)DZCMineTableViewController *minetableviewvc,*singincontroller;
@property(nonatomic,strong)UIScrollView *loginMianscrollview;
@end

@implementation DZCMineViewController
//未登录页面延迟加载
-(DZCMineTableViewController*)minetableviewvc{
    if (_minetableviewvc==nil) {
        UIStoryboard *minesb=[UIStoryboard storyboardWithName:@"DZCMineViewController" bundle:nil];
        //判断是否登录载入不同页面控制器
  
        _minetableviewvc =[minesb instantiateViewControllerWithIdentifier:@"minestoryborad"];}
    
    
    return _minetableviewvc;
}

//已登录页面延迟加载
-(DZCMineTableViewController*)singincontroller{
    if (_singincontroller==nil) {
        UIStoryboard *minesb=[UIStoryboard storyboardWithName:@"DZCMineViewController" bundle:nil];
        
        _singincontroller=[minesb instantiateViewControllerWithIdentifier:@"SinginViewcontroller"];
    }
    
    return _singincontroller;
}
//加载主滚动页面
-(UIScrollView*)loginMianscrollview{
    
    if (_loginMianscrollview==nil) {
        _loginMianscrollview=UIScrollView.new;
    }
    
    
    return _loginMianscrollview;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //设定滚动视图
   [self setupMainscrollview];
 
}


//设定滚动视图
-(void)setupMainscrollview{
    
    [self addChildViewController:self.singincontroller];
    
    [self addChildViewController:self.minetableviewvc];
    
    self.loginMianscrollview.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    //滚动视图范围
    self.loginMianscrollview.contentSize=CGSizeMake(SCREENWIDTH*2, SCREENHEIGHT);
    //设置不能滚动
    [self.loginMianscrollview setScrollEnabled:NO];
    
    [self.loginMianscrollview setBounces:NO];
    
    [self.loginMianscrollview setShowsVerticalScrollIndicator:NO];
    
   [self.loginMianscrollview setShowsHorizontalScrollIndicator:NO];
    
    [self.loginMianscrollview setBackgroundColor:[UIColor whiteColor]];
    
    //添加视图
    [self.view addSubview:self.loginMianscrollview];
    
    //设置主滚动视图约束
    [self.loginMianscrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(STATUSBARHEIGHT+NAVIBARHEIGHT).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(SCREENHEIGHT);
    }];
    
    //添加已经登录的view
    [self.loginMianscrollview addSubview:self.singincontroller.view];
    [self.singincontroller.view  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginMianscrollview.mas_left).offset(SCREENWIDTH);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(SCREENHEIGHT);
        
    }];
    
    //添加未登录的view
    [self.loginMianscrollview addSubview:self.minetableviewvc.view];
    [self.minetableviewvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginMianscrollview.mas_left).offset(0);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(SCREENHEIGHT);
        
    }];
  
    //根据登录状态显示哪一个视图
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"usersign"]) {
        [self.loginMianscrollview setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
    }else{
         [self.loginMianscrollview setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    
    
}
@end
