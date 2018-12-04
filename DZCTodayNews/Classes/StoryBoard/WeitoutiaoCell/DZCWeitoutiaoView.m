//
//  DZCWeitoutiaoView.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/1.
//  Copyright © 2018 tomdu. All rights reserved.
//
#import "DZCWeitoutiaoView.h"
#import "DZCWeitoutiaoModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DZCWeitoutiaoView


//计算各种图片的高度,九宫格,单图,四图
-(CGFloat)ninepicturesViewHeight:(DZCWeitoutiaoModel*)modelpics {
   //判断用转发微头条模型或者非转发模型
    NSMutableArray *arraypic=NSMutableArray.new;
    if (!modelpics.is_repost) {
        //原创模型
        arraypic=[NSMutableArray arrayWithArray:modelpics.ugc_cut_image_list];
        
    }else{
        //转发模型
        arraypic=[NSMutableArray arrayWithArray:modelpics.origin_thread.ugc_cut_image_list];
    }
    
    CGFloat imageWidth=100;
    CGFloat imgaeHeight=imageWidth;
    //空隙
    CGFloat margin=(self.bounds.size.width-imageWidth*3)/4;
    __block CGFloat resulH=0;
    [arraypic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *ninepicView=UIImageView.new;
        //行
        NSInteger row=idx/3;
        //列
        NSInteger column=idx%3;
        
        
        CGFloat objwidth=[[obj valueForKey:@"width"] doubleValue];
        //坐标x
        CGFloat picx=margin+(margin+imageWidth)*column;
        //坐标y
        CGFloat picy=margin+(margin+imgaeHeight)*row;
        
        if (arraypic.count==1) {
            ninepicView.frame=CGRectMake(0, 0, objwidth/2, objwidth/2);
            resulH=objwidth/2;
            
        }else if(arraypic==nil)
        {
            
            resulH=0;
        }else
            
        {
            ninepicView.frame=CGRectMake(picx, picy, imageWidth, imgaeHeight);
            resulH=imageWidth*(row+1)+margin*(column+2);
        }
        
        [ninepicView sd_setImageWithURL:[obj valueForKey:@"url"] placeholderImage:[UIImage imageNamed:@"user_default"]];
        
        [self addSubview:ninepicView];
        
    }];
    return resulH;
    
    
}



@end
