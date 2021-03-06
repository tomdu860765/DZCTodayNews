//
//  DZCHuoShanCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/5.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHuoShanCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DZCPlayerController.h"
@interface DZCHuoShanCell()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundview;//背景图
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;//视频标题
@property (strong, nonatomic) IBOutlet UIButton *playbtn;//播放按钮
@property (strong, nonatomic) IBOutlet UILabel *playcountlabel;//播放次数
@property (strong, nonatomic) IBOutlet UILabel *likelabel;//点赞数

@end
@implementation DZCHuoShanCell
//载入模型
-(void)setHuoshanmodel:(DZCMainNewsModel *)huoshanmodel{
    _huoshanmodel=huoshanmodel;
    
    [self loadmodelWithHuoshanVideo];
}

//显示播放器
- (IBAction)showplayercontroller:(UIButton *)sender {
    
    [self collectionViewnetworkforVideo];
    
    
}


-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}

-(void)loadmodelWithHuoshanVideo{
    //取出模型的链接
    NSString *string=[self.huoshanmodel.large_image_list.firstObject valueForKey:@"url"];
    
    NSURL *url=[NSURL URLWithString:string];
    
    [self.backgroundview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    
    self.titlelabel.text=self.huoshanmodel.title;
    
    
    
    self.playcountlabel.text=[NSString stringWithFormat:@"%ld万次播放",[self.huoshanmodel.read_count integerValue]/10000];
    
    self.likelabel.text=[NSString stringWithFormat:@"%@赞",@(self.huoshanmodel.digg_count)];
    
    
}
//视频链接网络请求
-(void)collectionViewnetworkforVideo{
    
    [DZCNetsTools NetworVideo:[self.huoshanmodel.video_detail_info valueForKey:@"video_id"]
                  finishBlock:^(NSString * netvideostring) {
                      //创建播放控制器
                      UIStoryboard *videostoryboard=[UIStoryboard storyboardWithName:@"DZCPlayerController" bundle:nil];
                      
                      DZCPlayerController *palycontroller=[videostoryboard instantiateViewControllerWithIdentifier:@"videoplayersb"];
                      palycontroller.urlstring=[NSURL URLWithString:netvideostring];
                      [self.huoshanviewcontroller presentViewController:palycontroller animated:YES completion:nil];
     
                  }];
    
    
    
}

@end
