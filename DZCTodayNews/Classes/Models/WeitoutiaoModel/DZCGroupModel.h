//
//  DZCGroupModel.h
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/5.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZCGroupModel : NSObject

@property(nonatomic,copy)NSString *thumb_url,*title;//缩略图链接,文章标题
@property(nonatomic,assign)NSInteger media_type,item_id;//媒体种类,1代表长文章,2代表视频;id字符视频链接用


@end

NS_ASSUME_NONNULL_END
