//
//  ZYWaterfallFlowLayout.m
//  瀑布流
//
//  Created by 章芝源 on 15/11/2.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYWaterfallFlowLayout.h"
#define ZYCollectionViewWidth self.collectionView.frame.size.width
// /默认行间距
static const CGFloat ZYDefaultRowSpacing = 10;
/// 默认列间距
static const CGFloat ZYDefaultColumnSpacing = 20;
///默认边距
static const UIEdgeInsets ZYDefaultEdgeInsets = {10, 10, 10, 10};
///默认列数
static const NSUInteger ZYDefaultColumnCount = 3;


@interface ZYWaterfallFlowLayout ()
///
@property(nonatomic, strong)NSMutableArray *columnMaxYArray;
@end

@implementation ZYWaterfallFlowLayout


///懒加载
- (NSMutableArray *)columnMaxYArray
{
    if (!_columnMaxYArray) {
        _columnMaxYArray = [[NSMutableArray alloc]init];
    }
    return _columnMaxYArray;
}



///重置每一列的最大y坐标
- (void)prepareLayout
{
    [super prepareLayout];
    ///当刷新, 或等等原因, 布局发生改变的时候  重置每一类的最大y坐标
    [self.columnMaxYArray removeAllObjects];
    for (int i = 0; i < ZYDefaultColumnCount; i++ ) {
        [self.columnMaxYArray addObject:@(0)];
    }
}





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
    
    // 计算indexPath位置cell的布局属性
    // 找出最短那一列的列号和最大y坐标
    CGFloat destColumnMaxY = [self.columnMaxYArray[0] doubleValue];
    NSUInteger destColumnIndex = 0;
    for (int i = 1; i < self.columnMaxYArray.count; i++) {
        CGFloat columnMaxY = [self.columnMaxYArray[i] doubleValue];
        if (columnMaxY < destColumnMaxY) {
            //记录最小的y
            destColumnMaxY = columnMaxY;
            ///最小列的索引
            destColumnIndex = i;
        }
    }
    //列边距
    CGFloat totalColumnSpacing = (ZYDefaultColumnCount - 1) * ZYDefaultColumnSpacing;
    CGFloat width = (ZYCollectionViewWidth - ZYDefaultEdgeInsets.left - ZYDefaultEdgeInsets.right - totalColumnSpacing) / ZYDefaultColumnCount;
#warning TODO
    CGFloat height = 50 + arc4random_uniform(150);
    CGFloat x = ZYDefaultEdgeInsets.left + destColumnIndex * (width + ZYDefaultColumnSpacing);
    CGFloat y = destColumnMaxY + ZYDefaultRowSpacing;
    attrs.frame = CGRectMake(x, y, width, height);
    // 更新最大y坐标
    self.columnMaxYArray[destColumnIndex] = @(CGRectGetMaxY(attrs.frame));
    return attrs;

}

@end
