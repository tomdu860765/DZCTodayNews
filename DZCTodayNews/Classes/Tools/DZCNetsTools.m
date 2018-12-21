//
//  DZCNetsTools.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCNetsTools.h"
#import "DZCTitleScrollViewModel.h"
#import "YYModel.h"
#import "DZCMainNewsModel.h"
#import "NSData+CRC32.h"
#import "DZCVideoModel.h"
#import "DZCXiGuaVideoModel.h"
#import "XiGuaModel.h"
#import "DZCWeitoutiaoModel.h"
#import "DZCWeiboUsermodel.h"
@implementation DZCNetsTools
///滚动标题视图模型网络请求
///
///*参数一 返回name数组
///*参数二 返回category数组
///*参数三 监听目标
///*参数四 回调错误

+(void)titlescrollView:(void(^)(NSArray *,NSArray *))isuccessBlock failure:(void(^)(void))isfailureBlock{
    NSString *string=@"article/category/get_subscribed/v9/?";
    NSMutableArray *marry=NSMutableArray.array;
    NSMutableArray *marraycategory=NSMutableArray.array;
    [DZCNewsNetWorkTools NetWorkManagerMethod:string selectWithmenthod:GET_METHOD withparame:@[] Complition:^(id  _Nonnull result, NSError * _Nonnull error) {
        if (!error) {
            dataModel *model=[dataModel yy_modelWithDictionary:result[@"data"] ];
            
            [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [marry addObject:[obj valueForKey:@"name"]];
                [marraycategory addObject:[obj valueForKey:@"category"]];
            }];
            isuccessBlock(marry.copy,marraycategory.copy);
        }else{
            NSLog(@"%@",error);
        }
    }];
    
}
///推荐新闻数据网络请求,该方法调用了两次网络请求,暂时弃用.
///
///*参数一 返回主页新闻数组
///*参数二 返回错误代码
+(void)MainNewsNetwork:(void(^)(NSArray*,NSError*))ComplitionBlock{
    
    NSString *string=@"api/news/feed/v64/?";
    
    
    [DZCNewsNetWorkTools NetWorkManagerMethod:string selectWithmenthod:GET_METHOD withparame:@[] Complition:^(id  _Nonnull result, NSError * _Nonnull error) {
        if (!error) {
            NSArray *array=(NSArray*)result[@"data"];
            NSMutableArray *marry=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
                if([model.title isEqualToString:@""]){
                    return ;
                }
                if (model) {
                    
                    [marry addObject:model];
                }
                
            }];
            ComplitionBlock(marry.copy,nil);
        }else{
             //发生错误返回空数组,并报错
            ComplitionBlock(@[],error);
            NSLog(@"%@",error);
        }
        
    }];
    
}
///主新闻界面请求方法
///
///*参数一 返回主页新闻数组
+(void)NetworkMainNews:(void(^)(NSArray*))callback{
    NSString *string=@"api/news/feed/v64/?";
    
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:string parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *array=(NSArray*)responseObject[@"data"];
            NSMutableArray *marry=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
                if([model.title isEqualToString:@""]){
                    return ;
                }
                if (model) {
                    
                    [marry addObject:model];
                    
                }
                
            }];
            callback(marry.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        //发生错误返回空数组,并报错
        callback(@[]);
    }
     ];}
///主新闻界面滚动视图请求方法
///
///*参数一 返回name数组
///*参数二 返回category数组
+(void)ScrollviewSttitle:(void(^)(NSArray*,NSArray*))finishblock{
    NSString *string=@"article/category/get_subscribed/v9/?";
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:string parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSMutableArray *marry=NSMutableArray.array;
     NSMutableArray *marraycategory=NSMutableArray.array;
            dataModel *model=[dataModel yy_modelWithDictionary:responseObject[@"data"] ];
            
            [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                [marry addObject:[obj valueForKey:@"name"]];
                [marraycategory addObject:[obj valueForKey:@"category"]];
            }];
        finishblock(marry.copy,marraycategory.copy);
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (error) {
        
       NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
                                                  
       NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
       }
          //发生错误返回空数组
          finishblock(@[],@[]);
         }
     ];
    
}
///主界面推荐新闻界面请求方法
///
///*参数一 返回分类新闻详细信息数组
+(void)NetworHotNews:(void(^)(NSArray*))callback{
    
    
    NSString *string=@"api/news/feed/v64/?";
    NSDictionary * dict=@{@"category":@"__all__"};
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:string parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *array=(NSArray*)responseObject[@"data"];
            NSMutableArray *marry=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
                
                if([model.title isEqualToString:@""]){
                    return ;
                }
                if (model) {
                    
                    [marry addObject:model];
                }
                
            }];
            callback(marry.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        //发生错误返回空数组,并报错
        callback(@[]);
    }
     ];
    
}


