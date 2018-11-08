//
//  DZCHomeViewVC.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHomeViewVC.h"
#import "DZCMainCollectionVIew.h"
#import "DZCMainNewsTableView.h"
#import "Masonry.h"

@interface DZCHomeViewVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *naviScrollview;
@property(nonatomic,strong)UITableView *newsTableview;
@end

@implementation DZCHomeViewVC
///延迟加载滚动栏
-(UIScrollView *)naviScrollview{
    if (_naviScrollview==nil) {
        
        _naviScrollview=self.SetupupnaviScrollview;
        
    }
    return _naviScrollview;
    
}
//延迟加载新闻tableview
-(UITableView *)newsTableview{
    
    if (!_newsTableview) {
        _newsTableview=[DZCMainNewsTableView SetupNewsTableview:self tableviewrect:SCREENBOUNDS];
    }
    
    
    return _newsTableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self addMainScrollview];
    [self SetupupnaviScrollview];
    
}

///FIXME滚动视图的滚动范围受数据源方法影响需要修改,并修改添加按钮
-(UIScrollView *)SetupupnaviScrollview{

    UIScrollView  *scrollview=[[UIScrollView alloc]init];
    scrollview.contentSize=CGSizeMake(SCREENWIDTH*5, 0);
    scrollview.backgroundColor=UIColor.redColor;
    [self.view addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(88);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left).offset(0);
    }];
    
   
    return scrollview;
    
}
//主视图滚动视图
-(void)addMainScrollview{
    UIScrollView *sv=[[UIScrollView alloc]initWithFrame:SCREENBOUNDS];
    sv.contentSize=CGSizeMake(SCREENWIDTH*5, 0);
    sv.backgroundColor = UIColor.greenColor;
    sv.pagingEnabled=YES;
    sv.bounces=false;
    sv.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentScrollableAxes;
    [sv addSubview:self.newsTableview];
  
    [self.view addSubview:sv];
    [self.newsTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviScrollview.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(SCREENHEIGHT);
    }];
 
}

//FIXME,等带数据源改造tableview加载方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

//FIXME等待数据源改造
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"newscell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newscell"];
    }
    return cell;
}


@end
