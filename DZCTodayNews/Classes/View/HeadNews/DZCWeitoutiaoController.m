//
//  DZCWeitoutiaoController.m
//  DZCTodayNews
//
//  Created by tomdu on 2018/11/29.
//  Copyright © 2018 tomdu. All rights reserved.
//

#import "DZCWeitoutiaoController.h"
#import "DZCWeitoutiaoCell.h"
#import "DZCWeitoutiaoModel.h"
#import "DZCNetsTools.h"
@interface DZCWeitoutiaoController ()
@property(nonatomic,strong)DZCWeitoutiaoModel *cellmodel;
@property(nonatomic,strong)NSMutableArray *weitoutiaoarray;
@end

@implementation DZCWeitoutiaoController




//获取网络模型后刷新

-(void)setWeitoutiaoarray:(NSMutableArray *)weitoutiaoarray{
    _weitoutiaoarray=weitoutiaoarray;
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DZCNetsTools netWrokWithWeitoutiao:^(NSArray * modelarray) {
        self.weitoutiaoarray=[NSMutableArray arrayWithArray:modelarray];
    }];
    [self registweitoutiaocell];
}
//注册cell
-(void)registweitoutiaocell{
    UINib *weitoutiaonib=[UINib nibWithNibName:@"WeitoutiaoCell" bundle:nil];
    [self.tableView registerNib:weitoutiaonib forCellReuseIdentifier:@"weitoutiaocell"];
    
    UINib *repostnib=[UINib nibWithNibName:@"Repostweitoutiao" bundle:nil];
    [self.tableView registerNib:repostnib forCellReuseIdentifier:@"repostcell"];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.weitoutiaoarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DZCWeitoutiaoModel *model=self.weitoutiaoarray[indexPath.row];
    
    if (model.is_repost) {
        DZCWeitoutiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repostcell" forIndexPath:indexPath];
        
        cell.weitoutiaomodel=model;
        return cell;
    }
    
    DZCWeitoutiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weitoutiaocell" forIndexPath:indexPath];


    cell.weitoutiaomodel=model;
    return cell;
}



@end
