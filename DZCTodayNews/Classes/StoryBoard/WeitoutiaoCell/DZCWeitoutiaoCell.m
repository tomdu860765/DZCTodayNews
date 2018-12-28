//
//  DZCWeitoutiaoCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/29.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCWeitoutiaoCell.h"
#import "UIImage+DZCImageround.h"
#import "UIImageView+DZCRoundImageView.h"
#import "NSString+NSString_TimeToString.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYModel.h"
#import "DZCWeitoutiaoView.h"
#import "NSString+RegularUrl.h"
#import "NSAttributedString+DZCEmojiAttributedstring.h"
@interface DZCWeitoutiaoCell()
@property (weak, nonatomic) IBOutlet UIImageView *headimageview;//头像
@property (weak, nonatomic) IBOutlet UILabel *namelabel;//发布人
@property (weak, nonatomic) IBOutlet UILabel *timelabel;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *textlabel;//文章内容
@property (weak, nonatomic) IBOutlet UIButton *likebtn;//点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *commentbtn;//评论按钮
@property (weak, nonatomic) IBOutlet UIButton *repostbtn;//转载按钮
@property (weak, nonatomic) IBOutlet DZCWeitoutiaoView *cellview;//九宫格布局view
@property (strong, nonatomic) IBOutlet UILabel *reposttitle;//转载内容
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewheight;//九宫格view高度
@property (strong, nonatomic) IBOutlet UIView *backgroundview;//转载背景view
@property (strong, nonatomic) IBOutlet UILabel *vatitle;//视频文章标题
@property (strong, nonatomic) IBOutlet UIButton *playbtn;//播放按钮
@property (strong, nonatomic) IBOutlet UIImageView *vaimageview;//视频文章图片
@property (strong, nonatomic) IBOutlet UILabel *recountlabel;//阅读数
@property (strong, nonatomic) IBOutlet UILabel *likelabel;//点赞数
@property (strong, nonatomic) IBOutlet UILabel *commentlabel;//评论数




@end

@implementation DZCWeitoutiaoCell
-(void)setWeitoutiaomodel:(DZCWeitoutiaoModel *)weitoutiaomodel{
    _weitoutiaomodel=weitoutiaomodel;
    //获取模型然后赋值
    [self cellmodelwithWeitoutiao];
}


- (void)awakeFromNib {
    [super awakeFromNib];
   // self.selectionStyle=UITableViewCellSelectionStyleNone;
    
}

-(void)prepareForReuse{
    [super prepareForReuse];
    //移除旧的图片
    for (UIView *view in self.cellview.subviews) {
        [view removeFromSuperview];
        
    }
    self.reposttitle.attributedText=nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
//对cell子控件赋值
-(void)cellmodelwithWeitoutiao{

    //内容标题
    self.textlabel.attributedText=[NSMutableAttributedString StringWithemoji:self.weitoutiaomodel.content_unescape];
    
    //点赞数
    NSString *digcount=[NSString stringWithFormat:@"%@",self.weitoutiaomodel.digg_count];
    [self.likebtn setTitle:digcount forState:UIControlStateNormal];
    
    //评论数
    NSString *commentcount=[NSString stringWithFormat:@"%@",self.weitoutiaomodel.comment_count];
    [self.commentbtn setTitle:commentcount forState:UIControlStateNormal];
    
    //转发数
    NSString *repostcount=[NSString stringWithFormat:@"%@",self.weitoutiaomodel.forward_count];
    [self.repostbtn setTitle:repostcount forState:UIControlStateNormal];
    
    //头像图片
    [self.headimageview ImageviewcutRound:self.headimageview withurl:[self.weitoutiaomodel.user valueForKey:@"avatar_url"]];
    //关注名字
    self.namelabel.text=[self.weitoutiaomodel.user valueForKey:@"screen_name"];
    //发出时间
    NSInteger time=[self.weitoutiaomodel.create_time integerValue];
    
    self.timelabel.text=[NSString time_timestampToString:time];
    
    //设置图像高度
    [self.viewheight setConstant:[self.cellview ninepicturesViewHeight:self.weitoutiaomodel]];
    //转发微博
    if (self.weitoutiaomodel.is_repost) {
        
        [self showrepostCell];
    }
    //视频或者长文章
    if (self.weitoutiaomodel.group.title)
    {
       
        
        self.vatitle.attributedText=[NSMutableAttributedString StringWithemoji:self.weitoutiaomodel.group.title];
        
        NSURL *url=[NSURL URLWithString:self.weitoutiaomodel.group.thumb_url];
        [self.vaimageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
       
        self.recountlabel.text=[[NSString alloc]initWithFormat:@"%d万阅读" ,[self.weitoutiaomodel.read_count intValue]/10000];
        
        self.likelabel.text=[[NSString alloc]initWithFormat:@"%@赞" ,self.weitoutiaomodel.digg_count];
        
        self.commentlabel.text=[[NSString alloc]initWithFormat:@"%@评论" ,self.weitoutiaomodel.comment_count ];
        //第二种格式播放按钮显示
        if (self.weitoutiaomodel.group.media_type==2) {
            [self.playbtn setHidden:NO];
        }
    
    }
    
    
    
}

//显示转发微头条
-(void)showrepostCell{
    
    //判断是否有转发名字
    if ([self.weitoutiaomodel.origin_thread.user valueForKey:@"screen_name"]) {
        //准发人昵称
        NSString *name=[[NSString alloc]initWithFormat:@"@%@  ",[self.weitoutiaomodel.origin_thread.user valueForKey:@"screen_name"]];
        
        NSMutableAttributedString *stringname=[[NSMutableAttributedString alloc]initWithString:name
                                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
        
        //转发内容
        NSMutableAttributedString *strintext=[NSMutableAttributedString StringWithemoji: self.weitoutiaomodel.origin_thread.content_unescape];
        //拼接字符串
        [stringname appendAttributedString:strintext];
        
        self.reposttitle.attributedText=stringname;
        
        
    }else{
        [self.backgroundview setBackgroundColor:[UIColor clearColor]];
        
    }
    
    
}



@end
