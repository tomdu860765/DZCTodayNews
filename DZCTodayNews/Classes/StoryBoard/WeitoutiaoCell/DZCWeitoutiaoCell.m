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
@interface DZCWeitoutiaoCell()
@property (weak, nonatomic) IBOutlet UIImageView *headimageview;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (weak, nonatomic) IBOutlet UIImageView *toutiaoimageview;
@property (weak, nonatomic) IBOutlet UIButton *likebtn;
@property (weak, nonatomic) IBOutlet UIButton *commentbtn;
@property (weak, nonatomic) IBOutlet UIButton *repostbtn;


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
    
    if (self.weitoutiaomodel.ugc_cut_image_list.count==1) {
        
        [self.weitoutiaomodel.ugc_cut_image_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSURL *url=[[NSURL alloc]initWithString:[obj valueForKey:@"url"]];
            
            [self.toutiaoimageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
        }];
        
        
    }
    
}




@end
