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
@property(assign,nonatomic,getter=isSliderDraging)BOOL SliderDraging;//进度条滑动状态
@property(assign,nonatomic,getter=isTouchiing)BOOL Touching;//触摸状态
@property(strong,nonatomic)AVPlayerItem *DZCplayeritem;//播放器状态监测
@property(strong,nonatomic)AVPlayerLayer *DZCplayerlayer;//视频播放layer
@property(weak,nonatomic)id timeobserver;//记录时间观察者kvo
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
    self.Touching=YES;
    [self.view removeFromSuperview];
    //销毁通知和播放item
    [self.DZCplayer.currentItem cancelPendingSeeks];
    [self.DZCplayer.currentItem.asset cancelLoading];
    [self.DZCplayer removeTimeObserver:self.timeobserver];
    
    [self.DZCplayeritem removeObserver:self forKeyPath:@"status"];
    [self.DZCplayeritem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (IBAction)palyandprusebtn:(UIButton *)sender {
    self.Touching=YES;
    
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
//进度条跳转视频
- (IBAction)videoslider:(UISlider *)sender {
    self.Touching=YES;
    //移除时间监控kvo,停止视频,设置bool标记
    [self.DZCplayer removeTimeObserver:self.timeobserver];
    self.SliderDraging=YES;
    [self.DZCplayer pause];
    
    //设置时间进度
    
    float minValue = [sender minimumValue];
    
    float maxValue = [sender  maximumValue];
    
    float value=sender.value;
    
    float duration=CMTimeGetSeconds(self.DZCplayeritem.asset.duration);
    
    Float64 seconds = duration  * (value - minValue) / (maxValue - minValue);
    
    int32_t preferredTimeScale = 1 *NSEC_PER_SEC;
    
    CMTime seektime=CMTimeMakeWithSeconds(seconds,preferredTimeScale);
   
    [self.DZCplayer seekToTime:seektime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        //拖动结束之后重新设置kvo,播放视频,bool标记
        if (finished) {
                self.SliderDraging=NO;
                [self  settimeSliderWithprogerss];
                [self.DZCplayer play];
        }
    }];

}

- (IBAction)fullscreenbtn:(UIButton *)sender {
    self.Touching=YES;
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
    
    //对播放对象添加观察者
    [self.DZCplayeritem addObserver:self forKeyPath:@"status"
                            options:NSKeyValueObservingOptionNew context:nil];
    [self.DZCplayeritem addObserver:self forKeyPath:@"loadedTimeRanges"
                            options:NSKeyValueObservingOptionNew context:nil];
    
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
    //进度条状态
    self.SliderDraging=NO;
    //触摸状体
    self.Touching=NO;
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
    double totalTime = CMTimeGetSeconds(self.DZCplayeritem.asset.duration);
    
    NSInteger timeint=totalTime ;
    
    NSString *totaltimestring=[[NSString alloc]initWithFormat:@"%ld:%02ld",timeint/60,timeint%60];
    [self.timebtn setTitle:totaltimestring forState:UIControlStateDisabled];
    
    
    //获取当前时间,该方法返回一个观察者对象需要手动释放
    __weak __typeof(self) weakSelf = self;
    //进度条总进度
    self.timeslider.maximumValue=totalTime;
    
    if (self.timeobserver) {
        return;
    }
    
    id currenttimeobserver=[self.DZCplayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
        //正在滑动不更新
        if (weakSelf.isSliderDraging) {
            return ;
        }
        
        NSInteger currentTime = self.DZCplayeritem.currentTime.value/self.DZCplayeritem.currentTime.timescale;
        //设置缓冲条更新
        [weakSelf.timeslider setValue:currentTime animated:YES];
        [weakSelf.timeslider setMinimumValue:currentTime/totalTime];
        [weakSelf.timeslider setMinimumTrackTintColor:[UIColor blueColor]];
        //设置时间label
        weakSelf.runtimelabel.text=[[NSString alloc]initWithFormat:@"%ld:%02ld",(long)currentTime/60,(long)currentTime%60];
    }];
    
    self.timeobserver=currenttimeobserver;
    
   
    
}
//播放媒体状态观察者方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    self.DZCplayeritem=object;
    
    if ([keyPath isEqualToString:@"status"]) {
        //播放状态
        AVPlayerStatus status=[[change valueForKey:@"new"]integerValue];
        
        switch (status) {
            case AVPlayerStatusReadyToPlay:{
                //设置计算播放时间
                [self settimeSliderWithprogerss];
                //3秒后隐藏工具视图和导航视图
               
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self SetnavibarAndToolbarhidden];
                });
                NSLog(@"准备好播放");}
                break;
            case AVPlayerStatusUnknown:
                NSLog(@"资源不明");
                break;
                
            case AVPlayerStatusFailed:
                NSLog(@"资源加载失败");
                break;
        }
        
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        
        //获取总时长并更新进度条
        [self.timeslider setMaximumValue:CMTimeGetSeconds(self.DZCplayeritem.asset.duration)];
        [self.timeslider setMaximumTrackTintColor:[UIColor orangeColor]];
        
    }
    
}
///工具视图隐藏方法
-(void)SetnavibarAndToolbarhidden{
    if (self.isTouchiing==NO) {
    
    [self.naviview setHidden:YES];
    [self.viewtoolbar setHidden:YES];
    }
}
///工具视图显示方法
-(void)SetnavibarAndToolbarshow{
    if (self.isTouchiing==YES) {

        [self.naviview setHidden:NO];
        [self.viewtoolbar setHidden:NO];
        
    }
    
}

//点击屏幕显示上下操作栏
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.Touching=YES;
    
    [self SetnavibarAndToolbarshow];
    
    NSLog(@"开始出没");
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.Touching=NO;
        
        [self SetnavibarAndToolbarhidden];
        
    });

    
}

//控制器销毁
-(void)dealloc{
  
    NSLog(@"销毁播放控制器");
}



@end
