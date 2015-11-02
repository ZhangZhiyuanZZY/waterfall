//
//  ZYClothesViewController.m
//  瀑布流
//
//  Created by 章芝源 on 15/11/2.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYClothesViewController.h"
#import "ZYWaterfallFlowLayout.h"
@interface ZYClothesViewController ()

@end

@implementation ZYClothesViewController

static NSString * const reuseIdentifier = @"ClothesCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.collectionViewLayout = [[ZYWaterfallFlowLayout alloc]init];
   
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    
    return cell;
}




@end
