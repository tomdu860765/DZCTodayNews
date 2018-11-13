//
//  DZCtest.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZCtest : NSObject
@property(nonatomic,copy)NSString *name,*category;
@end

@interface data : NSObject
@property(nonatomic,strong)DZCtest *data;

@end

@interface datawithdata : NSObject
@property(nonatomic,strong)data *data;

@end



NS_ASSUME_NONNULL_END
