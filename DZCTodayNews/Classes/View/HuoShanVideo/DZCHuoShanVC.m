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

@interface DZCHuoShanVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)DZCHuoShanViewController *huoshanviewcontroller;
@property(nonatomic,strong)UIScrollView *huoshanMainscroolview;
@property(nonatomic,strong)DZCRecommendHuoShanController *recommendcontroller;
@property(nonatomic,strong)UISegmentedControl *SegmentedControl;
@end

@implementation DZCHuoShanVC
//延迟加载导航选择器
-(UISegmentedControl *)SegmentedControl{
    if (_SegmentedControl==nil) {
        NSArray *array=@[@"推荐",@"娱乐"];
        _SegmentedControl=[[UISegmentedControl alloc]initWithItems:array];
    }
    
    return _SegmentedControl;
}

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


//FiXME
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.huoshanMainscroolview.delegate=self;
    
    //添加滚动视图到主视图
    [self setHuoshanVideoMainscrollview];
    [self setchildViewcontroller];
    //设置标题
    [self Settitleview];
}

//加载视频滚动视图
-(void)setHuoshanVideoMainscrollview{
    
    self.huoshanMainscroolview.bounces=NO;
    self.huoshanMainscroolview.pagingEnabled=YES;
    self.huoshanMainscroolview.showsVerticalScrollIndicator=NO;
    self.huoshanMainscroolview.showsHorizontalScrollIndicator=NO;
    self.huoshanMainscroolview.contentSize=CGSizeMake(SCREENWIDTH*2, 0);
  
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
    
    
  
    [self.huoshanMainscroolview addSubview:self.huoshanviewcontroller.view];
    //推荐视图约束
    [self.huoshanviewcontroller.view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.huoshanMainscroolview.mas_top).offset(0);
        make.left.mas_equalTo(self.huoshanMainscroolview.mas_left).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.bottom.mas_offset(SCREENHEIGHT-TABBARHEIGHT*2);
        
    }];
    
    //娱乐视图约束
   
    [self.huoshanMainscroolview addSubview:self.recommendcontroller.view];
    [self.recommendcontroller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.huoshanMainscroolview.mas_top).offset(0);
        make.left.mas_equalTo(self.huoshanMainscroolview.mas_left).offset(SCREENWIDTH);
        make.width.mas_equalTo(SCREENWIDTH);
        make.bottom.mas_offset(SCREENHEIGHT-TABBARHEIGHT*2);
        
    }];
    
    
    
}

//设置为白色导航栏
-(void)viewWillAppear:(BOOL)animated{
    
   
    [self.tabBarController.navigationItem.titleView setHidden:NO];
   
}
//设置导航栏标题
-(void)Settitleview{
  
    
 self.SegmentedControl.frame=CGRectMake(0, 0, SCREENWIDTH*0.5, NAVIBARHEIGHT*0.5);
    
   self.SegmentedControl.selectedSegmentIndex=0;
    
    [self.SegmentedControl addTarget:self action:@selector(chooseview:) forControlEvents:UIControlEventValueChanged];
    
    self.tabBarController.navigationItem.titleView=self.SegmentedControl;
    
}
//选择控制器办法
-(void)chooseview:(UISegmentedControl*)selectcontrol{
    
    NSInteger idx=selectcontrol.selectedSegmentIndex;
    
    //移动滚动视图
    [self.huoshanMainscroolview setContentOffset:CGPointMake(SCREENWIDTH*idx, -(STATUSBARHEIGHT+NAVIBARHEIGHT)) animated:YES];
    
   
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//滚动停止使导航控件高亮
    NSInteger index=scrollView.contentOffset.x/SCREENWIDTH;
    
    self.SegmentedControl.selectedSegmentIndex=index;
    
}



//还原导航栏颜色
-(void)viewWillDisappear:(BOOL)animated{
    
   
    //移除标题
    [self.tabBarController.navigationItem.titleView setHidden:YES];
}

@end
