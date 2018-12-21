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
@property (strong, nonatomic) IBOutlet WKWebView *wkweibologinview;

@end

@implementation DZCWeiboLoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置webview
    [self setupLoginView];
    //设置代理
    self.wkweibologinview.navigationDelegate=self;
  
}


///加载登录视图
-(void)setupLoginView{
    //拼接网络链接
    NSString *weibostring= @"https://open.weibo.cn/oauth2/authorize?client_id=804208746&redirect_uri=https://www.163.com&display=mobile";
    

    
    
    NSURL *url=[NSURL URLWithString:weibostring];
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:10];
    
    [self.wkweibologinview loadRequest:request];
    
    
}

//重新弹出空出控制器方法
- (IBAction)getbackvc:(UIBarButtonItem *)sender {
    
    [SVProgressHUD dismiss];
    
    [self dismissViewControllerAnimated:YES completion:nil];
  
     
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
        [DZCNetsTools WeibologinNetwork:[self UrlstringSubstring:urlstring] ComplitionBlock:^(id tokenstring,id userinfo) {
            if (tokenstring) {
                
                //获取tooken之后,保存文件
                [self saveaccesstoken:tokenstring];
                
                 //获取token之后再发送请求获取用户信息模型
                 NSLog(@"%@",userinfo);
                //回调block
                if(self.vcblock){
                    self.vcblock(userinfo);
                }
            }
        }];
       
        
        //不跳转页面
        decisionHandler(WKNavigationActionPolicyCancel);
        

        //并退出登录页面
        [self dismissViewControllerAnimated:YES completion:^{
             [SVProgressHUD dismiss];
          
        }];
      

    }else{
        
        //跳转回调页面
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
    
    //返回处理后字符串
    return  [urlstring substringFromIndex:resultstr.length+1];
    
}

///保存token和token过时时间
-(void)saveaccesstoken:(id)json{
    //如果是json,保存到文件夹
    if ([NSJSONSerialization isValidJSONObject:json]) {
        //json转二进制
        NSData *jsondata=[NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
        //创建文件
        NSString *filenamestr=[DocumentpathString stringByAppendingPathComponent:@"weibojson"];
        //写入文件
        [jsondata writeToFile:filenamestr atomically:YES];
    
        NSLog(@"%@",filenamestr);
    }
    
}

@end
