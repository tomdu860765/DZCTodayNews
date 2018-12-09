//
//  DZCHuoShanlayout.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHuoShanlayout.h"

@interface DZCHuoShanlayout()
@property(nonatomic,strong)NSMutableArray *attributesarray;

@end

@implementation DZCHuoShanlayout
-(NSMutableArray*)attributesarray{
    if (_attributesarray==nil) {
        _attributesarray=NSMutableArray.array;
    }
    
    return _attributesarray;
}

- (void)prepareLayout{
    [super prepareLayout];
    
  
    [self layouthuoshan];
   
}


//视图布局处理
-(void)layouthuoshan{
    //布局之前清理之前的元素
    [self.attributesarray removeAllObjects];
    
    //有多少个item需要布局,布局组数只有一组
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    

    for (int i=0; i<count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes  layoutAttributesForCellWithIndexPath:indexPath];
        //行
        NSInteger row=i/2;
        
        //列
        NSInteger column=i%2;
        //间隔
        CGFloat magin=3;
        
        CGFloat itemX=(SCREENWIDTH*0.5+magin)*column;
        
        CGFloat itemY=(200+magin)*row;
        
      
        
        attributes.frame=CGRectMake(itemX, itemY, SCREENWIDTH*0.5,200);
        [self.attributesarray addObject:attributes];
    }
   
    
}



//每个cell绑定布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{


    return self.attributesarray;

}


//设定滚动的区域大小
- (CGSize)collectionViewContentSize{
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger row=count/2;
    
    CGFloat magin=3;
    
    return CGSizeMake(0, row*SCREENHEIGHT*0.5+(row-1)*magin);
}


@end
