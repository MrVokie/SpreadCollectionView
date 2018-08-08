//
//  MTCell.h
//  SpreadCollectionView
//
//  Created by Vokie on 16/7/27.
//  Copyright © 2016年 Vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

+ (UINib *)getNib;
@end
