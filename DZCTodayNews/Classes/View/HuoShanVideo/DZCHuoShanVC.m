//
//  DZCHuoShanVC.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHuoShanVC.h"
#import "DZCHuoShanViewController.h"
#import "DZCRecommendHuoShanController.h"
#import "DZCNetsTools.h"
#import "Masonry.h"
@interface DZCHuoShanVC ()
@property(nonatomic,strong)DZCHuoShanViewController *huoshanviewcontroller;
@property(nonatomic,strong)UIScrollView *huoshanMainscroolview;
@property(nonatomic,strong)DZCRecommendHuoShanController *recommendcontroller;
@end

@implementation DZCHuoShanVC
//延迟加载滚动视图
-(UIScrollView*)huoshanMainscroolview{
    
    if (_huoshanMainscroolview==nil) {
        _huoshanMainscroolview=UIScrollView.new;
       
    }
    return _huoshanMainscroolview;
}
//加载推荐视频控制器
-(DZCRecommendHuoShanController*)recommendcontroller{
    if (_recommendcontroller==nil) {
        _recommendcontroller=DZCRecommendHuoShanController.new;
    }
    
    return _recommendcontroller;
}

//延迟加载视频控制器
-(DZCHuoShanViewController*)huoshanviewcontroller{
    if (_huoshanviewcontroller==nil) {
        
        _huoshanviewcontroller=DZCHuoShanViewController.new;
    }
    
    return _huoshanviewcontroller;
}
//还原导航栏颜色
-(void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    //移除标题
    [self.tabBarController.navigationItem.titleView removeFromSuperview];
}

//FiXME
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //添加滚动视图到主视图
    [self setHuoshanVideoMainscrollview];
    [self setchildViewcontroller];

}

//加载视频滚动视图
-(void)setHuoshanVideoMainscrollview{
    
    self.huoshanMainscroolview.bounces=NO;
    self.huoshanMainscroolview.pagingEnabled=YES;
    self.huoshanMainscroolview.showsVerticalScrollIndicator=NO;
    self.huoshanMainscroolview.showsHorizontalScrollIndicator=NO;
    self.huoshanMainscroolview.contentSize=CGSizeMake(SCREENWIDTH*2, 0);
   // self.huoshanMainscroolview.frame=CGRectMake(0, STATUSBARHEIGHT+NAVIBARHEIGHT, SCREENWIDTH, SCREENHEIGHT);
    self.huoshanMainscroolview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.huoshanMainscroolview];
    [self.huoshanMainscroolview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(SCREENHEIGHT);
    }];
 
}
//添加子视图控制器和view
-(void)setchildViewcontroller{
    
    //添加子视图控制器到主视图控制器
    [self addChildViewController:self.huoshanviewcontroller];
    [self addChildViewController:self.recommendcontroller];
    
    
    self.huoshanviewcontroller.view.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [self.huoshanMainscroolview addSubview:self.huoshanviewcontroller.view];
    self.recommendcontroller.view.frame=CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
    [self.huoshanMainscroolview addSubview:self.recommendcontroller.view];
    
}

//设置为白色导航栏
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //设置标题
    [self Settitleview];
   
}
//设置导航栏标题
-(void)Settitleview{
  
    NSArray *array=@[@"推荐",@"娱乐"];
    UISegmentedControl *segmencontrol=[[UISegmentedControl alloc]initWithItems:array];
    
    segmencontrol.frame=CGRectMake(0, 0, SCREENWIDTH*0.5, NAVIBARHEIGHT*0.5);
    
    self.tabBarController.navigationItem.titleView=segmencontrol;
   
}


@end
