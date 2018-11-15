//
//  DZCMainnewsViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainnewsViewController.h"
#import "DZCBaseTableViewController.h"
#import "DZCTitleScrollView.h"
#import "DZCNetsTools.h"
#import "Masonry.h"
@interface DZCMainnewsViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScrollview ;
@property(nonatomic,strong)UIScrollView *titleScrollview;
@property(nonatomic,strong)NSArray *vcarray ;
@property(nonatomic,strong)NSArray *titlemodelArray;


@end


@implementation DZCMainnewsViewController
//加载子视图控制器文件
-(NSArray*)vcarray{
    if (!_vcarray) {
        NSString *bundel=[[NSBundle mainBundle]pathForResource:@"childVC.plist" ofType:nil];
        NSArray *array=[NSArray arrayWithContentsOfFile:bundel];
        
        _vcarray=array;
    }
    
    return _vcarray;
}
//获取网络滚动视图数组
-(void)setTitlemodelArray:(NSArray *)titlemodelArray{
    _titlemodelArray=titlemodelArray;
    //设置滚动导航栏
    [self setTitlescrollview];
    _titleScrollview.delegate=self;
    //添加滚动按钮
    [self scrollViewbtn:titlemodelArray];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.whiteColor;
    //网络方法获取导航模型
    [DZCNetsTools ScrollviewSttitle:^(NSArray * arraymodel, NSArray * categoryArray) {
        //分类按钮和文字按钮
        self.titlemodelArray=arraymodel;
    }];
    //添加子视图
   [self SetupallChildVC];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(titleviewnoNotification:)
                                                name:@"offsetForMainscrollview" object:nil];
}
//添加主滚动视图
-(void)setmainscrollview{
    
    UIScrollView *sv=[[UIScrollView alloc]init];
    sv.frame=CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT);
    
    sv.backgroundColor=UIColor.whiteColor;
    [self.view addSubview:sv];
    sv.pagingEnabled=YES;
    sv.bounces=NO;
    _mainScrollview=sv;
}
//添加导航滚动视图
-(void)setTitlescrollview{
    
    UIScrollView  *scrollview=[[UIScrollView alloc]init];
    scrollview.backgroundColor=UIColor.whiteColor;
    scrollview.userInteractionEnabled=YES;
    scrollview.bounces=NO;
    scrollview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollview];
    _titleScrollview=scrollview;
    //添加约束
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(88);
        make.width.mas_equalTo(SCREENWIDTH);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left).offset(0);
        
    }];
}

//加载全部子视图控制器
-(void)SetupallChildVC{
    [self setmainscrollview];
   
    self.mainScrollview.contentSize=CGSizeMake(SCREENWIDTH*self.vcarray.count, 0);
    
    [self.vcarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            id clz=NSClassFromString(obj);
            id classvc= [[clz alloc]init];
            UITableViewController *tableviewvc= (DZCBaseTableViewController*)classvc;
          
            self.mainScrollview.delegate=tableviewvc;
            [self addChildViewController:tableviewvc];
            [self.mainScrollview addSubview:tableviewvc.view];
            [tableviewvc.view  mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_offset(SCREENWIDTH*idx);
                make.top.mas_offset(44);
                make.width.mas_equalTo(SCREENWIDTH);
                make.height.mas_equalTo(SCREENHEIGHT);
                
            }];
            
        }
        
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
        titleBtn.tag =idx;
        [titleBtn setTitle:obj forState:UIControlStateNormal];
        [titleBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [titleBtn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        if (idx==0) {
            
            titleBtn.selected=YES;
            self.btnmark=titleBtn;
        }
        
        [titleBtn setFrame:CGRectMake(margin*(idx+1)+btnWidth*idx,0,btnWidth, 34)];
        [titleBtn addTarget:self action:@selector(clickButtonWithOffset:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleScrollview addSubview:titleBtn];
        
    }];
    self.titleScrollview.contentSize = CGSizeMake(marry.count*btnWidth+(marry.count+1)*margin, 0);
    
}
//频道转换方法
-(void)clickButtonWithOffset:(UIButton *)button{
    
    [self changeChanle:button];
    [self moveScrollview];
    [self titleScrollViewFormiddelPosition:button ];
}

//按钮高亮显示方法
-(void)changeChanle:(UIButton *)sender{
    if (sender==self.btnmark) {
        return;
    }
  
    sender.selected=YES;
    self.btnmark.selected=NO;
    self.btnmark=sender;
   
}
//滚动视图位移并执行网络请求
-(void)moveScrollview{
   
    
    //视图移动
    [self.mainScrollview setContentOffset:CGPointMake(375*self.btnmark.tag, 0) animated:YES];
    //网络请求,发送网络请求通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ScrollViewOffset" object:nil];
    
}
//注销消息中心
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
 
}

//响应滚动标题栏
-(void)titleviewnoNotification:(NSNotification *)notification{
    
    //用通知获取滚动页面数,再响应按钮选择方法.
    DZCBaseTableViewController *vc=(DZCBaseTableViewController *)notification.object;
    
    UIButton *btn=self.titleScrollview.subviews[vc.page];
    
    [self changeChanle:btn];
    [self titleScrollViewFormiddelPosition:btn];
    
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

@end
