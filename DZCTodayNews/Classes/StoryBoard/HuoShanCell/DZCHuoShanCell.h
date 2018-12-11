//
//  DZCHuoShanCell.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/5.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZCMainNewsModel.h"
#import "DZCHuoShanViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DZCHuoShanCell : UICollectionViewCell

@property(strong,nonatomic)DZCMainNewsModel *huoshanmodel;
@property(strong,nonatomic)DZCHuoShanViewController *huoshanviewcontroller;
@end

NS_ASSUME_NONNULL_END
