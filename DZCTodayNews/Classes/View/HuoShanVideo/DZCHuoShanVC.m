//
//  DZCHuoShanVC.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHuoShanVC.h"
#import "DZCHuoShanViewController.h"
#import "DZCNetsTools.h"
@interface DZCHuoShanVC ()
@property(nonatomic,strong)DZCHuoShanViewController *huoshanviewcontroller;

@end

@implementation DZCHuoShanVC

-(DZCHuoShanViewController*)huoshanviewcontroller{
    if (_huoshanviewcontroller==nil) {
       
        _huoshanviewcontroller=DZCHuoShanViewController.new;
    }
    
    return _huoshanviewcontroller;
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
 
    [self addChildViewController:self.huoshanviewcontroller];
    
    [self.view addSubview:self.huoshanviewcontroller.collectionView];
    
   
}



@end
