//
//  JJSCryleLayout.m
//  JJSCollectionView
//
//  Created by 贾菊盛 on 16/4/26.
//  Copyright © 2016年 贾菊盛. All rights reserved.
//

#import "JJSCryleLayout.h"
#define collectionViewWidth  self.collectionView.frame.size.width
#define collectionViewHeight self.collectionView.frame.size.height
@implementation JJSCryleLayout
- (void)prepareLayout{
    [super prepareLayout];
    // 滑动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // item 大小
    CGFloat itemW = collectionViewWidth * 0.3;
    self.itemSize = CGSizeMake(itemW, itemW);
    // 组间的偏移量主要是为了解决第一个和最后一个贴边的问题
    CGFloat inset = (collectionViewWidth - itemW)*0.3;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}
/**
 * 返回collectionView每个item的布局属性
 * 此方法决定了collectionView的每个item怎样排列
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    // 因为是流水布局，父类已经做了排列 我们只是获取到每个item 的布局稍加修改
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 获取屏幕中间（collectionView 的中间的 偏移 x 值）
    CGFloat centerX = self.collectionView.contentOffset.x +collectionViewWidth * 0.5;
    CGFloat centerY = self.collectionView.contentOffset.y +collectionViewWidth * 0.5;
    
    // 对每一个item 布局进行补充
    for (UICollectionViewLayoutAttributes *attribute in array) {
        
        // 获取item 的中间和屏幕中间的距离
        CGFloat delta = ABS(centerX - attribute.center.x);
        
        // 计算缩放比例
        CGFloat scale = 1- delta/(collectionViewWidth + self.itemSize.width);
        //attribute.transform = CGAffineTransformMakeScale(scale, scale);
        CGPoint point = attribute.center;
        
       // CGFloat angle = (2 * M_PI /count ) * indexPath.item;
        CGFloat attriCenterX = centerX - 100 * cos(scale);
        CGFloat attriCenterY = centerY - delta * sin(scale);
        attribute.center = CGPointMake(attriCenterX, attriCenterY);
        attribute.center = CGPointMake(point.x, 100+point.y-attriCenterY);//scale*sin(delta));
//        CGSize size = attribute.size;
        attribute.size = CGSizeMake(80, 80);
    }
    
    return array.copy;
}
/**
 * 当UICollectionView的Bounds发生改变时会自动调用,刷新布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 * targetContentOffset ：通过修改后，collectionView最终的contentOffset(取决定情况)
 * proposedContentOffset ：默认情况下，collectionView最终的contentOffset
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    // 计算最终的可见范围，先获取默认的范围和item的大小
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    // 获得collectionView最中间的X值
    CGFloat centerX = proposedContentOffset.x + collectionViewWidth * 0.5;
    // 获取item 的中间和屏幕中间的距离
    CGFloat delta = ABS(centerX - rect.origin.x);
    
    // 取出可见范围内item的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    
    // 计算item 的中间x 和 collectionView 的中间x 的差
    CGFloat minDelta = 0.0;
    for (UICollectionViewLayoutAttributes *attri in array) {
        minDelta = attri.center.x - centerX;
    }
    
    // 调整offset 使item 居中
    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
}
@end
