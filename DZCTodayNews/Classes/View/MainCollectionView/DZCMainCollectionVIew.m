//
//  DZCMainCollectionVIew.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/7.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCMainCollectionVIew.h"

@implementation DZCMainCollectionVIew


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *viewlayout = (UICollectionViewFlowLayout *)layout;
    viewlayout.itemSize=frame.size;
    viewlayout.minimumLineSpacing=0;
    viewlayout.minimumInteritemSpacing=0;
    viewlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    return [super initWithFrame:frame collectionViewLayout:viewlayout];
}


@end
