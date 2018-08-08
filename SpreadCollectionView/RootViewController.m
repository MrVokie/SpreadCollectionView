//
//  RootViewController.m
//  Lesson_collectionView
//
//  Created by Vokie on 15/7/1.
//  Copyright (c) 2015年 Vokie. All rights reserved.
//

#import "RootViewController.h"
#import "FooterView.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
#import "UIViewAdditions.h"
#import "MainModel.h"
#import "DetailModel.h"

@interface RootViewController ()

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *sectionAry;
@property (nonatomic, retain) NSMutableArray *listAry;
@property (nonatomic, retain) NSMutableArray *detailAry;
@property (nonatomic, retain) DetailViewController *secondVC;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, retain) NSIndexPath *index;

@property (nonatomic, assign) NSIndexPath *previousIndex;
@end


@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"折叠展开演示";
    
    self.previousIndex = nil;
    //初始化CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 8, kScreenWidth, self.view.frame.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell样式
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"BigCategoryCell"];
    
    //注册页脚
    [self.collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    //获取数据(本地plist文件)
    [self getDataFromLocal];
    
    //创建小视图控制器, 并作为本视图控制器的子视图控制器
    self.secondVC = [DetailViewController new];
    [self addChildViewController:self.secondVC];
    
}


#pragma mark - UICollectionViewDataSource

//计算大分类行数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.listAry.count % kItem_Number == 0) {
        return self.listAry.count / kItem_Number;
    }
    
    return self.listAry.count / kItem_Number + 1;
    
}

//计算每行的数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.listAry.count > 0) {
        if (section == self.listAry.count / kItem_Number) {
            if (self.listAry.count % kItem_Number == 0) {
                return kItem_Number;
            }
            
            return self.listAry.count % kItem_Number;
        }
        return kItem_Number;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigCategoryCell" forIndexPath:indexPath];
    
    cell.isHiddened = YES;
    
    if (indexPath == self.index) {
        if (self.isSelected) {
            cell.isHiddened = NO;
        }
    }
    
    if (self.listAry.count > 0) {
        MainModel *main = self.listAry[indexPath.row + indexPath.section * kItem_Number];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", main.name];
    }
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
    //将第二视图控制器的view添加到Footer Section
    [footerView addSubview:self.secondVC.view];
    footerView.clipsToBounds = YES;
    
    return footerView;
}


#pragma mark - 获取详情列表数据，本地plist加载

- (void)getDataFromLocal {
    NSString *filePathLocal = [[NSBundle mainBundle] pathForResource:@"LocalData" ofType:@"plist"];
    
    if (filePathLocal) {
        NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:filePathLocal];
        NSDictionary *localDic = tempDic[@"localData"];
        
        NSArray *dataAry = localDic[@"data"];
        
        for (NSDictionary *dic in dataAry) {
            
            MainModel *main = [[MainModel alloc] init];
            
            [main setValuesForKeysWithDictionary:dic];
            
            [self.listAry addObject:main];
        }
        
        [self.collectionView reloadData];
        
        return;
    }
}




#pragma mark - UICollectionViewDelegate 选中执行

- (void)JudgeSelected:(NSIndexPath *)indexPath {
    
    //始终保持数组中只有一个元素或则无元素
    if (self.sectionAry.count > 1) {
        [self.sectionAry removeObjectAtIndex:0];
    }
    
    if ([self.sectionAry containsObject:indexPath]) {
        self.isSelected = NO;
        [self.sectionAry removeObject:indexPath];
    }else{
        self.isSelected = YES;
        [self.sectionAry addObject:indexPath];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.index = indexPath;
    
    //掉用方法来判断选中状态和选中的分区
    [self JudgeSelected:indexPath];
    
    [self.detailAry removeAllObjects];
    
    MainModel *main = self.listAry[indexPath.row + indexPath.section * kItem_Number];
    
    //对二级数据重新组织
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *dic in main.secondgrade) {
        
        DetailModel *detail = [[DetailModel alloc] init];
        [detail setValuesForKeysWithDictionary:dic];
        [temp addObject:detail];
        if (temp.count >= 10) {
            [self.detailAry addObject:temp];
            temp = [NSMutableArray arrayWithCapacity:10];
        }
    }
    if (temp.count > 0) {
        [self.detailAry addObject:temp];
        temp = nil;
    }
    
    self.secondVC.dataAry = self.detailAry;
    
    [self.collectionView reloadData];
    self.secondVC.minView.contentOffset = CGPointMake(0, 0);
    //刷新子视图控制器
    [self.secondVC.minView reloadData];
}



#pragma mark - UICollectionViewDelegateFlowLayout - 动态布局

//动态设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth  / kItem_Number - 0.5, 30);
}


//动态设置每个分区的缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


//动态设置每个分区的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}


//动态设置不同区的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//动态设置区尾的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (self.sectionAry.count == 0 || self.isSelected == NO) {
        [self.secondVC.view removeFromSuperview];
        return CGSizeMake(0, 0);
    }
    
    if (section == [[self.sectionAry lastObject] section]) {
        
        
        if (self.detailAry.count > 1) {
            return CGSizeMake(kScreenWidth, 5 * kTableRow_Height + 20);
        }else{
            NSArray *tempArray = [self.detailAry firstObject];
            return CGSizeMake(kScreenWidth, (tempArray.count / 2 + (tempArray.count % 2 != 0)) * kTableRow_Height + 20);
            
        }
    }else{
        return CGSizeMake(0, 0);
    }
    
}

#pragma mark - settersAndgetters

- (NSMutableArray *)sectionAry
{
    
    if (!_sectionAry) {
        self.sectionAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _sectionAry;
}

- (NSMutableArray *)listAry
{
    if (!_listAry) {
        self.listAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _listAry;
}


- (NSMutableArray *)detailAry
{
    if (!_detailAry) {
        self.detailAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _detailAry;
}

@end
