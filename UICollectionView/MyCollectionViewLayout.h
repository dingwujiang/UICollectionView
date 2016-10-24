//
//  MyCollectionViewLayout.h
//  UICollectionView
//
//  Created by wujiang ding on 2016/10/23.
//  Copyright © 2016年 wujiang ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCollectionViewLayout;

@protocol waterFlowLayoutDelegate <NSObject>

@required
-(CGFloat)waterFlowLayout:(MyCollectionViewLayout *)layout hieghtForItemAtIndex:(NSUInteger)index itemwidth:(CGFloat)itemwidth;

@optional
-(NSInteger)waterFlowLayoutColumnCount:(MyCollectionViewLayout *)layout;
-(CGFloat)waterFlowLayoutColumnSpacing:(MyCollectionViewLayout *)layout;
-(CGFloat)waterFlowLayoutRowSpacing:(MyCollectionViewLayout *)layout;
-(UIEdgeInsets)waterFlowLayoutEdgeInsets:(MyCollectionViewLayout *)layout;

@end

@interface MyCollectionViewLayout : UICollectionViewLayout

@property (nonatomic,weak) id<waterFlowLayoutDelegate>delegate;

@end
