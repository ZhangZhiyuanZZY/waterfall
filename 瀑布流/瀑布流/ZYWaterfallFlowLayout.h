//
//  ZYWaterfallFlowLayout.h
//  瀑布流
//
//  Created by 章芝源 on 15/11/2.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYWaterfallFlowLayout;
@protocol ZYWaterfallFlowLayoutDelegate <NSObject>

@required
/**
 *  返回indexPath位置cell的高度
 */
- (CGFloat)waterfallFlowLayout:(ZYWaterfallFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width;



@optional
// 粗粒度设计：一个方法搞定所有数据，要求一次性返回所有数据
// 细粒度设计：一个方法对应一个数据，需要设置哪个数据就去实现哪个方法
/**
 *  返回布局的行间距
 */
- (CGFloat)rowSpacingInWaterfallFlowLayout:(ZYWaterfallFlowLayout *)layout;

/**
 *  返回布局的列间距
 */
- (CGFloat)columnSpacingInWaterfallFlowLayout:(ZYWaterfallFlowLayout *)layout;

/**
 *  返回布局的边距
 */
- (UIEdgeInsets)edgeInsetsInWaterfallFlowLayout:(ZYWaterfallFlowLayout *)layout;

/**
 *  返回布局的列数
 */
- (NSUInteger)columnCountInWaterfallFlowLayout:(ZYWaterfallFlowLayout *)layout;


@end
@interface ZYWaterfallFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<ZYWaterfallFlowLayoutDelegate> delegate;

@end
