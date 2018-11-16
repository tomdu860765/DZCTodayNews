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
#import<AVFoundation/AVFoundation.h>
@interface DZCVideoCell()
@property (weak, nonatomic) IBOutlet UILabel *sharelabel;
@property (weak, nonatomic) IBOutlet UIButton *likebtn;
@property (weak, nonatomic) IBOutlet UIButton *replybtn;
@property (weak, nonatomic) IBOutlet UIButton *sharebtn;
@property (weak, nonatomic) IBOutlet UIButton *pyqbtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatbtn;



@end
@implementation DZCVideoCell

-(void)setModel:(DZCMainNewsModel *)model{
    _model=model;
    if (model) {
        [self loadModelwithnews];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)loadModelwithnews{
    
//    self.textlabel.text=self.model.title;
//    
//    self.sourcelabel.text=self.model.label;
//    if (!self.model.media_name) {
//        self.model.media_name=@"头条号自媒体";
//    }
//    self.sourcelabel.text=self.model.media_name;
//
//
//    if (self.model.middle_image.url) {
//        NSString *rtlstr=[NSString stringWithUrl:self.model.middle_image.url];
//
//
//        NSURL *url=[NSURL URLWithString:rtlstr];
//
//        [self.imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
//
//
//    }else{
//        [self.imageview setHidden:YES];
//        [self.imageview setFrame:CGRectZero];
//    }
//
//
//    self.timelabel.text = [NSString updateTimeForRow:self.model.publish_time];
}





@end
