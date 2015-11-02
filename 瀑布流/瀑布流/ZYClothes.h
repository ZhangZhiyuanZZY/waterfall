//
//  ZYClothes.h
//  瀑布流
//
//  Created by 章芝源 on 15/11/2.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYClothes : NSObject
// 宽度
@property (nonatomic, assign) CGFloat w;
// 高度
@property (nonatomic, assign) CGFloat h;
// 图片
@property (nonatomic, copy) NSString *img;
// 价格
@property (nonatomic, copy) NSString *price;

@end
