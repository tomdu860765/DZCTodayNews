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
#import "DZCNetsTools.h"
#import  <AVFoundation/AVFoundation.h>
#import  <AVKit/AVKit.h>
@interface DZCVideoCell()
@property (weak, nonatomic) IBOutlet UIButton *playbtn;
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pyqleftconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wechatconstraint;
@property(strong,nonatomic)UIButton *btnmark;
@property(strong,nonatomic)NSURL *videourl;
@property(nonatomic,strong)AVPlayerViewController *AVPlayerViewController;
@end

@implementation DZCVideoCell

-(AVPlayerViewController*)AVPlayerViewController{
    
    if (_AVPlayerViewController==nil) {
        _AVPlayerViewController=[[AVPlayerViewController alloc]init];
    }
    
    return  _AVPlayerViewController;
}

//播放器方法
- (IBAction)playactionbtn:(UIButton *)sender {
    if (sender==self.btnmark) {
        
        return;
    }

    //点击按钮获取视频id,获取网络方法反馈链接,并回调给视频播放器
    [DZCNetsTools NetworVideo:[self.model.video_detail_info valueForKey:@"video_id"] finishBlock:^(NSString * realVideourl) {
        
        NSURL *url=[[NSURL alloc]initWithString:realVideourl];
        self.videourl=url;
    }];
    
    
    [self cellsubViewshidden];
    [self wechatAnimotionshow];
    self.btnmark=sender;
    [sender setHidden:YES];
   // [[NSNotificationCenter defaultCenter]postNotificationName:@"cellvideoplay" object:self];
    [self addVideocontrollerFortableviewcell];
    
}

-(void)cellsubViewshidden{
    
    
    //隐藏按钮,标题,播放数标题
    [self.namelabel setHidden:YES];
    [self.playcountlabel setHidden:YES];
    [self.videotitle setHidden:YES];
    
    [self.pyqbtn setHidden:NO];
    [self.sharebtn setHidden:NO];
    [self.wechatbtn setHidden:NO];
    
    
}

-(void)setModel:(DZCMainNewsModel *)model{
    _model=model;
    if (model) {
        
        [self loadModelwithnews];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
 
  
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
    //评论按钮处理
    NSString *commentcount=[[NSString alloc]initWithFormat:@"%@",self.model.comment_count ];
    [self.replybtn setTitle:commentcount forState:UIControlStateNormal];
    [self.replybtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.replybtn sizeToFit];
    //播放次数处理
    NSNumber *watchnumber=[self.model.video_detail_info valueForKey:@"video_watch_count"];
    
    self.playcountlabel.text=[[NSString alloc]initWithFormat:@"%@万次播放", @([watchnumber integerValue]/10000) ];

   
    self.videoduration.text=self.model.video_duration;
    
}

-(void)wechatAnimotionshow{
    //微信按钮动画
    CABasicAnimation *animation=[[CABasicAnimation alloc]init];
    animation.keyPath=@"position.x";
    
    animation.fromValue=@(self.wechatbtn.frame.origin.x);
    animation.toValue=@(self.wechatbtn.frame.origin.x+50);
    animation.duration=2;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.wechatbtn.layer addAnimation:animation forKey:nil];
    
    //朋友圈按钮动画
    CABasicAnimation *pyqanmimation=[[CABasicAnimation alloc]init];
    pyqanmimation.keyPath=@"position.x";
    pyqanmimation.fromValue=@(self.pyqbtn.frame.origin.x);
    pyqanmimation.toValue=@(self.pyqbtn.frame.origin.x+90);
    pyqanmimation.removedOnCompletion=NO;
    pyqanmimation.fillMode=kCAFillModeForwards;
    pyqanmimation.duration=2;
    [self.pyqbtn.layer addAnimation:pyqanmimation forKey:nil];
    [self.pyqleftconstraint setConstant:90];
    [self.wechatconstraint setConstant:50];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)addVideocontrollerFortableviewcell{
    
    //创建播放控制器,创建播放器player.
    self.AVPlayerViewController.player=[[AVPlayer alloc]initWithURL:self.videourl];
    //获取背景图大小
  
    
    self.AVPlayerViewController.view.frame=self.imageview.frame;
    //视频layer
    AVPlayerLayer *playerlayer=[AVPlayerLayer playerLayerWithPlayer:self.AVPlayerViewController.player];
    
    playerlayer.frame =self.imageview.frame;
    playerlayer.videoGravity = AVLayerVideoGravityResize;
    
    [self.contentView addSubview:self.AVPlayerViewController.view];
    //视频f播放
    [self.AVPlayerViewController.player play];

}

@end
