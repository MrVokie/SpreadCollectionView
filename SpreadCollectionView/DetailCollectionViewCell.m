//
//  NBCollectionViewCell.m
//  Lesson_collectionView
//
//  Created by Vokie on 15/7/1.
//  Copyright (c) 2015年 Vokie. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "MTCell.h"
#import "DetailModel.h"

@implementation DetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    NSLog(@"Table Frame:%f", frame.size.height);
    if (self) {
        _itemTableView = [[UITableView alloc]init];
        _itemTableView.delegate = self;
        _itemTableView.dataSource = self;
        [_itemTableView registerNib:[MTCell getNib] forCellReuseIdentifier:@"MTCELL"];
        [self.contentView addSubview:_itemTableView];
        _itemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    _itemTableView.frame = self.contentView.frame;
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _itemTableView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.frame.size.height);

    return self.dataArray.count / 2 + (self.dataArray.count % 2 != 0);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableRow_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTCELL" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DetailModel *detail = [self.dataArray objectAtIndex:indexPath.row * 2];
    
    
    cell.leftLabel.text = detail.name;
    
    if (self.dataArray.count >= (indexPath.row * 2 + 2)) {
        DetailModel *detail2 = [self.dataArray objectAtIndex:(indexPath.row * 2 + 1)];
        cell.rightLabel.text = detail2.name;
    }else{
        cell.rightLabel.text = @"NoNo";
    }
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left:)];
    cell.leftLabel.userInteractionEnabled = YES;
    cell.leftLabel.tag = indexPath.row * 2;
    [cell.leftLabel addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right:)];
    cell.rightLabel.userInteractionEnabled = YES;
    cell.rightLabel.tag = indexPath.row * 2 + 1;
    [cell.rightLabel addGestureRecognizer:rightTap];
    
    return cell;
}

- (void)left:(id)sender {
    UITapGestureRecognizer *tap = sender;
    UILabel *leftLabel = (UILabel *)tap.view;
    DetailModel *model =[self.dataArray objectAtIndex:leftLabel.tag];
    NSLog(@"%@", model.name);
    
}

- (void)right:(id)sender {
    UITapGestureRecognizer *tap = sender;
    UILabel *rightLabel = (UILabel *)tap.view;
    DetailModel *model =[self.dataArray objectAtIndex:rightLabel.tag];
    NSLog(@"%@", model.name);
}


-(void)initModel:(NSMutableArray *)items{
    
    /*
     *   每传入数据的时候  刷新一下对应的tableView
     */
    _dataArray = nil;
    _dataArray=items;
    [_itemTableView reloadData];
}



@end
