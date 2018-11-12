//
//  DZCNetsTools.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCNewsNetWorkTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZCNetsTools : DZCNewsNetWorkTools
+(void)titlescrollView:(void(^)(NSArray *))isuccessBlock failure:(void(^)(void))isfailureBlock;
@end

NS_ASSUME_NONNULL_END
