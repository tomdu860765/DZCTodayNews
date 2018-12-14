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
#import "DZCNetsTools.h"
#import "DZCPlayerController.h"
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pyqleftconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wechatconstraint;
@property(nonatomic,strong)AVPlayerViewController *AVPlayerViewController;
@property (weak, nonatomic) IBOutlet UIButton *videotimebtn;
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


    //点击按钮获取视频id,获取网络方法反馈链接,并回调给视频播放器
    [DZCNetsTools NetworVideo:[self.model.video_detail_info valueForKey:@"video_id"] finishBlock:^(NSString * realVideourl) {
        
        NSURL *url=[[NSURL alloc]initWithString:realVideourl];
        [self addVideocontrollerFortableviewcell:url];
        
    }];
    
    
    [self cellsubViewshidden];
    [self wechatAnimotionshow];
    [self.playbtn setHidden:YES];
    
   
    
}
//按钮隐藏
-(void)cellsubViewshidden{
    
    
    //隐藏按钮,标题,播放数标题
    [self.namelabel setHidden:YES];
    [self.playcountlabel setHidden:YES];
    [self.videotitle setHidden:YES];
    
    [self.pyqbtn setHidden:NO];
    [self.sharebtn setHidden:NO];
    [self.wechatbtn setHidden:NO];
  
    
}
//显示按钮移除播放器
-(void)cellsubViewsshow{
    
    [self.namelabel setHidden:NO];
    [self.playcountlabel setHidden:NO];
    [self.videotitle setHidden:NO];
    
    [self.pyqbtn setHidden:YES];
    [self.sharebtn setHidden:YES];
    [self.wechatbtn setHidden:YES];
    
    //移除播放器
    
    [self.playbtn setHidden:NO];
    [self.pyqleftconstraint setConstant:8];
    [self.wechatconstraint setConstant:8];

    [self.AVPlayerViewController.view removeFromSuperview];
}

-(void)setModel:(DZCMainNewsModel *)model{
    _model=model;
    if (model) {
        
        [self loadModelwithnews];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
 
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}
-(void)prepareForReuse{
    
    [super prepareForReuse];
    
    [self.AVPlayerViewController.view removeFromSuperview];
    
}


-(void)loadModelwithnews{
    
    self.videotitle.text=self.model.title;
   
   
    if (!self.model.media_name) {
        self.model.media_name=@"头条号自媒体";
    }
    self.namelabel.text=self.model.media_name;

    if (self.model.middle_image.url) {
        //缩略图链接
        //NSString *rtlstr=[NSString stringWithUrl:self.model.middle_image.url];
        //大图链接
        NSString *string=[self.model.large_image_list.firstObject valueForKey:@"url"];

        NSURL *url=[NSURL URLWithString:string];

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
   
    
    NSString *timestr=[[NSString alloc]initWithFormat:@"%ld:%0.2ld",self.model.video_duration/60,self.model.video_duration%60];
    NSAttributedString *attristring=[[NSAttributedString alloc]initWithString:timestr];
    [self.videotimebtn setAttributedTitle:attristring forState:UIControlStateDisabled];
   
    
    
}

-(void)wechatAnimotionshow{
    //微信按钮动画
    CABasicAnimation *animation=[[CABasicAnimation alloc]init];
    animation.keyPath=@"position.x";
    
    animation.fromValue=@(self.wechatbtn.frame.origin.x);
    animation.toValue=@(self.wechatbtn.frame.origin.x+40);
    animation.duration=0.25;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.wechatbtn.layer addAnimation:animation forKey:nil];
    
    //朋友圈按钮动画
    CABasicAnimation *pyqanmimation=[[CABasicAnimation alloc]init];
    pyqanmimation.keyPath=@"position.x";
    pyqanmimation.fromValue=@(self.pyqbtn.frame.origin.x);
    pyqanmimation.toValue=@(self.pyqbtn.frame.origin.x+70);
    pyqanmimation.removedOnCompletion=NO;
    pyqanmimation.fillMode=kCAFillModeForwards;
    pyqanmimation.duration=0.25;
    [self.pyqbtn.layer addAnimation:pyqanmimation forKey:nil];
    [self.pyqleftconstraint setConstant:90];
    [self.wechatconstraint setConstant:50];
    
}


///添加视频播放器方法
-(void)addVideocontrollerFortableviewcell:(NSURL*)url{
    //创建播放控制器,创建播放器player.
    self.AVPlayerViewController.player=[[AVPlayer alloc]initWithURL:url];
    //获取背景图大小
    
    self.AVPlayerViewController.view.frame=self.imageview.frame;
    
    //添加视频layer
    AVPlayerLayer *playerlayer=[AVPlayerLayer playerLayerWithPlayer:self.AVPlayerViewController.player];
    
    
    playerlayer.videoGravity =AVLayerVideoGravityResizeAspect;
    [self.AVPlayerViewController.view.layer addSublayer:playerlayer];
    [self.contentView addSubview:self.AVPlayerViewController.view];
    [self.AVPlayerViewController.player play];


    //发送通知播放视频
    [[NSNotificationCenter defaultCenter]postNotificationName:@"homevideoplayer" object:self];
}

@end
