//
//  DZCTopNewsCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCTopNewsCell.h"
#import "DZCMainNewsModel.h"
#import "NSString+NSString_TimeToString.h"
@interface DZCTopNewsCell()
//标题
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
//头条注释
@property (weak, nonatomic) IBOutlet UILabel *topnewslabel;
//来源
@property (weak, nonatomic) IBOutlet UILabel *sourcelabel;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *replycountlabel;
//发布时间
@property (weak, nonatomic) IBOutlet UILabel *timelabel;


@end
@implementation DZCTopNewsCell

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
    
    self.titlelabel.text=self.model.title;
    
    self.topnewslabel.text=self.model.label;
    if (!self.model.media_name) {
        self.model.media_name=@"头条号自媒体";
    }
    self.sourcelabel.text=self.model.media_name;
   
    self.replycountlabel.text=[NSString stringWithFormat:@"%@评论",self.model.comment_count];
    
    self.timelabel.text = [NSString updateTimeForRow:self.model.publish_time];
 
}


@end
