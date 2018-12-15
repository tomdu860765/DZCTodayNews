//
//  DZCCellDeataleViewController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/20.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCCellDeataleViewController.h"
#import <WebKit/WebKit.h>
#import "UIButton+CustomerItem.h"
#import "DZCMainNewsModel.h"
#import "SVProgressHUD.h"
@interface DZCCellDeataleViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webview;
@property (weak, nonatomic) IBOutlet UIButton *getbackitem;
@property (weak, nonatomic) IBOutlet UIButton *commentbtn;
@property (weak, nonatomic) IBOutlet UIButton *islikebtn;
@property (weak, nonatomic) IBOutlet UIButton *repostbtn;
@property (weak, nonatomic) IBOutlet UITextField *commenttextfield;

@end

@implementation DZCCellDeataleViewController
//延迟加载控件
-(UIButton*)getbackitem{
    if (!_getbackitem) {
        _getbackitem=UIButton.new;
    }
    return _getbackitem;
}
-(UIButton*)commentbtn{
    if (!_commentbtn) {
        _commentbtn=UIButton.new;
    }
    return _commentbtn;
}
-(UIButton*)islikebtn{
    if (!_islikebtn) {
        _islikebtn=UIButton.new;
    }
    return _islikebtn;
}
-(UIButton*)repostbtn{
    if (!_repostbtn) {
        _repostbtn=UIButton.new;
    }
    return _repostbtn;
}
-(WKWebView*)webview{
    if (!_webview) {
        _webview=WKWebView.new;
        //以下代码适配大小
    }
    
    return _webview; 
}
-(UITextField*)commenttextfield{
    if (!_commenttextfield) {
        _commenttextfield=UITextField.new;
    }
    
    return _commenttextfield;
}
-(void)setDeatalModel:(DZCMainNewsModel *)deatalModel{
    _deatalModel=deatalModel;
   
    [self loadwebView:deatalModel];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webview.navigationDelegate=self;
}


//返回主视图
- (IBAction)getback:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"返回");
}

-(void)loadwebView:(DZCMainNewsModel*)model{
   
NSURL *url=[NSURL URLWithString:model.display_url];
NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
[self.webview loadRequest:request];
    
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [SVProgressHUD showWithStatus:@"网页加载中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}




@end
