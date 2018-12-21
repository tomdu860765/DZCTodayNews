//
//  DZCSigninCell.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/12/19.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCSigninCell.h"
#import "UIImageView+DZCRoundImageView.h"
@interface DZCSigninCell()
@property (strong, nonatomic) IBOutlet UIImageView *headimage;
@property (strong, nonatomic) IBOutlet UILabel *screenname;
@property (strong, nonatomic) IBOutlet UILabel *descrtionlabel;
@end
@implementation DZCSigninCell

-(void)setUsermodel:(DZCWeiboUsermodel *)usermodel{
    _usermodel=usermodel;
    
    //给子控件赋值
    [self Setsubviewsinfo];
}

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//设置子控件显示信息
-(void)Setsubviewsinfo{
   //加载头像图片
    [self.headimage ImageviewcutRound:self.headimage withurl:self.usermodel.avatar_large];
    
    self.screenname.text=self.usermodel.screen_name;
    
    self.descrtionlabel.text=self.usermodel.userdescription;
}


@end
