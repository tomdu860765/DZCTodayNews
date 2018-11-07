//
//  DZCBaseViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCBaseViewController.h"
#import "DZCMainViewController.h"
#import "DZCMainCollectionVIew.h"
@interface DZCBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSArray *barItems;
@end

@implementation DZCBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self CreatTabBarItem];
}

///创建tabbar导航控制器
-(void)CreatTabBarItem{
    
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"TabBarItem.plist" ofType:nil];
    NSArray *arrayDict=[NSArray arrayWithContentsOfFile:bundlePath];
    
    NSMutableArray *controllers = NSMutableArray.array;
    for (NSDictionary *dictKeyname in arrayDict) {
        
        id clz = NSClassFromString(dictKeyname[@"ViewController"]);
        id classvc= [[clz alloc ]init];
        if ([classvc isKindOfClass:[DZCMainViewController class]]) {
            DZCMainViewController *vc = (DZCMainViewController *)classvc;
            UIImage *image = [UIImage imageNamed:dictKeyname[@"Image"]];
            UIImage *hlimage = [UIImage imageNamed:dictKeyname[@"HLpic"]];
            NSString *title = dictKeyname[@"title"];
            vc.tabBarItem = [vc.tabBarItem initWithTitle:title image:image selectedImage:hlimage];
            [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor,
                                                    NSFontAttributeName:[UIFont systemFontOfSize:(16)]} forState:UIControlStateSelected];
            [controllers addObject:vc];
            
        };
        
        self.viewControllers = controllers;
  
        [self.viewControllers.firstObject.view addSubview:[self SetupupCollectionview]];
    };

}
//添加collectionview到基类视图
-(DZCMainCollectionVIew  *)SetupupCollectionview{
    UICollectionViewFlowLayout *viewlayout = [[UICollectionViewFlowLayout alloc]init];

    DZCMainCollectionVIew *collectionview=[[DZCMainCollectionVIew alloc]initWithFrame:SCREENBOUNDS collectionViewLayout:viewlayout];
    
    collectionview.backgroundColor = UIColor.blueColor;
    collectionview.bounces=NO;
    collectionview.pagingEnabled = YES;
    collectionview.showsHorizontalScrollIndicator=YES;
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    collectionview.delegate = self;
    collectionview.dataSource = self;
    collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentScrollableAxes;
    return collectionview;
    
}




///FIXME等待网络模型跟进修改数据源方法
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UICollectionViewCell alloc]init];
    }

    return cell;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{

    
 
}



@end

