//
//  SecondViewController.m
//  SpreadCollectionView
//
//  Created by Vokie on 15/7/24.
//  Copyright (c) 2015年 Vokie. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "DetailModel.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.minView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300) collectionViewLayout:layout];
    [self.view addSubview:self.minView];
    [self.minView setPagingEnabled:YES];
    self.minView.delegate = self;
    self.minView.dataSource = self;
    self.minView.backgroundColor = [UIColor whiteColor];
    
    [self.minView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //page control
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    self.pageControl.userInteractionEnabled = NO;
    [self.view addSubview:self.pageControl];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pageControl.currentPage = 1;
}






#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Table数目：%ld", self.dataAry.count);
    self.pageControl.numberOfPages = self.dataAry.count;
    return self.dataAry.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell initModel:[self.dataAry objectAtIndex:indexPath.row]];
    return cell;
}




#pragma mark - UICollectionViewDelegate 选中执行

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //选中执行的方法
    
    
    
    
}





#pragma mark - UICollectionViewDelegateFlowLayout - 动态布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataAry.count > 1) {
        CGFloat sizeHeight = 5 * kTableRow_Height;
        collectionView.frame = CGRectMake(0, 0, kScreenWidth, sizeHeight);
        self.pageControl.frame = CGRectMake(0, sizeHeight, kScreenWidth, 20);
        return CGSizeMake(kScreenWidth, sizeHeight);
    }else{
        NSArray *tempArray = [self.dataAry firstObject];
        CGFloat sizeHeight = (tempArray.count / 2 + (tempArray.count % 2 != 0)) * kTableRow_Height;
        collectionView.frame = CGRectMake(0, 0, kScreenWidth, sizeHeight);
        self.pageControl.frame = CGRectMake(0, sizeHeight, kScreenWidth, 20);
        return CGSizeMake(kScreenWidth, sizeHeight);
    
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / kScreenWidth;
}

#pragma mark - settersAndgetters





@end
