//
//  DZCVideoCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/16.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCVideoCell.h"
#import "DZCMainNewsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+RegularUrl.h"
#import<AVFoundation/AVFoundation.h>
@interface DZCVideoCell()
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UIButton *likebtn;
@property (weak, nonatomic) IBOutlet UIButton *replybtn;
@property (weak, nonatomic) IBOutlet UIButton *sharebtn;
@property (weak, nonatomic) IBOutlet UIButton *pyqbtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatbtn;
@property (weak, nonatomic) IBOutlet UILabel *videotitle;
@property (weak, nonatomic) IBOutlet UILabel *playcountlabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *videoduration;


@end

@implementation DZCVideoCell
//播放器方法
- (IBAction)playactionbtn:(UIButton *)sender {
    //点击按钮获取视频id
    
    
    //获取网络方法反馈链接
    
    //隐藏按钮,标题,播放数标题
    
    //启动动画
    
}

-(void)setModel:(DZCMainNewsModel *)model{
    _model=model;
    if (model) {
        [self loadModelwithnews];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)loadModelwithnews{
    
    self.videotitle.text=self.model.title;
   
   
    if (!self.model.media_name) {
        self.model.media_name=@"头条号自媒体";
    }
    self.namelabel.text=self.model.media_name;

    if (self.model.middle_image.url) {
        NSString *rtlstr=[NSString stringWithUrl:self.model.middle_image.url];


        NSURL *url=[NSURL URLWithString:rtlstr];

        [self.imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];


    }
    
    NSString *commentcount=[[NSString alloc]initWithFormat:@"%@",self.model.comment_count ];
    [self.replybtn setTitle:commentcount forState:UIControlStateNormal];
    
    self.playcountlabel.text=[[NSString alloc]initWithFormat:@"%@次播放" ,  [self.model.video_detail_info valueForKey:@"video_watch_count"] ];
    
   
    self.videoduration.text=self.model.video_duration;
    
}





@end
