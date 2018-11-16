//
//  DZCSinglePicCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCSinglePicCell.h"
#import "DZCMainNewsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+RegularUrl.h"
@interface DZCSinglePicCell()
//单图
@property (weak, nonatomic) IBOutlet UIImageView *image;
//评论数量
@property (weak, nonatomic) IBOutlet UILabel *replylabel;
//来源
@property (weak, nonatomic) IBOutlet UILabel *sourcelabel;
//正文
@property (weak, nonatomic) IBOutlet UILabel *textlabel;


@end
@implementation DZCSinglePicCell
//网络模型加载
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

    // Configure the view for the selected state
}

-(void)loadModelwithnews{
    
    self.textlabel.text=self.model.title;
    
    self.sourcelabel.text=self.model.label;
    if (!self.model.media_name) {
        self.model.media_name=@"头条号自媒体";
    }
    self.sourcelabel.text=self.model.media_name;
    
    self.replylabel.text=[NSString stringWithFormat:@"%@评论",self.model.comment_count];
    if (self.model.middle_image.url){
    NSString *rtlstr=[NSString stringWithUrl:self.model.middle_image.url];
    NSURL *url=[NSURL URLWithString:rtlstr];
    
    
       [self.image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
    }

    
    
}

@end
