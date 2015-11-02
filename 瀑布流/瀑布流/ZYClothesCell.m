//
//  ZYClothesCell.m
//  瀑布流
//
//  Created by 章芝源 on 15/11/2.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYClothesCell.h"
#import "ZYClothes.h"
#import <UIImageView+WebCache.h>
@interface ZYClothesCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewClothesCell;
@property (weak, nonatomic) IBOutlet UILabel *clothesCellLabel;

@end

@implementation ZYClothesCell

- (void)setClothes:(ZYClothes *)clothes
{
    _clothes = clothes;
    
    //设置图片   设置方法可以设置占位图片, 当图片还没有加载好的时候,  先显示占位图
    [self.imageViewClothesCell sd_setImageWithURL:[NSURL URLWithString:clothes.img] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    
    //设置价格
    self.clothesCellLabel.text = clothes.price;
}




@end
