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
// 每一列的最大y坐标
@property(nonatomic, strong)NSMutableArray *columnMaxYArray;
///存放所有cell的布局属性
@property (nonatomic, strong)NSMutableArray *attrsArray;
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

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc]init];
    }
    return _attrsArray;
}



/**
 *  决定CollectionView的ContentSize
 */
#warning TODO什么时候被调用的?
- (CGSize)collectionViewContentSize
{
    //找到最长那一列最大y坐标
    CGFloat destColumnMaxY = [self.columnMaxYArray[0] doubleValue];
    for (int i = 1; i < self.columnMaxYArray.count; i++) {
        CGFloat columnMaxY = [self.columnMaxYArray[i] doubleValue];
        if (columnMaxY > destColumnMaxY) {
            destColumnMaxY = columnMaxY;
        }
    }
    return CGSizeMake(ZYCollectionViewWidth, destColumnMaxY + ZYDefaultEdgeInsets.bottom);

}





///重置每一列的最大y坐标
///后面的cell的frame是根据前面的cell计算的所以, 就在本方法中一次性把所有cell的frame都计算出来
- (void)prepareLayout
{
    [super prepareLayout];
    ///当刷新, 或等等原因, 布局发生改变的时候  重置每一类的最大y坐标, 反正都要从头开始计算
    [self.columnMaxYArray removeAllObjects];
    for (int i = 0; i < ZYDefaultColumnCount; i++ ) {
        [self.columnMaxYArray addObject:@(0)];
    }
    
    //计算所有的布局属性.
    [self.attrsArray removeAllObjects];
    
    //在preparelayout方法中把所有的属性都先计算出来, 存在一个数组中, 当需要用的时候, 从数组中取出
    //取得item总数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];

    //遍历将每一个属性做修改
    for (int i = 0; i < count ; i++ ) {
        //获得i对应的indexpath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //拿到修改后的属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        //添加到数组
        [self.attrsArray addObject:attrs];
    }

}


///说明所有元素最终显示出来的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //创建数组
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.attrsArray.count ; i++ ) {
        UICollectionViewLayoutAttributes *attrs = self.attrsArray[i];
        if (CGRectIntersectsRect(rect, attrs.frame)) {
            [array addObject:attrs];
        }
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
#warning 为什么要使用@( ) 包装 ,CGFloat类型的需要包装?
    self.columnMaxYArray[destColumnIndex] = @(CGRectGetMaxY(attrs.frame));
    return attrs;

}

@end
