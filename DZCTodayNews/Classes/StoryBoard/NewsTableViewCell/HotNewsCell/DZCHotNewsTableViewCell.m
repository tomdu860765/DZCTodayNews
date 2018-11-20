//
//  DZCHotNewsTableViewCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/15.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCHotNewsTableViewCell.h"
#import "DZCMainNewsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+RegularUrl.h"
#import "NSString+NSString_TimeToString.h"
@interface DZCHotNewsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (weak, nonatomic) IBOutlet UIButton *hotbtn;
@property (weak, nonatomic) IBOutlet UILabel *sourcelabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelrightconstraint;

@end
@implementation DZCHotNewsTableViewCell
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

    // Configure the view for the selected state
}

-(void)loadModelwithnews{
    
    self.textlabel.text=self.model.title;
    
    self.sourcelabel.text=self.model.label;
    if (!self.model.media_name) {
        self.model.media_name=@"头条号自媒体";
    }
    self.sourcelabel.text=self.model.media_name;
    
    
    if (self.model.middle_image.url) {
        NSString *rtlstr=[NSString stringWithUrl:self.model.middle_image.url];
        
        
        NSURL *url=[NSURL URLWithString:rtlstr];
        
        [self.imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_default"]];
       
        
    }else{
       
        [self.labelrightconstraint setConstant:10];
        [self.imageview setHidden:YES];
        [self.imageview setFrame:CGRectZero];
    }
    
    
    self.timelabel.text = [NSString updateTimeForRow:self.model.publish_time];
}
@end
