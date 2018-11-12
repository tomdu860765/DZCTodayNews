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
#import "DZCNewsNetWorkTools.h"
#import "DZCTitleScrollView.h"
#import "DZCMainScrollView.h"
#import "DZCNetsTools.h"
@interface DZCHomeViewVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *naviScrollview;
@property(nonatomic,strong)UITableView *newsTableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSArray *svdataArray;
@property(nonatomic,strong)UIScrollView *mainScrollview;
@property(nonatomic,strong)UIButton *btnmark;
@end
//FIXME cell便是符
static NSString *cellid=@"cellid";
@implementation DZCHomeViewVC
///延迟加载滚动栏
-(UIScrollView *)naviScrollview{
    if (_naviScrollview==nil) {

        _naviScrollview=[DZCTitleScrollView.new SetupupnaviScrollview:self];

    }
    
    return _naviScrollview;

}
//延迟加载新闻tableview
-(UITableView *)newsTableview{
    
    if (!_newsTableview) {
        _newsTableview=[DZCMainNewsTableView SetupNewsTableview:self
                                                  tableviewrect:SCREENBOUNDS];
    }
    
    
    return _newsTableview;
}
//延迟加载主滚动视图
-(UIScrollView *)mainScrollview{
    if (!_mainScrollview) {
        _mainScrollview=[DZCMainScrollView addMainScrollview:self
                                                addTableview:self.newsTableview
                                              withScrollview:self.naviScrollview];
    }
    return _mainScrollview;
}

//FIXME模拟数据源方法
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=NSMutableArray.array;
    }

    return _dataArray;
}
//载入网络模型添加滚动按钮
-(void)setSvdataArray:(NSArray *)svdataArray{
    
    _svdataArray=svdataArray;
    
    [self scrollViewbtn:self.svdataArray];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [DZCNetsTools titlescrollView:^(NSArray * arraymodel) {
        self.svdataArray=arraymodel;
        NSLog(@"网络请求成功");
    } failure:^{
        NSLog(@"网络请求失败");
    }];
    
    [self.view addSubview:self.mainScrollview];
    [self.view addSubview:self.naviScrollview];
    [self makeConstraintsWithView];
    [self addrefreshWithview];
    [self refreshloaddata];

}




//FIXME,等带数据源改造tableview加载方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

//FIXME等待数据源改造
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    cell.textLabel.text=self.dataArray[indexPath.row];
   
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
   
    return cell;
}
//添加刷新控件方法
-(void)addrefreshWithview{
    
    DZCRereshControl *rereshControl=DZCRereshControl.new;
    [rereshControl addRefreshControlheader:self.newsTableview vcblock:^{
        [self refreshloaddata];
        NSLog(@"上拉刷新");
    }];
    [rereshControl addfooterRefresh:self.newsTableview vcblock:^{
        [self refreshloaddata];
        NSLog(@"下拉刷新");
    }];
    
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

}
-(void)makeConstraintsWithView{
    
    [self.naviScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(88);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left).offset(0);
    }];
    [self.newsTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviScrollview.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(SCREENHEIGHT);
    }];
    
}
//添加滚动视图按钮,移除首个元素“关注”
-(void)scrollViewbtn:(NSArray *)array{
    NSMutableArray *marry= [array mutableCopy];
    [marry removeObjectAtIndex:0];
    CGFloat margin=15;
    CGFloat btnWidth=40;
    [marry.copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIButton *titleBtn=UIButton.new;
       
        [titleBtn setTitle:obj forState:UIControlStateNormal];
        [titleBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [titleBtn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        if (idx==0) {
            
            titleBtn.selected=YES;
            self.btnmark=titleBtn;
        }

        [titleBtn setFrame:CGRectMake(margin*(idx+1)+btnWidth*idx,0,btnWidth, 34)];
        [titleBtn addTarget:self action:@selector(changeChanle:) forControlEvents:UIControlEventTouchUpInside];
        [self.naviScrollview addSubview:titleBtn];
        
    }];
    self.naviScrollview.contentSize = CGSizeMake(marry.count*btnWidth+(marry.count+1)*margin, 0);
    

}
//导航栏更换频道方法
-(void)changeChanle:(UIButton *)sender{
    NSLog(@"更换频道");
    sender.selected=YES;
    self.btnmark.selected=NO;
    self.btnmark=sender;
    
}

@end
