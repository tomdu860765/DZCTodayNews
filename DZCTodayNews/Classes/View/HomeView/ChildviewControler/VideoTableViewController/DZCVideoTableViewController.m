//
//  DZCVideoTableViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCVideoTableViewController.h"
#import "DZCRereshControl.h"
#import "DZCMainNewsModel.h"
#import "DZCTopNewsCell.h"
#import "DZCSinglePicCell.h"
#import "DZCNetsTools.h"
#import "DZCMainnewsViewController.h"
#import "DZCVideoCell.h"


@interface DZCVideoTableViewController ()
@property(nonatomic,strong)NSMutableArray *MainVCarray;
@property(nonatomic,strong)DZCVideoCell *cellmark;
@property(nonatomic,assign)CGFloat rooloffsetY;

@end

@implementation DZCVideoTableViewController

-(void)setMainVCarray:(NSMutableArray *)MainVCarray{
    _MainVCarray=MainVCarray;
    
    [self.tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self networkForMainview];
    [self registerClass];
    [self addrefreshWithview:self.MainVCarray];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(responseNewsnetwork:)
                                                name:@"ScrollViewOffset" object:nil];
    
   
}
//接受通知并进行网络请求
-(void)responseNewsnetwork:(NSNotification *) noti{
    //对比控制器名称是否一致,一致则请求网络更新
    
    DZCMainnewsViewController *viewcontorller=(DZCMainnewsViewController*)noti.object;
    NSString *stringVC=NSStringFromClass([self class]);
    NSString *stringChildVC=NSStringFromClass([viewcontorller.childViewControllers[viewcontorller.btnmark.tag] class]);
    
    
    if ([stringVC isEqualToString:stringChildVC]) {
        
        
        [self refreshloaddata:self.MainVCarray];
        
        [self.tableView setContentOffset:CGPointMake(0, 0)];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.MainVCarray.count;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    [self setCellmarkHiddenForenddisplay];
 
    
}



///通过kvc,重新设置该cell的子控件隐藏和显示
-(void)setCellmarkHiddenForenddisplay{
    
    [self.cellmark setValue:@(1) forKeyPath:@"sharebtn.hidden" ];
    [self.cellmark setValue:@(1) forKeyPath:@"pyqbtn.hidden"];
    [self.cellmark setValue:@(1) forKeyPath:@"wechatbtn.hidden"];
    [self.cellmark setValue:@(0) forKeyPath:@"namelabel.hidden" ];
    [self.cellmark setValue:@(0) forKeyPath:@"playcountlabel.hidden"];
    [self.cellmark setValue:@(0) forKeyPath:@"videotitle.hidden"];
    //返回原来的子控件位置
    CGRect wecharect=  CGRectMake(4, 12, 28, 27);
    CGRect  pyqrect=  CGRectMake(8, 13, 26, 23);
   
    
    [self.cellmark setValue:@(wecharect) forKeyPath:@"wechatbtn.frame"];
    [self.cellmark setValue:@(pyqrect) forKeyPath:@"pyqbtn.frame"];
    [self.cellmark setValue:nil forKeyPath:@"btnmark"];
   
    [self.cellmark setValue:@(0) forKeyPath:@"playbtn.hidden"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopcellvideo" object:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    DZCVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"videocell" forIndexPath:indexPath];
    
    if (cell==nil) {
        cell=[[DZCVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"videocell"];
   }

        DZCMainNewsModel *model=self.MainVCarray[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=model;
       
        self.cellmark=cell;
    
       return cell;


}

-(void)registerClass{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
    UINib *uib=[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    
    [self.tableView registerNib:uib forCellReuseIdentifier:@"topnewsid"];
    
    UINib *singleuib=[UINib nibWithNibName:@"SinglePicCell" bundle:nil];
    
    [self.tableView registerNib:singleuib forCellReuseIdentifier:@"singlepiccell"];
    
    UINib *videocelluib=[UINib nibWithNibName:@"DZCVideoCell" bundle:nil];
    
    [self.tableView registerNib:videocelluib forCellReuseIdentifier:@"videocell"];
}
//按照分类加载新闻
-(void)networkForMainview{
    
    
    [DZCNetsTools NetworHotNews:^(NSArray * array) {
        if (array) {
            
            
            self.modelArray=[NSMutableArray arrayWithArray:array];
            self.MainVCarray=self.modelArray;}
    } WithKeyworks:@(3)];
    
    
    
}
//添加刷新控件方法
-(void)addrefreshWithview:(NSMutableArray *)marray{
    
    DZCRereshControl *rereshControl=DZCRereshControl.new;
    
    [rereshControl addRefreshControlheader:self.tableView vcblock:^{
        [self refreshloaddata:marray];
        
        NSLog(@"上拉刷新");
    }];
    
    [rereshControl addfooterRefresh:self.tableView vcblock:^{
        [self pullrefreshloaddata:marray];
        NSLog(@"上拉刷新");
    }];
    
    
}


//向下刷新方法,注意数据是插入最前面
-(void)refreshloaddata:(NSMutableArray*)marray{
    
    
    [DZCNetsTools NetworHotNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.MainVCarray insertObject:obj atIndex:0];
                
            }];
            
            [self.tableView reloadData];}
    } WithKeyworks:@(3)];
    
    
    
}
//向上拉刷新数据
-(void)pullrefreshloaddata:(NSMutableArray*)marray{
    
    [DZCNetsTools NetworHotNews:^(NSArray * newsmodel) {
        if (newsmodel) {
            [newsmodel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.MainVCarray addObject:obj];
            }];
            [self.tableView reloadData];}
    } WithKeyworks:@(3)];
    
    
}
//销毁通知中心
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
