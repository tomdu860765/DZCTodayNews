//
//  DZCWeitoutiaoModel.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/29.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCWeitoutiaoModel.h"

@implementation DZCWeitoutiaoModel

-(NSString*)description{
    
    return [DZCWeitoutiaoModel yy_modelDescription];
}

+(NSDictionary*)modelContainerPropertyGenericClass{
    
    return @{@"origin_thread":[DZCRepostModel class],
             @"group":[DZCGroupModel class]};
}




@end
