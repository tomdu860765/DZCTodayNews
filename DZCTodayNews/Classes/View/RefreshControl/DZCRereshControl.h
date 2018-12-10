//
//  DZCRereshControl.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/9.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZCRereshControl : UIView
///添加头部刷新控件
///
///*参数一 添加头部刷新控件视图
///*参数二 执行刷新方法

-(void)addRefreshControlheader:(UITableView*)tableview vcblock:(void(^)(void))viewblock;
///添加尾部刷新控件
///
///*参数一 添加头部刷新控件视图
///*参数二 执行刷新方法

-(void)addfooterRefresh:(UITableView *)tableview vcblock:(void(^)(void))viewblock;

///添加集合视图头部刷新控件
///
///*参数一 集合视图
///*参数二 执行刷新方法
-(void)setupCollectionviewrefreshcontroll:(UICollectionView*)collectionview refreshblock:(void(^)(void))viewblock;

///添加集合视图头部刷新控件
///
///*参数一 集合视图
///*参数二 执行刷新方法
-(void)setupCollectionviewfootter:(UICollectionView*)collectionview refreshblock:(void(^)(void))viewblock;

@end

NS_ASSUME_NONNULL_END
