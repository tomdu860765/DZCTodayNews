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
@interface DZCXiGuaVC ()
@property(strong,nonatomic)UIScrollView *titleScrollview;
@property(strong,nonatomic)UIScrollView *mainVideoScrollview;
@property(strong,nonatomic)NSArray *titleBtnarray;
@property(strong,nonatomic)UIButton *btnmark;
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
}
//添加标题滚动视图
-(void)setupTitleScrollview{
    
    self.titleScrollview.pagingEnabled=NO;
    self.titleScrollview.showsVerticalScrollIndicator=NO;
    self.titleScrollview.showsHorizontalScrollIndicator=NO;
    self.titleScrollview.bounces=NO;
    self.titleScrollview.backgroundColor=UIColor.whiteColor;
   // self.titleScrollview.contentSize=CGSizeMake(SCREENWIDTH*4, 0);
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
    self.mainVideoScrollview.pagingEnabled=NO;
    self.mainVideoScrollview.showsVerticalScrollIndicator=NO;
    self.mainVideoScrollview.showsHorizontalScrollIndicator=NO;
    self.mainVideoScrollview.bounces=NO;
    self.mainVideoScrollview.backgroundColor=UIColor.orangeColor;
    self.mainVideoScrollview.contentSize=CGSizeMake(SCREENWIDTH*5, 0);
   
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
        if (idx==0) {
            [titlebtn setSelected:YES];
            self.btnmark=titlebtn;
        }
        [self.titleScrollview addSubview:titlebtn];
    }];
    
    self.titleScrollview.contentSize=CGSizeMake(btnwidth*btnarray.count+(btnarray.count+1)*margin, 0);
  
}

@end
