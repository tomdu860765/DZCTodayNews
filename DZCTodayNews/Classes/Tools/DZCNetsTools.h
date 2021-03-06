//
//  DZCNetsTools.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCNewsNetWorkTools.h"

NS_ASSUME_NONNULL_BEGIN



@interface DZCNetsTools : DZCNewsNetWorkTools

///请求网络新闻模型方法
+(void)NetworkMainNews:(void(^)(NSArray*))callback;
///请求网络滚动视图模型方法
+(void)ScrollviewSttitle:(void(^)(NSArray*,NSArray*))finishblock;
///刷新热点新闻
+(void)NetworHotNews:(void(^)(NSArray*))callback;
///视频网络请求
+(void)NetworVideo:(NSString*)Videoidstring finishBlock:(void(^)(NSString*))callback;
///西瓜视频网络请求
+(void)netWorkForXiGuaVideo:(void(^)(NSArray*))finishBlock;
///西瓜视频网络详情请求
+(void)netWorkForXiGuaVideoWithModel:(void(^)(id))Completionblock WithControllerString:(NSString*)ControllerString;
///分类新闻网络请求
+(void)basetableviewNetworHotNews:(void(^)(NSArray*))callback wihtViewControllerString:(NSString*)String;
///微头条网络请求
+(void)netWrokWithWeitoutiao:(void(^)(NSArray*))Complition;
///火山小视频请求链接
+(void)netWorkWithHuoShanVideo:(NSString*)viewcontrollerString Complitionblock:(void(^)(NSArray*))Complition;
///获取accessoken微博登录网络授权请求
+(void)WeibologinNetwork:(NSString*)codestring ComplitionBlock:(void(^)(id,id))Finishcallback;
///获取登录个人信息
+(void)WeiboUserinfo:(NSString*)tokenstring uidstring:(NSString*)uid FinishBlock:(void(^)(id))userinfoblock;

@end

NS_ASSUME_NONNULL_END
