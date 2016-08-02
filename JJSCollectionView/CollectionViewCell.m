//
//  CollectionViewCell.m
//  JJSCollectionView
//
//  Created by 贾菊盛 on 16/4/26.
//  Copyright © 2016年 贾菊盛. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell()
@property(nonatomic,strong)UIImageView *imgView;
@end
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imgView];
    }
    return self;
}
- (void)setImg:(NSString *)img{
    _img = [img copy];
    self.imgView.image = [UIImage imageNamed:img];
}
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imgView.layer.borderWidth = 5;
        _imgView.layer.borderColor = [UIColor orangeColor].CGColor;
        _imgView.layer.cornerRadius = 10;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}
@end
