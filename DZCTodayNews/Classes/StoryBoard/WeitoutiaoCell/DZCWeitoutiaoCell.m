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
@property (weak, nonatomic) IBOutlet UIImageView *headimageview;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (weak, nonatomic) IBOutlet UIButton *likebtn;
@property (weak, nonatomic) IBOutlet UIButton *commentbtn;
@property (weak, nonatomic) IBOutlet UIButton *repostbtn;
@property (weak, nonatomic) IBOutlet DZCWeitoutiaoView *cellview;
@property (strong, nonatomic) IBOutlet UILabel *reposttitle;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewheight;
@property (strong, nonatomic) IBOutlet UIView *backgroundview;




@end

@implementation DZCWeitoutiaoCell
-(void)setWeitoutiaomodel:(DZCWeitoutiaoModel *)weitoutiaomodel{
    _weitoutiaomodel=weitoutiaomodel;
    //获取模型然后赋值
    [self cellmodelwithWeitoutiao];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
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
    self.textlabel.text=self.weitoutiaomodel.rich_content;
    
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
}




@end
