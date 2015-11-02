//
//  ZYWaterfallFlowLayout.m
//  瀑布流
//
//  Created by 章芝源 on 15/11/2.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYWaterfallFlowLayout.h"

@implementation ZYWaterfallFlowLayout

///说明所有元素最终显示出来的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //创建数组
    NSMutableArray *array = [NSMutableArray array];
    //取得item总数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //遍历将每一个属性做修改
    for (int i = 0; i < count ; i++ ) {
        //获得i对应的indexpath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //拿到修改后的属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        //添加到数组
        [array addObject:attrs];
    }

    //返回数组
    return array;
}


///说明indexpath位置cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ///拿到indexPath位置的属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.center = CGPointMake(100, 100);
    attrs.size = CGSizeMake(100, 100);
    
    return attrs;
}

@end
