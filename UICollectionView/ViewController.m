//
//  ViewController.m
//  UICollectionView
//
//  Created by wujiang ding on 2016/10/23.
//  Copyright © 2016年 wujiang ding. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewLayout.h"
@interface ViewController ()<UICollectionViewDataSource,waterFlowLayoutDelegate>

@end

static NSString * const cellIdentifier = @"cellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MyCollectionViewLayout * layout = [[MyCollectionViewLayout alloc]init];
    [layout setDelegate:self];
    UICollectionView * collectionView =[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    [self.view  addSubview:collectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  - UICollectionView dataSource -
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
    
    NSInteger tag = 100;
    UILabel * label =[cell.contentView viewWithTag:tag];
    if (!label) {
        label = [[UILabel alloc]init];
        [label setTag:100];
        [cell.contentView addSubview:label];
    }
    [label setText:[NSString stringWithFormat:@"%zd",indexPath.item]];
    [label sizeToFit];
    return cell;
}

#pragma mark - waterFlowLayout Delegate -

-(NSInteger)waterFlowLayoutColumnCount:(MyCollectionViewLayout *)layout{
    return 2;
}

-(CGFloat)waterFlowLayout:(MyCollectionViewLayout *)layout hieghtForItemAtIndex:(NSUInteger)index itemwidth:(CGFloat)itemwidth{
    
    return 100+arc4random_uniform(150);
}

-(CGFloat)waterFlowLayoutRowSpacing:(MyCollectionViewLayout *)layout{
    return 5;
}

-(CGFloat)waterFlowLayoutColumnSpacing:(MyCollectionViewLayout *)layout{
    return 10;
}

@end












