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
#import "DZCNetsTools.h"
NS_ASSUME_NONNULL_BEGIN

@interface DZCHuoShanCell : UICollectionViewCell
//视频数据模型
@property(strong,nonatomic)DZCMainNewsModel *huoshanmodel;
//祝控制器
@property(strong,nonatomic)DZCHuoShanViewController *huoshanviewcontroller;


@end

NS_ASSUME_NONNULL_END
