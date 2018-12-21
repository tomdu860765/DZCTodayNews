//
//  DZCWeiboUsermodel.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/19.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCWeiboUsermodel.h"

@implementation DZCWeiboUsermodel

-(NSString*)description{
    
    
    return [DZCWeiboUsermodel yy_modelDescription];
    
}

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return@{@"userdescription":@"description"};
    
}


@end
