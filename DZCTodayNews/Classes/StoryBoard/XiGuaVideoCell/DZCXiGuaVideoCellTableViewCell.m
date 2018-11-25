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
@end
@implementation DZCXiGuaVideoCellTableViewCell
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




@end
