//
//  DZCXiGuaVC.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCXiGuaVC.h"
#import "Masonry.h"
#import "DZCNetsTools.h"
#import "DZCXiGuaVideoModel.h"
#import "XiGuaBaseTableViewController.h"
#import "DZCXiGuaVideoCellTableViewCell.h"

@interface DZCXiGuaVC ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *titleScrollview;
@property(strong,nonatomic)UIScrollView *mainVideoScrollview;
@property(strong,nonatomic)NSArray *titleBtnarray;
@property(strong,nonatomic)UIButton *btnmark;
@property(strong,nonatomic)DZCXiGuaVideoCellTableViewCell *videocell;
@end

@implementation DZCXiGuaVC
//延迟加载滚动视图
-(UIScrollView*)titleScrollview{
    if (!_titleScrollview) {
        _titleScrollview=UIScrollView.new;
    }
    
    return _titleScrollview;
}

-(UIScrollView*)mainVideoScrollview{
    if (!_mainVideoScrollview) {
        _mainVideoScrollview=UIScrollView.new;
    }
    
    return _mainVideoScrollview;
}
//载入模型后添加导航栏按钮
-(void)setTitleBtnarray:(NSArray *)titleBtnarray{
    _titleBtnarray=titleBtnarray;
    
    [self addBtnForTitlescrollview:titleBtnarray];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitleScrollview];
    [self setupMainScrollview];
    [DZCNetsTools netWorkForXiGuaVideo:^(NSArray * titlearray) {
        self.titleBtnarray=titlearray;
    }];
    [self setupChildVideoViewController];
    self.mainVideoScrollview.delegate=self;
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(markcellplayer:)
                                                name:@"videocellplayer" object:nil];
}
-(void)markcellplayer:(NSNotification*)notification{
    
    self.videocell=notification.object;
}

//添加标题滚动视图
-(void)setupTitleScrollview{
    
    
    self.titleScrollview.showsVerticalScrollIndicator=NO;
    self.titleScrollview.showsHorizontalScrollIndicator=NO;
    self.titleScrollview.bounces=NO;
    self.titleScrollview.backgroundColor=UIColor.whiteColor;
    
    [self.view addSubview:self.titleScrollview];
    
    if (self.titleScrollview) {
        [self.titleScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.width.mas_equalTo(SCREENWIDTH);
            make.height.mas_equalTo(44);
            make.top.mas_equalTo(self.view.mas_top).offset(88);
        }];
    }
    
}

//添加主滚动视图
-(void)setupMainScrollview{
    self.mainVideoScrollview.pagingEnabled=YES;
    self.mainVideoScrollview.showsVerticalScrollIndicator=NO;
    self.mainVideoScrollview.showsHorizontalScrollIndicator=NO;
    self.mainVideoScrollview.bounces=NO;
    
    [self.view addSubview:self.mainVideoScrollview];
    if (self.titleScrollview) {
        [self.mainVideoScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.width.mas_equalTo(SCREENWIDTH);
            make.height.mas_equalTo(SCREENHEIGHT);
            make.top.equalTo(self.titleScrollview.mas_bottom).offset(0);
        }];
    }
    
}

//根据模型添加导航栏按钮
-(void)addBtnForTitlescrollview:(NSArray*)btnarray{
    CGFloat margin=15;
    CGFloat btnwidth=40;
    [btnarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DZCXiGuaVideoModel *model=(DZCXiGuaVideoModel *)obj;
        UIButton *titlebtn=[[UIButton alloc]initWithFrame:CGRectMake(margin+(btnwidth+margin)*idx, 0, btnwidth, btnwidth)];
        [titlebtn  setTitle:model.name forState:UIControlStateNormal];
        [titlebtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [titlebtn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        titlebtn.tag=idx;
        if (idx==0) {
            [titlebtn setSelected:YES];
            self.btnmark=titlebtn;
        }
        [self.titleScrollview addSubview:titlebtn];
        [titlebtn addTarget:self action:@selector(moveMainScrollview:) forControlEvents:UIControlEventTouchDown];
    }];
    self.mainVideoScrollview.contentSize=CGSizeMake(SCREENWIDTH*btnarray.count, 0);
    
    self.titleScrollview.contentSize=CGSizeMake(btnwidth*btnarray.count+(btnarray.count+1)*margin, 0);
    
}
//添加子控制器到主滚动视图
-(void)setupChildVideoViewController{
    NSString *budlestring=[[NSBundle mainBundle]pathForResource:@"XiGuaVIdeo.plist" ofType:nil];
    NSArray *arrayvideoVC=[[NSArray alloc]initWithContentsOfFile:budlestring];
    [arrayvideoVC enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id clz=NSClassFromString([obj valueForKey:@"Viewcontroller"]);
        id videocontroller= [[clz alloc]init];
        if (videocontroller) {
            XiGuaBaseTableViewController *tablevc=(XiGuaBaseTableViewController*)videocontroller;
            [self addChildViewController:videocontroller];
            self.mainVideoScrollview.delegate=tablevc;
            [self.mainVideoScrollview addSubview:tablevc.view];
            [tablevc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleScrollview.mas_top).offset(0);
                make.left.mas_equalTo(SCREENWIDTH*idx);
                make.height.mas_equalTo(SCREENHEIGHT);
                make.width.mas_equalTo(SCREENWIDTH);
            }];
        }
    }];
    
}
//滚动到哪个视图控制器加载网络模型
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
   
    NSInteger pagevc=scrollView.contentOffset.x/SCREENWIDTH;
    XiGuaBaseTableViewController *basevc=self.childViewControllers[pagevc];
    //执行网络请求
    [basevc netWorkForXiGuaVideoController];
    //执行滚动标题按钮高亮
    [self titlebtnmark:pagevc];
    //暂停播放
    [self.videocell setHiddenavplayer];
   
    
}
//按钮高亮方法
-(void)titlebtnmark:(NSInteger)btntag{
    if (self.btnmark.tag==btntag) {
        return;
    }
    self.btnmark.selected=NO;
    for (UIButton *btns in self.titleScrollview.subviews) {
        if (btns.tag==btntag) {
            [self titleScrollViewFormiddelPosition:btns];
            self.btnmark=btns;
            btns.selected=YES;
            break;}
    }
    
}
//按钮随着主滚动视图移动到中间
-(void)titleScrollViewFormiddelPosition:(UIButton*)button{
    
    CGFloat btnoffset=button.frame.origin.x-SCREENWIDTH*0.5;
    CGFloat maxoffset=self.titleScrollview.contentSize.width-SCREENWIDTH;
    if (btnoffset<0) {
        btnoffset=0;
    }else if (btnoffset>maxoffset)
    {
        btnoffset=maxoffset;
    }
    [self.titleScrollview setContentOffset:CGPointMake(btnoffset, 0) animated:YES];
 
}
//点击标题按钮方法
-(void)moveMainScrollview:(UIButton*)sender{

    [self.mainVideoScrollview setContentOffset:CGPointMake(SCREENWIDTH*sender.tag, 0) animated:YES];
    [self titlebtnmark:sender.tag];
   //点击后响应网络请求
    XiGuaBaseTableViewController *basevc=self.childViewControllers[sender.tag];
    [basevc netWorkForXiGuaVideoController];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
