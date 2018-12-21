//
//  AppDelegate.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "AppDelegate.h"
#import "DZCBaseViewController.h"
#import "DZCNaviViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    DZCBaseViewController *baseVC = DZCBaseViewController.new;
    DZCNaviViewController *naviVC = [[DZCNaviViewController alloc]initWithRootViewController:baseVC];

    self.window.bounds=SCREENBOUNDS;
    self.window.rootViewController = naviVC;
    [self Signinviewcontroller];
    [self.window makeKeyAndVisible];
    
    return YES;
}
//判断是否登录
-(void)Signinviewcontroller{
    //获取文件路径
    NSString *filenamestr=[DocumentpathString stringByAppendingPathComponent:@"weibojson"];
    //文件转二进制
    NSData *jsondata=[NSData dataWithContentsOfFile:filenamestr];
    
    if (!jsondata) {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"usersign"];
        NSLog(@"并没有登录文件");
        return;
    }
    //文件转字典
   NSDictionary *dictjson=[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    if ([dictjson valueForKey:@"access_token"]) {
        NSLog(@"%@",dictjson[@"access_token"]);
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"usersign"];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
