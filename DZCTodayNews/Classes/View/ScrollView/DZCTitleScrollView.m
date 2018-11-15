//
//  DZCTitleScrollView.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/11.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCTitleScrollView.h"
#import "Masonry.h"
#import "DZCMainViewController.h"

@implementation DZCTitleScrollView


///FIXME滚动视图的滚动范围受数据源方法影响需要修改,并修改添加按钮
-(UIScrollView *)SetupupnaviScrollview:(DZCMainViewController *)viewcontroller {
    
    UIScrollView  *scrollview=[[UIScrollView alloc]init];
   
    scrollview.backgroundColor=UIColor.whiteColor;
    scrollview.userInteractionEnabled=YES;
    scrollview.bounces=NO;
    scrollview.showsHorizontalScrollIndicator=NO;
    return scrollview;
    
}





@end
