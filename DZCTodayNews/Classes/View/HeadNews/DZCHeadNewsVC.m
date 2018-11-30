//
//  DZCHeadNewsVC.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHeadNewsVC.h"
#import "DZCWeitoutiaoController.h"
@interface DZCHeadNewsVC ()
@property(nonatomic,strong)DZCWeitoutiaoController *weitoutiaotableview;
@end

@implementation DZCHeadNewsVC
-(DZCWeitoutiaoController*)weitoutiaotableview{
    if (_weitoutiaotableview==nil) {
        _weitoutiaotableview=DZCWeitoutiaoController.new;
    }
    
    return _weitoutiaotableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWeitoutiaoViewController];
}

//添加微头条子控制器
-(void)setupWeitoutiaoViewController{
    
    [self addChildViewController:self.weitoutiaotableview];
    [self.view addSubview:self.weitoutiaotableview.view];
    self.weitoutiaotableview.view.frame=self.view.bounds;
    
}




@end
