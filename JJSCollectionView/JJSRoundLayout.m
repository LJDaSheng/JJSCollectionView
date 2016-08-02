//
//  JJSRoundLayout.m
//  JJSCollectionView
//
//  Created by 贾菊盛 on 16/4/26.
//  Copyright © 2016年 贾菊盛. All rights reserved.
//

#import "JJSRoundLayout.h"

@implementation JJSRoundLayout
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexpath];
        [arrayM addObject:attri];;
    }
    return arrayM;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat radius = 120;
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];

    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.size = CGSizeMake(50, 50);
    if (count == 1) {
        attri.center = CGPointMake(centerX, centerY);
    }else{
        CGFloat angle = (2 * M_PI /count ) * indexPath.item;
        CGFloat attriCenterX = centerX - radius * cos(angle);
        CGFloat attriCenterY = centerY - radius * sin(angle);
        attri.center = CGPointMake(attriCenterX, attriCenterY);
    }
    return attri;
}
@end
