//
//  DZCXiGuaVideoCellTableViewCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/25.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCXiGuaVideoCellTableViewCell.h"
#import "XiGuaModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DZCXiGuaVideoCellTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titlebel;
@property (weak, nonatomic) IBOutlet UILabel *playcountlabel;
@property (weak, nonatomic) IBOutlet UIButton *playbtn;
@property (weak, nonatomic) IBOutlet UIButton *durationbtn;
@property (weak, nonatomic) IBOutlet UIButton *commentbtn;
@property (weak, nonatomic) IBOutlet UIButton *rescouebtn;
@property (weak, nonatomic) IBOutlet UIButton *sharebtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatbtn;
@property (weak, nonatomic) IBOutlet UIButton *pyqbtn;
@property (weak, nonatomic) IBOutlet UIImageView *playerimageview;
@property (weak, nonatomic) IBOutlet UIButton *likebtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pyqleftcinstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wechaleftcibstraint;


@end
@implementation DZCXiGuaVideoCellTableViewCell
//延迟加载视频控制器
-(AVPlayerViewController*)playercontroller{
    if (_playercontroller==nil) {
        _playercontroller=[[AVPlayerViewController alloc]init];
    }
    
    return _playercontroller;
}

-(void)setCellmodel:(XiGuaModel *)cellmodel{
    _cellmodel=cellmodel;
    //执行赋值方法
    [self setModelforVideoCell];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)setModelforVideoCell{
    
    //主标题
    self.titlebel.text=self.cellmodel.descriptionPgc;
    self.playcountlabel.text=self.cellmodel.title;
    //播放时间
    NSString *timestring=[[NSString alloc]initWithFormat:@"%ld:%0.2ld",self.cellmodel.duration/60,self.cellmodel.duration%60];
    [self.durationbtn setTitle:timestring forState:UIControlStateDisabled];
   //cover.feed 模型照片路径
    
    [self.playerimageview sd_setImageWithURL:[self.cellmodel.cover valueForKey:@"feed"] placeholderImage:[UIImage imageNamed:@"user_default"]];
    // 发布者分类
   [self.rescouebtn setTitle:self.cellmodel.category forState:UIControlStateDisabled];
}

//显示视频,隐藏按钮
- (IBAction)showplayer:(UIButton *)sender {
    
    [self.rescouebtn setHidden:YES];
    [self.sharebtn setHidden:NO];
    [self.pyqbtn setHidden:NO];
    [self.wechatbtn setHidden:NO];
    [self wechatAnimotionshow];
    [self.playerimageview setHidden:YES];
    [self SetupavplayerandPlay:[NSURL URLWithString:self.cellmodel.playUrl]];
    
}

-(void)wechatAnimotionshow{
    //微信按钮动画
    CABasicAnimation *animation=[[CABasicAnimation alloc]init];
    animation.keyPath=@"position.x";
    
    animation.fromValue=@(self.wechatbtn.frame.origin.x);
    animation.toValue=@(self.wechatbtn.frame.origin.x+60);
    animation.duration=0.25;
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
    pyqanmimation.duration=0.25;
    [self.pyqbtn.layer addAnimation:pyqanmimation forKey:nil];
    //修改约束
    [self.pyqleftcinstraint setConstant:90];
    [self.wechaleftcibstraint setConstant:60];
    
}
//显示播放器并播放
-(void)SetupavplayerandPlay:(NSURL*)url{
    
    
    //创建播放控制器,创建播放器player.
    self.playercontroller.player=[[AVPlayer alloc]initWithURL:url];
    //获取背景图大小
    
    self.playercontroller.view.frame=self.playerimageview.frame;
    //添加视频layer
    AVPlayerLayer *playerlayer=[AVPlayerLayer playerLayerWithPlayer:self.playercontroller.player];
    
    playerlayer.frame =self.imageView.frame;
    playerlayer.videoGravity = AVLayerVideoGravityResize;
    [self.playercontroller.view.layer addSublayer:playerlayer];
    [self.contentView addSubview:self.playercontroller.view];
    [self.playercontroller.player play];
     
}
///显示子按钮隐藏播放器
-(void)setHiddenavplayer{
    
    [self.rescouebtn setHidden:NO];
    [self.sharebtn setHidden:YES];
    [self.pyqbtn setHidden:YES];
    [self.wechatbtn setHidden:YES];
    [self.playerimageview setHidden:NO];
    [self.playbtn setHidden:NO];
    [self.playercontroller.view removeFromSuperview];
    //约束归位
    [self.pyqleftcinstraint setConstant:5];
    [self.wechaleftcibstraint setConstant:5];
}

@end
