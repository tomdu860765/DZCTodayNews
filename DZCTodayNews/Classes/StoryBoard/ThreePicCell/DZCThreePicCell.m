//
//  DZCThreePicCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/19.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCThreePicCell.h"
#import "NSString+RegularUrl.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+NSString_TimeToString.h"
#import "DZCMainNewsModel.h"
@interface DZCThreePicCell()
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIImageView *threenumview;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *threepic;
@property (weak, nonatomic) IBOutlet UILabel *sourcelabel;
@property (weak, nonatomic) IBOutlet UILabel *replylabel;
@property (weak, nonatomic) IBOutlet UILabel *pubilshtimelabel;
@property (weak, nonatomic) IBOutlet UIButton *piccountbtn;




@end
@implementation DZCThreePicCell
//网络请求赋值后,载入;
-(void)setModel:(DZCMainNewsModel *)model{
    _model=model;
    
    [self loadThreePicCellwithmodel];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//由于每个网络请求图片不一致复用的时候必须重写该父类方法
-(void)prepareForReuse{
    [super prepareForReuse];
    [self.threepic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *view=(UIImageView*)obj;
        
        [view sd_cancelCurrentAnimationImagesLoad];
        view.image =nil;
    }];
    
    
    
}
-(void)loadThreePicCellwithmodel{
    //循环获取链接数组
    if (self.model.image_list) {
        NSArray *imagearray= [self.model.image_list valueForKey:@"url"];
        
       [imagearray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *stringurl=[NSString stringWithUrl:obj];
            
            NSURL *url=[[NSURL alloc]initWithString:stringurl];
            
            [self.threepic[idx] sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
          
        }];
      
    }
    self.titlelabel.text=self.model.title;
    
    self.sourcelabel.text=self.model.media_name;
    
    self.replylabel.text= [[NSString alloc]initWithFormat:@"%@条评论",self.model.comment_count];
    
    self.pubilshtimelabel.text=[NSString updateTimeForRow:self.model.publish_time];
    
    if (self.model.gallary_image_count>3) {
        [self.piccountbtn setHidden:NO];
        NSString *stringpic=[[NSString alloc]initWithFormat:@"%ld图",(long)self.model.gallary_image_count];
        [self.piccountbtn setTitle:stringpic forState:UIControlStateDisabled];
    }
    
}


@end
