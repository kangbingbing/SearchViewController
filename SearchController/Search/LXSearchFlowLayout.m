//
//  LXSearchFlowLayout.m
//  lxtx
//
//  Created by rrkj on 2018/5/23.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "LXSearchFlowLayout.h"

@implementation LXSearchFlowLayout

- (void)prepareLayout{
    
    [super prepareLayout];
    self.minimumLineSpacing = 15;
    self.minimumInteritemSpacing = 15;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        
        if (prevLayoutAttributes.indexPath.section == currentLayoutAttributes.indexPath.section) {
            // 间距
            CGFloat max = self.minimumLineSpacing;
            // 左边cell的最大值
            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
            // 没有超出范围, 继续往后布局
            if((origin + max + currentLayoutAttributes.frame.size.width) < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + max;
                currentLayoutAttributes.frame = frame;
            }// 超出范围自动下一行
        }
    }
    return attributes;
}

@end
