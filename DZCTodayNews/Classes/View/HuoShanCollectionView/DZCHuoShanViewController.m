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
@interface DZCHuoShanViewController ()
@property(nonatomic,strong)NSMutableArray *videoarray;
@end

@implementation DZCHuoShanViewController

static NSString * const reuseIdentifier = @"huoshancell";


-(void)setVideoarray:(NSMutableArray *)videoarray{
    _videoarray=videoarray;

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
    
    [DZCNetsTools netWorkWithHuoShanVideo:@"123" Complitionblock:^(NSArray * array) {
        
        NSMutableArray *marray=NSMutableArray.array;
        [array enumerateObjectsUsingBlock:^(DZCMainNewsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.ishas_video) {
              
                [marray addObject:model];
            }
        }];
        self.videoarray=marray;
        
    }];
  
    
    
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




@end
