//
//  ViewController.m
//  JJSCollectionView
//
//  Created by 贾菊盛 on 16/4/26.
//  Copyright © 2016年 贾菊盛. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "JJSCryleLayout.h"
#import "JJSRoundLayout.h"

NSString *const reUsedID = @"reUsedID";
@interface ViewController ()<UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collection;
@property(nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    [self.view addSubview:self.collection];
    NSLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark collection DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reUsedID forIndexPath:indexPath];
    cell.img = self.imageArray[indexPath.item];
    
    return cell;
}
#pragma Mark 懒加载
- (UICollectionView *)collection{
    if (!_collection) {
        JJSCryleLayout *layout = [[JJSCryleLayout alloc]init];
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, 375, 175) collectionViewLayout:layout];
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor colorWithRed:148/255.f green:231/255.f blue:109/255.f alpha:1.f];
        [_collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reUsedID];
    }
    return _collection;
}
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithCapacity:20];
        for (int i=1; i<=20; i++) {
            [_imageArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _imageArray;
}
@end
