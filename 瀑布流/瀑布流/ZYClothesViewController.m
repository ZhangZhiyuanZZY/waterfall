//
//  ZYClothesViewController.m
//  瀑布流
//
//  Created by 章芝源 on 15/11/2.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYClothesViewController.h"
#import "ZYWaterfallFlowLayout.h"
#import "ZYClothesCell.h"
#import <MJExtension.h>
#import "ZYClothes.h"
@interface ZYClothesViewController ()<ZYWaterfallFlowLayoutDelegate>
///衣服模型数组
@property(nonatomic, strong)NSMutableArray *clothesArray;
@end

@implementation ZYClothesViewController

- (NSMutableArray *)clothesArray
{
    if (!_clothesArray) {
        _clothesArray = [[NSMutableArray alloc]init];
    }
    return _clothesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 切换布局
    ZYWaterfallFlowLayout *layout = [[ZYWaterfallFlowLayout alloc] init];
    layout.delegate = self;
    self.collectionView.collectionViewLayout = layout;
    
    ///字典转模型
    NSArray *temArray = [ZYClothes objectArrayWithFilename:@"clothes.plist"];
#warning 数组和数组直接不能直接赋值吗
//    self.clothesArray = temArray; 不能这样直接复制
    [self.clothesArray addObjectsFromArray:temArray];
}

#pragma mark <HMWaterfallFlowLayoutDelegate>
- (CGFloat)waterfallFlowLayout:(ZYWaterfallFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width {
    ZYClothes *clothes = self.clothesArray[indexPath.item];
    return clothes.h * width / clothes.w;
}

- (NSUInteger)columnCountInWaterfallFlowLayout:(ZYWaterfallFlowLayout *)layout {
    return 4;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.clothesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYClothesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClothesCell" forIndexPath:indexPath];
    
    cell.clothes = self.clothesArray[indexPath.item];
    
    cell.backgroundColor = [UIColor redColor];
    
    
    return cell;
}




@end
