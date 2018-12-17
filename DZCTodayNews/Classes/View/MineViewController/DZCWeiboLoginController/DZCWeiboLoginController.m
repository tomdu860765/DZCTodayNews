//
//  DZCWeiboLoginController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/17.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCWeiboLoginController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "DZCNetsTools.h"
@interface DZCWeiboLoginController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *wkweibologinview;
@end

@implementation DZCWeiboLoginController

//延迟加载登录页面
-(WKWebView*)wkweibologinview{
    if (_wkweibologinview==nil) {
        _wkweibologinview=WKWebView.new;
    }
    
    return _wkweibologinview;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLoginView];
    
    self.wkweibologinview.navigationDelegate=self;
    
    [self Setleftbackbtn];
}


///加载登录视图
-(void)setupLoginView{
    //拼接网络链接
    NSString *weibostring= @"https://open.weibo.cn/oauth2/authorize?client_id=804208746&redirect_uri=https://www.163.com&display=mobile";

    //添加视图
    [self.view addSubview:self.wkweibologinview];
    //添加约束
    [self.wkweibologinview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height);
    }];

    
    NSURL *url=[NSURL URLWithString:weibostring];
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:10];
    
    [self.wkweibologinview loadRequest:request];
    
    
}
///设置左边返回按钮
-(void)Setleftbackbtn{
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(getbacklogin)];
    
    self.navigationItem.leftBarButtonItem=backitem;
}
-(void)getbacklogin{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}


//载入完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    [SVProgressHUD dismiss];
    
}
//开始载入
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{

[SVProgressHUD showWithStatus:@"网页加载中"];

}
//处理网络请求回调
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //链接转成字符形式
    NSString *urlstring=[navigationAction.request.URL absoluteString];
    if ([urlstring hasPrefix:redirect_uri]) {
      
        //回调获取登录用code并执行网络链接请求
        [DZCNetsTools WeibologinNetwork:[self UrlstringSubstring:urlstring] ComplitionBlock:^(id tokenstring) {
            if (tokenstring) {

            //获取tooken之后
           NSString *token=[tokenstring valueForKey:@"access_token"];
            //保存token
            
            //保存登录状态
          
            }
        }];
        
        //不跳转页面
        decisionHandler(WKNavigationActionPolicyCancel);
        //并退出登录页面
        [self getbacklogin];
    }else{
        
        //转回调页面
        decisionHandler(WKNavigationActionPolicyAllow);
    }

}

///使用正则表达式截取字符串
-(NSString*)UrlstringSubstring:(NSString*)urlstring{
    
    
    NSString *pattern=@"(.*?)=.*?";
    //匹配表达式
    NSRegularExpression *regular=[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    //获取表达式长度和字符串位置
    NSTextCheckingResult *result = [regular firstMatchInString:urlstring options:0 range:NSMakeRange(0, urlstring.length)];
    
    
    
    //取出字符串
    NSRange resultRange = [result rangeAtIndex:1];
    
    //截取字符串
    NSString *resultstr=[urlstring substringWithRange:resultRange];
    
    
    return  [urlstring substringFromIndex:resultstr.length+1];

}

@end
