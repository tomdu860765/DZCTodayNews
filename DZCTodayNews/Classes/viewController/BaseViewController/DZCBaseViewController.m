//
//  DZCBaseViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCBaseViewController.h"
#import "DZCMainViewController.h"

@interface DZCBaseViewController ()
@property (nonatomic,strong)NSArray *barItems;
@end

@implementation DZCBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self CreatTabBarItem];
 
}

///创建tabbar导航控制器
-(void)CreatTabBarItem{
    
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"TabBarItem.plist" ofType:nil];
    NSArray *arrayDict=[NSArray arrayWithContentsOfFile:bundlePath];
    
    NSMutableArray *controllers = NSMutableArray.array;
    for (NSDictionary *dictKeyname in arrayDict) {
        
        id clz = NSClassFromString(dictKeyname[@"ViewController"]);
        id classvc= [[clz alloc ]init];
        if ([classvc isKindOfClass:[DZCMainViewController class]]) {
            DZCMainViewController *vc = (DZCMainViewController *)classvc;
            UIImage *image = [UIImage imageNamed:dictKeyname[@"Image"]];
            UIImage *hlimage = [UIImage imageNamed:dictKeyname[@"HLpic"]];
            NSString *title = dictKeyname[@"title"];
            vc.tabBarItem = [vc.tabBarItem initWithTitle:title image:image selectedImage:hlimage];
            [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor,
                                                    NSFontAttributeName:[UIFont systemFontOfSize:(16)]} forState:UIControlStateSelected];
            [controllers addObject:vc];
  
        
    };
        
        self.viewControllers = controllers;
  
       
        
    };

}



@end

