//
//  DZCMainCollectionVIew.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/7.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainCollectionVIew.h"
@interface DZCMainCollectionVIew()


@end
@implementation DZCMainCollectionVIew

///重写collectionview初始方法
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *viewlayout = (UICollectionViewFlowLayout *)layout;
    viewlayout.itemSize=frame.size;
    viewlayout.minimumLineSpacing=0;
    viewlayout.minimumInteritemSpacing=0;
    viewlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
    return [super initWithFrame:frame collectionViewLayout:viewlayout];
}


//FIXME添加collectionview到基类视图
-(DZCMainCollectionVIew  *)SetupupCollectionview{
    UICollectionViewFlowLayout *viewlayout = [[UICollectionViewFlowLayout alloc]init];
    
    DZCMainCollectionVIew *collectionview=[[DZCMainCollectionVIew alloc]initWithFrame:SCREENBOUNDS collectionViewLayout:viewlayout];
    
    collectionview.backgroundColor = UIColor.blueColor;
    collectionview.bounces=NO;
    collectionview.pagingEnabled = YES;
    collectionview.showsHorizontalScrollIndicator=YES;
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
//    collectionview.delegate = self;
//    collectionview.dataSource = self;
    collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentScrollableAxes;
    return collectionview;
    
}


///FIXME等待网络模型跟进修改数据源方法
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    //[cell.contentView addSubview:self.newsTableview];
    
    return cell;
}



@end
