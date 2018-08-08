//
//  MTCell.m
//  SpreadCollectionView
//
//  Created by Vokie on 16/7/27.
//  Copyright © 2016年 Vokie. All rights reserved.
//

#import "MTCell.h"

@implementation MTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (UINib *)getNib {
    return [UINib nibWithNibName:@"MTCell" bundle:nil];
}

@end
