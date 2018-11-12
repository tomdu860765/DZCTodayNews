//
//  DZCNewsNetWorkTools.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/10.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZCNewsNetWorkTools : AFHTTPSessionManager
+(instancetype)NewsNetWorkDefualt;
+(void)titleScrollViewNetwork:(NSString *)Urlstring successblcok:(void(^)(NSArray *))issuccess failureblock:(void(^)(void))isfailure;
@end

NS_ASSUME_NONNULL_END