///获取video网络请求方法
///
/// 拼接字符串请务必一致否则会没有返回数据
///*参数一 传入videoid
///*参数二 返回为视频真实链接字符串
+(void)NetworVideo:(NSString*)Videoidstring finishBlock:(void(^)(NSString*))callback{

    int r=arc4random();
    NSString *video_id=Videoidstring;
    NSString *string=@"/video/urls/v/1/toutiao/mp4/";
    NSString *str=[@"?r=" stringByAppendingFormat:@"%@",@(r)];
    
    NSString *urlstr=[string stringByAppendingString:video_id];
    NSString *realstr=[urlstr stringByAppendingString:str];
    //把链接处理为二进制
    NSData *data = [realstr dataUsingEncoding:NSUTF8StringEncoding];
   //处理crc32验证
    UInt64  crc32=  data.getCRC32;
    if (crc32 <0) {
        crc32 += 0x100000000;
    }
   
    NSString *crc32str=[@"&s=" stringByAppendingFormat:@"%@",@(crc32)];
    
    NSString *requeststring=[realstr stringByAppendingString:crc32str];
    
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:requeststring parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
           
            if ([NSJSONSerialization isValidJSONObject:responseObject]) {
               
                DZCVideolistModel *model=[DZCVideolistModel yy_modelWithJSON:responseObject[@"data"]];
                NSDictionary *dict=[NSDictionary dictionaryWithDictionary:[model.video_list valueForKey:@"video_1"]];
                [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    if ([key isEqualToString:@"main_url"]) {
                        //编译base64
                        NSData *data = [[NSData alloc]initWithBase64EncodedString:obj options:NSDataBase64DecodingIgnoreUnknownCharacters];
                        NSString *realurl64=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        callback(realurl64);
                        *stop=YES;
                        return ;
                    }
                }];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
             //发生错误返回空字符串,并报错
            callback(@"");
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        
    }
     ];
    
}
///西瓜视频网络请求
///
///*参数一 返回一个标题数组

+(void)netWorkForXiGuaVideo:(void(^)(NSArray*))finishBlock{
    NSString *urlstring=@"https://api.apiopen.top/videoHomeTab";
    [[DZCNewsNetWorkTools NewsNetWorkDefualt]GET:urlstring parameters:@[] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array=[NSArray yy_modelArrayWithClass:[DZCXiGuaVideoModel class] json:[responseObject valueForKey:@"result"]];
        if (array) {
            finishBlock(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            
             //发生错误返回空数组,并报错
            finishBlock(@[]);
            NSHTTPURLResponse *response=(NSHTTPURLResponse*)task.response;
        
          NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
 
    }];

}
///西瓜视频网络详情请求
///
///*参数一 返回任意类型的对象
///*参数二 当前控制器的名称
+(void)netWorkForXiGuaVideoWithModel:(void(^)(id))Completionblock WithControllerString:(NSString*)ControllerString{
    NSString *urlstring=@"https://api.apiopen.top/videoCategoryDetails";
    NSString *budlestring=[[NSBundle mainBundle]pathForResource:@"XiGuaVIdeo.plist" ofType:nil];
    NSArray *arrayvideoVC=[[NSArray alloc]initWithContentsOfFile:budlestring];
   //寻找对应的id字符,发出网络请求
    [arrayvideoVC enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ControllerString isEqualToString:[obj valueForKey:@"Viewcontroller"]]) {
            NSDictionary *dictparmeter=@{@"id":[obj valueForKey:@"id"]};
           
            [[DZCNewsNetWorkTools NewsNetWorkDefualt]GET:urlstring parameters:dictparmeter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject) {
                    NSArray *modelarray=(NSArray*)[responseObject valueForKey:@"result"];
                    NSMutableArray *modelmarray=NSMutableArray.array;
                    [modelarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *dict=[obj valueForKeyPath:@"data.content"];
                        XiGuaModel *model=[XiGuaModel yy_modelWithJSON:[dict valueForKey:@"data"] ];
                       
                        [modelmarray addObject:model];
                        
                    }];
                    Completionblock(modelmarray.copy);
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSHTTPURLResponse *response=(NSHTTPURLResponse*)task.response;
                    
                    NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
                }
                //发生错误返回空数组,并报错
                Completionblock(@[]);
            }];
            *stop=YES;
            return;
        }
    }];
    
   
    
    
}
///主新闻界面请求方法
///
///*参数一 返回分类新闻详细信息数组
+(void)basetableviewNetworHotNews:(void(^)(NSArray*))callback wihtViewControllerString:(NSString*)String {
    NSString *stringurl=@"api/news/feed/v64/?";
    NSString *bundelstr=[[NSBundle mainBundle]pathForResource:@"HomeView.plist" ofType:nil];
    NSArray *basearray=[[NSArray alloc]initWithContentsOfFile:bundelstr];
    
    [basearray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([String isEqualToString:[obj valueForKey:@"viewcontroller"]]) {
    NSDictionary * dict=@{@"category":[obj valueForKey:@"category"]};

    [[DZCNewsNetWorkTools NewsNetWorkDefualt] GET:stringurl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            NSArray *array=(NSArray*)responseObject[@"data"];
            NSMutableArray *marray=NSMutableArray.array;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DZCMainNewsModel *model=[DZCMainNewsModel yy_modelWithJSON:obj[@"content"] ];
                
                if([[model.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
                    
                    return;
                }
                
                if (model) {
                    
                    [marray addObject:model];
                }
                
            }];
            callback(marray.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        callback(@[]);
    }
     ];
            *stop=YES;
            return;
        }
    }];
}

