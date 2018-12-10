//
//  DZCHuoShanViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/5.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHuoShanViewController.h"
#import "DZCHuoShanCell.h"
#import "DZCHuoShanlayout.h"
#import "DZCNetsTools.h"
#import "DZCRereshControl.h"
#import "MJRefresh.h"
#import "Masonry.h"
@interface DZCHuoShanViewController ()
@property(nonatomic,strong)NSMutableArray *videoarray;
@end

@implementation DZCHuoShanViewController

static NSString * const reuseIdentifier = @"huoshancell";


-(void)setVideoarray:(NSMutableArray *)videoarray{
    _videoarray=videoarray;
    //重新刷新页面
    [self.collectionView reloadData];
    
   
}



-(instancetype)init{
    DZCHuoShanlayout *flowlayout=DZCHuoShanlayout.new;
    
    
    return [super initWithCollectionViewLayout:flowlayout];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib=[UINib nibWithNibName:@"HuoShanCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
   
    //执行网络方法
    
    [self networkWithcollectionview];
   
    //添加集合视图刷新控件
    [self collectionrRefearshcontroll];
    //调整控件偏移
    [self frameWithheaderandfooter];
    
    self.collectionView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
}
//刷新控件调整办法
-(void)frameWithheaderandfooter{
    for (UIView *v in self.collectionView.subviews) {
        if ([v isKindOfClass:[MJRefreshComponent class]]) {
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v.superview.mas_left).offset(0);
                make.width.mas_equalTo(SCREENWIDTH);
                make.height.mas_equalTo(54);
                make.top.equalTo(v.superview.mas_top).offset(-54);
            }];
        }
    }
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.videoarray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DZCMainNewsModel *model=self.videoarray[indexPath.item];
    
    DZCHuoShanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.huoshanmodel=model;
    
    return cell;
}
//添加刷新控件
-(void)collectionrRefearshcontroll{
    DZCRereshControl *refresh=DZCRereshControl.new;
    
    
    
    [refresh setupCollectionviewrefreshcontroll:self.collectionView refreshblock:^{
        NSLog(@"集合视图下拉刷新");
        [DZCNetsTools netWorkWithHuoShanVideo:NSStringFromClass([self class]) Complitionblock:^(NSArray * array) {
            if (!array) {
                return ;
            }
           
            [array enumerateObjectsUsingBlock:^(DZCMainNewsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.ishas_video) {
                    
                    [self.videoarray insertObject:model atIndex:0];
                }
                
            }];
            //刷新界面
            [self.collectionView reloadData];
            //重新布局界面
            [self.collectionView layoutIfNeeded];
  
        }];
        
        
    }];
    [refresh setupCollectionviewfootter:self.collectionView refreshblock:^{
        NSLog(@"集合视图上拉刷新");
      
        [DZCNetsTools netWorkWithHuoShanVideo:NSStringFromClass([self class]) Complitionblock:^(NSArray * array) {
            if (!array) {
                return ;
            }
            
            [array enumerateObjectsUsingBlock:^(DZCMainNewsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.ishas_video) {
                    
                    [self.videoarray addObject:model];
                }
                
            }];
           
            
            //刷新界面
            [self.collectionView reloadData];
            //重新布局界面
            [self.collectionView layoutIfNeeded];

        }];
        
    }];
    
}

//集合视图的网络请求
-(void)networkWithcollectionview{
    
    [DZCNetsTools netWorkWithHuoShanVideo:NSStringFromClass([self class]) Complitionblock:^(NSArray * array) {
        if (!array) {
            return ;
        }
        NSMutableArray *marray=NSMutableArray.array;
        [array enumerateObjectsUsingBlock:^(DZCMainNewsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.ishas_video) {
                
                [marray addObject:model];
            }
        }];
        self.videoarray=marray;
        
    }];
    //重新布局视图
    [self.collectionView layoutIfNeeded];
    
}


@end
