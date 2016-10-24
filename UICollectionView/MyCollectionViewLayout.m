//
//  MyCollectionViewLayout.m
//  UICollectionView
//
//  Created by wujiang ding on 2016/10/23.
//  Copyright © 2016年 wujiang ding. All rights reserved.
//

#import "MyCollectionViewLayout.h"

static NSInteger const DefaultsColumnCount = 5;
static CGFloat  const DefalutsColumnSpacing = 10;
static CGFloat const DefaultsRowSpacing = 10;
static UIEdgeInsets const DefaultsEdgeInsets = {10,10,10,10};



@interface MyCollectionViewLayout ()

@property (nonatomic,strong) NSMutableArray * arrArray;
@property (nonatomic,strong) NSMutableArray * maxArray;

-(NSInteger)columnCount;
-(CGFloat)columnSpacing;
-(CGFloat)rowSpacing;
-(UIEdgeInsets)edgeInsets;


@end

@implementation MyCollectionViewLayout

-(NSInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnCount:)]) {
        return [self.delegate waterFlowLayoutColumnCount:self];
    }
    return DefaultsColumnCount;
}
-(CGFloat)columnSpacing{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnSpacing:)]) {
        return [self.delegate waterFlowLayoutColumnSpacing:self];
    }
    return DefalutsColumnSpacing;
}
-(CGFloat)rowSpacing{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutRowSpacing:)]) {
        return [self.delegate waterFlowLayoutRowSpacing:self];
    }
    return DefaultsRowSpacing;
}
-(UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutEdgeInsets:)]) {
        return [self.delegate waterFlowLayoutEdgeInsets:self];
    }
    return DefaultsEdgeInsets;
}

-(NSMutableArray *)maxArray{
    if (!_maxArray) {
        _maxArray =[NSMutableArray array];
    }
    return _maxArray;
}

-(NSMutableArray *)arrArray{
    if (!_arrArray) {
        _arrArray =[NSMutableArray array];
    }
    return _arrArray;
}

-(void)prepareLayout{
    [super prepareLayout];
   
    [self.arrArray removeAllObjects];
    [self.maxArray removeAllObjects];
    
    for (NSInteger i=0; i<[self columnCount]; i++) {
        [self.maxArray addObject:@([self edgeInsets].top)];
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<itemCount; i++){
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.arrArray  addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.arrArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attributibutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger __block minHeightColumn = 0;
    NSInteger __block minHeight  = [self.maxArray[minHeightColumn] floatValue];
    
    [self.maxArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight =[(NSNumber *)obj floatValue];
//        NSLog(@"obg = %@ idx = %zd  stop = %@",obj,idx,stop);
        if (minHeight>columnHeight) {
            minHeight = columnHeight;
            minHeightColumn = idx;
        }
    }];
    
    UIEdgeInsets  engeInsets = [self edgeInsets];
    
    CGFloat  width =(CGRectGetWidth(self.collectionView.frame) - engeInsets.right - engeInsets.left-([self columnCount] -1) * [self columnSpacing]) / [self columnCount];
    
    CGFloat height = [self.delegate waterFlowLayout:self hieghtForItemAtIndex:indexPath.item itemwidth:width];
    
    CGFloat originX = engeInsets.left +minHeightColumn * (width + [self columnSpacing]);
    CGFloat originY = minHeight;
    if (originY!=engeInsets.top) {
        originY += [self rowSpacing];
    }
    [attributibutes setFrame:CGRectMake(originX, originY, width, height)];
    self.maxArray[minHeightColumn] = @(CGRectGetMaxY(attributibutes.frame));
    return attributibutes;
}

-(CGSize)collectionViewContentSize{
    NSInteger __block maxHeight = 0;
    
    
    [self.maxArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight =[(NSNumber *)obj floatValue];
        //        NSLog(@"obg = %@ idx = %zd  stop = %@",obj,idx,stop);
        if (maxHeight<columnHeight) {
            maxHeight = columnHeight;
        }
    }];
    return CGSizeMake(0, maxHeight+[self edgeInsets].bottom);
}

@end





