///微头条界面网络请求
///
///*参数一 返回分类新闻详细信息数组
+(void)netWrokWithWeitoutiao:(void(^)(NSArray*))Complition{
    
    NSString *urlstring=@"https://is.snssdk.com/dongtai/list/v15/?user_id=51025535398";
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt]GET:urlstring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
        NSArray *arraymodel=[NSArray yy_modelArrayWithClass:[DZCWeitoutiaoModel class] json:[responseObject valueForKeyPath:@"data.data"]];
            Complition(arraymodel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        //发生错误返回空数组,并报错
        Complition(@[]);
    }];
    
}


///火山小视频请求链接
///
///*参数一 火山视图控制器
///*参数二 返回json数组
+(void)netWorkWithHuoShanVideo:(NSString*)viewcontrollerString Complitionblock:(void(^)(NSArray*))Complition{
    NSMutableString *murlstring=NSMutableString.string;
    //判断视图控制器加载数据
    if ([viewcontrollerString isEqualToString:@"DZCHuoShanViewController"]) {
        
        [murlstring setString:@"api/news/feed/v7/?category=video"];
    }else{
        murlstring=[NSMutableString stringWithString:@"api/news/feed/v11/?category=video"];
        
    }
   
    [[DZCNewsNetWorkTools NewsNetWorkDefualt]GET:murlstring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            NSArray *huoshanmodel=[NSArray yy_modelArrayWithClass:[DZCMainNewsModel class] json:[responseObject valueForKey:@"data"]];
           
            Complition(huoshanmodel);
        }
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
        }
        Complition(@[]);
    }];
 
}
///获取accessoken微博登录网络授权请求
///
///*参数一 获取code字符串
///*参数二 返回json数组
+(void)WeibologinNetwork:(NSString*)codestring ComplitionBlock:(void(^)(id,id))Finishcallback{
    
    //获取请求链接
   NSString *weibostring= @"https://api.weibo.com/oauth2/access_token";
    //Post请求体拼写

    NSDictionary *parameters=@{@"client_id":clientid,@"client_secret":AppSecret,
                               @"grant_type":@"authorization_code",@"code":codestring,@"redirect_uri":redirect_uri};
    
  
    [[DZCNewsNetWorkTools NewsNetWorkDefualt]POST:weibostring parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //成功回调json,获取token
            NSString *token=[responseObject valueForKey:@"access_token"];
            NSString *uid=[responseObject valueForKey:@"uid"];
            //执行用户信息网络请求
            [DZCNetsTools WeiboUserinfo:token uidstring:uid  FinishBlock:^(id userinfo) {
                Finishcallback(responseObject,userinfo);
            }];
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
          
        }
    }];
    
    
}

+(void)WeiboUserinfo:(NSString*)tokenstring uidstring:(NSString*)uid FinishBlock:(void(^)(id))userinfoblock{
    
    NSString *urlstring=@"https://api.weibo.com/2/users/show.json";
    //access_token    true    string    采用OAuth授权方式为必填参数，OAuth授权后获得。
    NSDictionary *dictpara=@{@"access_token":tokenstring,@"uid":uid};
    
    [[DZCNewsNetWorkTools NewsNetWorkDefualt]GET:urlstring parameters:dictpara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
        //json转模型
        DZCWeiboUsermodel *usermodel=[DZCWeiboUsermodel yy_modelWithJSON:responseObject];
         //执行回调
        userinfoblock(usermodel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response ;
            
            NSLog(@"网络请求失败,错误为%@,错误码%ld",error,(long)response.statusCode);
            
        }
        
    }];
    
}





@end
