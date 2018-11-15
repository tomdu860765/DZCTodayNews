//
//  DZCHomeViewVC.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHomeViewVC.h"
#import "DZCMainCollectionVIew.h"

#import "Masonry.h"
#import "DZCRereshControl.h"


#import "DZCNetsTools.h"
#import "DZCMainNewsModel.h"
#import "DZCTopNewsCell.h"
#import "DZCSinglePicCell.h"

#import "DZCBaseTableViewController.h"
@interface DZCHomeViewVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)NSArray *tableviews;
@property(nonatomic,strong)UITableView *newsTableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSArray *svdataArray,*svcategoryArray;
@property(nonatomic,strong)UITableView *hotnewsTableview;
@property(nonatomic,strong)UIButton *btnmark;

@end


@implementation DZCHomeViewVC



//网络数据源获取方法

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray=dataArray;
    DZCBaseTableViewController *vc=[[DZCBaseTableViewController alloc]initWithStyle:UITableViewStylePlain];
  
    [self.mainScrollview addSubview:vc.view];
    [self.newsTableview reloadData];
    [self.hotnewsTableview reloadData];
    //[self othersvnewstablewview];
    //[DZCMainNewsTableView addcategoryNewstableview:dataArray controller:self];
}

//载入网络模型添加滚动按钮
-(void)setSvdataArray:(NSArray *)svdataArray{
    
    _svdataArray=svdataArray;
    
    [self scrollViewbtn:self.svdataArray];
    
    
   
   
}
//主滚动视图网络模型载入
-(void)setSvcategoryArray:(NSArray *)svcategoryArray{
    _svcategoryArray=svcategoryArray;
   
    NSLog(@"加载模型");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
   
   
    [self.view addSubview:self.mainScrollview];
   [self.view addSubview:self.naviScrollview];
   //[self makeConstraintsWithView];
    [self addrefreshWithview];
    [self networkForMainview];
    //新的tableview添加到主滚动视图上面
    [self.mainScrollview addSubview:self.hotnewsTableview];
    
   
    
}
//主视图的网络工具方法
-(void)networkForMainview{
    //滚动视图模型
    [DZCNetsTools ScrollviewSttitle:^(NSArray * arraymodel, NSArray * categoryArray) {
        self.svdataArray=arraymodel;
        self.svcategoryArray=categoryArray;
        
        self.mainScrollview.contentSize=CGSizeMake(categoryArray.count*SCREENWIDTH, 0);
      
        
    }];
    
    
    //主新闻模型
    [DZCNetsTools NetworkMainNews:^(NSArray * array) {
        if (array) {
        self.dataArray=[NSMutableArray arrayWithArray:array];


        }
  
    }];
 
}

//等带数据源改造tableview加载方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

//FIXME等待数据源改造
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"topnewsid";


    DZCMainNewsModel *model=self.dataArray[indexPath.row];
    if (model.middle_image.url) {
        DZCSinglePicCell *cell=[tableView dequeueReusableCellWithIdentifier:@"singlepiccell"];
        cell.model=model;

        return cell;
    }

    DZCTopNewsCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];

    cell.model=self.dataArray[indexPath.row];

    return cell;

}


//FIXME需要修改非x机型的约束
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
//添加刷新控件方法
-(void)addrefreshWithview{
   
    DZCRereshControl *rereshControl=DZCRereshControl.new;
    
    [rereshControl addRefreshControlheader:self.newsTableview vcblock:^{
         [self refreshloaddata];
     
        NSLog(@"上拉刷新");
    }];
 
    [rereshControl addRefreshControlheader:self.newsTableview vcblock:^{
        [self refreshloaddata];
        NSLog(@"上拉刷新");
    }];
    
    
}

//向下刷新方法,注意数据是插入最前面
-(void)refreshloaddata{
    
    [DZCNetsTools NetworkMainNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.dataArray insertObject:obj atIndex:0];
                
            }];
            [self.newsTableview reloadData];
        }
    }];
    
}
//向上拉刷新数据
-(void)pullrefreshloaddata{
    [DZCNetsTools NetworkMainNews:^(NSArray * newsmodel)  {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.dataArray addObject:obj];
            }];
            [self.newsTableview reloadData];
        }
        
    }];
}


//FIXME导航栏更换频道方法
-(void)changeChanle:(UIButton *)sender{
    if (sender==self.btnmark) {
        return;
    }
    NSLog(@"更换频道");
    sender.selected=YES;
    self.btnmark.selected=NO;
    self.btnmark=sender;
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //向横滚动有效
    if (scrollView.contentOffset.x>0) {

    [DZCNetsTools NetworHotNews:^(NSArray * array) {
        //移除旧有的数组
        [self.dataArray removeAllObjects];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //新数据导入数组
            [self.dataArray addObject:obj];
        }];
        //重新刷写表格
        [self.hotnewsTableview reloadData];
    }];
    NSLog(@"拖动完毕");
    }
}

@end
