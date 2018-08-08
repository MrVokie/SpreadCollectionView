//
//  SecondViewController.h
//  SpreadCollectionView
//
//  Created by Vokie on 15/7/24.
//  Copyright (c) 2015年 Vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSMutableArray *dataAry;
@property (nonatomic, retain)UICollectionView *minView;
@property (nonatomic, retain) UIPageControl *pageControl;

@end
