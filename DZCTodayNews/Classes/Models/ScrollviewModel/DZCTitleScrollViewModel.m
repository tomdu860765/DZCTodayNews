//
//  DZCTitleScrollViewModel.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/10.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCTitleScrollViewModel.h"
#import "YYModel.h"

@implementation DZCTitleScrollViewModel


- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
@implementation dataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DZCTitleScrollViewModel class]};
    
}
- (NSString *)description
{
    return [self yy_modelDescription];
}

@end

