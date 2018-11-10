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
#import "DZCRereshControl.h"
@interface DZCHomeViewVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *naviScrollview;
@property(nonatomic,strong)UITableView *newsTableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
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
//FIXME模拟数据源方法
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=NSMutableArray.array;
    }

    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addMainScrollview];
    [self SetupupnaviScrollview];
    [self refreshloaddata];

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
    DZCRereshControl *rereshControl=DZCRereshControl.new;
    [rereshControl addRefreshControlheader:self.newsTableview vcblock:^{
        [self refreshloaddata];
        NSLog(@"上拉刷新");
    }];
    [rereshControl addfooterRefresh:self.newsTableview vcblock:^{
        [self refreshloaddata];
        NSLog(@"下拉刷新");
    }];
    
    [self.view addSubview:sv];
    [self.newsTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviScrollview.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(SCREENHEIGHT);
    }];
 
}

//FIXME,等带数据源改造tableview加载方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

//FIXME等待数据源改造
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"newscell"];
    cell.textLabel.text=self.dataArray[indexPath.row];
   
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newscell"];
    }
   
    return cell;
}
//FIXME刷新方法待用,注意数据是插入最前面
-(void)refreshloaddata{
    
    for (int i=0; i<15; i++) {
        NSString *string=[NSString localizedStringWithFormat:@"%d",i];
        [self.dataArray insertObject:string atIndex:0];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.newsTableview reloadData];
    });

    NSLog(@"载入数据");
}



@end
