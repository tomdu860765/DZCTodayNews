//
//  DZCPlayerController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/8.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCPlayerController.h"
#import "Masonry.h"
@interface DZCPlayerController ()
@property (strong, nonatomic) IBOutlet UISlider *timeslider;
@property(nonatomic,strong)AVPlayer *DZCplayer;
@property (strong, nonatomic) IBOutlet UIView *naviview;//播放导航图
@property (strong, nonatomic) IBOutlet UIView *viewtoolbar;//播放工具视图
- (IBAction)stopitem:(UIButton *)sender;//停止按钮
@property (strong, nonatomic) IBOutlet UIButton *timebtn;//显示时间按钮
- (IBAction)palyandprusebtn:(UIButton *)sender;//暂停播放按钮
- (IBAction)videoslider:(UISlider *)sender;//时间显示导航栏
- (IBAction)fullscreenbtn:(UIButton *)sender;//全屏按钮
@property (strong, nonatomic) IBOutlet UILabel *runtimelabel;
@property(assign,nonatomic,getter=isPlayingstyle)BOOL Playingstyle;//播放状态
@property(assign,nonatomic,getter=isFullscreen)BOOL Fullscreenstyle;//全屏状态
@property(strong,nonatomic)AVPlayerItem *DZCplayeritem;//播放器状态监测
@property(strong,nonatomic)AVPlayerLayer *DZCplayerlayer;//视频播放layer
@end

@implementation DZCPlayerController


-(AVPlayerLayer*)DZCplayerlayer{
    if (_DZCplayerlayer==nil) {
        _DZCplayerlayer=AVPlayerLayer.new;
    }
    
    return _DZCplayerlayer;
}
//延迟加载播放器
-(AVPlayer*)DZCplayer{
    if (_DZCplayer==nil) {
        
        
        _DZCplayer=AVPlayer.new;
    }
    
    return _DZCplayer;
    
}
//加载视频信息item
-(AVPlayerItem*)DZCplayeritem{
    if (_DZCplayeritem==nil) {
        NSString *urlstring=@"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=141830&resourceType=video&editionType=default&source=aliyun";
        NSURL *url=[NSURL URLWithString:urlstring];
       
        _DZCplayeritem=[[AVPlayerItem alloc]initWithURL:url];
    }
    
    return _DZCplayeritem;
}

//退出视频
- (IBAction)stopitem:(UIBarButtonItem *)sender {
    
    [self.view removeFromSuperview];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"退出控制器");
    
}


- (IBAction)palyandprusebtn:(UIButton *)sender {
  
  
    //根据状态暂停或者播放
    self.Playingstyle ? [self.DZCplayer pause]:[self.DZCplayer play];
   
    //设置按钮标题
    if (self.isPlayingstyle) {
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }

    //设置状态
    self.Playingstyle=!self.Playingstyle;
}

- (IBAction)videoslider:(UISlider *)sender {
}

- (IBAction)fullscreenbtn:(UIButton *)sender {
    //全屏状态
    
    self.Fullscreenstyle ?[self DZCplayerMiniscreenwithportrait]:[self DZCplayerFullscreenandlandscape];
    
    //设置按钮标题
    if (self.isFullscreen) {
        [sender setTitle:@"全屏" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"小屏" forState:UIControlStateNormal];
    }
    
    self.Fullscreenstyle=!self.Fullscreenstyle;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPlayerAndPlay:nil];
    
}


///设置播放器并播放
-(void)setupPlayerAndPlay:(NSURL*)neturlstring{

    
    self.DZCplayer=[self.DZCplayer initWithPlayerItem:self.DZCplayeritem];
    self.DZCplayerlayer=[AVPlayerLayer playerLayerWithPlayer:self.DZCplayer];
    self.DZCplayerlayer.frame=self.view.frame;

    [self.view.layer addSublayer:self.DZCplayerlayer];

    //播放
    [self.DZCplayer play];
    //正在播放状态
    self.Playingstyle=YES;
    //小屏播放
    self.Fullscreenstyle=NO;
    //设置计算播放时间
    [self settimeSliderWithprogerss];
}
///全屏状态处理
-(void)DZCplayerFullscreenandlandscape{

    self.view.transform=CGAffineTransformMakeRotation(M_PI*0.5);
   //设置视图控制器的frame
    self.view.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    //设置播放器的frame注意高度和宽度互换
    self.DZCplayerlayer.frame=CGRectMake(0, 0, SCREENHEIGHT, SCREENWIDTH);
   //移除子视图
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    [self fullscreenAndresetsubviews];
   
}
///设置全屏重新布局子视图
-(void)fullscreenAndresetsubviews{

    //重新布局子视图
    [self.view addSubview:self.viewtoolbar];
    [self.viewtoolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.mas_equalTo(self.view.center.x);
        make.width.mas_equalTo(SCREENHEIGHT*0.5);
    }];
    [self.view addSubview:self.naviview];
    [self.naviview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.center.x);
        make.width.mas_equalTo(SCREENHEIGHT*0.5);
    }];
    

}



///退出全屏状态
-(void)DZCplayerMiniscreenwithportrait{
    
    //移除子视图
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    self.view.transform=CGAffineTransformMakeRotation(0);
    //设置视图控制器的frame
    self.view.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    //设置播放器的frame注意高度和宽度互换
    self.DZCplayerlayer.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    //还原导航视图和工具视图
    [self ResetminiscreenSubviews];
    
}
///还原原来的视频并重新布局子视图
-(void)ResetminiscreenSubviews{
   
    //重新布局子视图
    [self.view addSubview:self.viewtoolbar];
    [self.viewtoolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
    }];
    [self.view addSubview:self.naviview];
    [self.naviview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(SCREENWIDTH);
    }];

}

///设置进度条时间缓冲
-(void)settimeSliderWithprogerss{
    //获取视频总时长
    float totalTime = CMTimeGetSeconds(self.DZCplayeritem.duration);
    
    [self.timebtn setTitle:[[NSString alloc]initWithFormat:@"%f",totalTime ] forState:UIControlStateNormal];
    
    
   
    
    __weak __typeof(self) weakSelf = self;
    [self.DZCplayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
        
        NSInteger currentTime = self.DZCplayeritem.currentTime.value/self.DZCplayeritem.currentTime.timescale;
       // NSLog(@"%@",@(CMTimeGetSeconds(time)));
        weakSelf.runtimelabel.text=[[NSString alloc]initWithFormat:@"%.2lds.",(long)currentTime];
    }];
    
}





@end
