//
//  UIImageView+DZCRoundImageView.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/30.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "UIImageView+DZCRoundImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+DZCImageround.h"
@implementation UIImageView (DZCRoundImageView)
-(void)ImageviewcutRound:(UIImageView*)imageview withurl:(NSString*)urlstring{
    NSURL *url=[[NSURL alloc]initWithString:urlstring];
    
    
    [imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"] options:0 progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //创建一个图片并剪切
        if (image) {
            
            
            UIImage *roundimage=[image CutRoundImageView:image];
            
            imageview.image=roundimage;}
        else{
            imageview.image=[UIImage imageNamed:@"user_default"];
        }
    }];
}

@end
