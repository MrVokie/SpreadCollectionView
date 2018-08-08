//
//  NBCollectionViewCell.h
//  Lesson_collectionView
//
//  Created by Vokie on 15/7/1.
//  Copyright (c) 2015年 Vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionViewCell : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *itemTableView;
@property (nonatomic, retain) NSArray *dataArray;

-(void)initModel:(NSArray *)items;
@end
