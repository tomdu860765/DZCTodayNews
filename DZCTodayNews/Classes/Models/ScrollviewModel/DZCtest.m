//
//  DZCtest.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCtest.h"
#import "YYModel.h"
@implementation DZCtest
- (NSString *)description
{
    return [DZCtest yy_modelDescription];
}
@end
@implementation data

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DZCtest class]};
    
}

- (NSString *)description
{
    return [data yy_modelDescription];
}

@end
