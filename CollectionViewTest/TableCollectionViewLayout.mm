//
//  TableCollectionViewLayout.m
//  CollectionViewTest
//
//  Created by Hoa Nguyen Van on 9/15/15.
//  Copyright (c) 2015 vhn.vn. All rights reserved.
//
#include <vector>
#include <algorithm>
#import "TableCollectionViewLayout.h"

@interface TableCollectionViewLayout()
{
    int width, height;
    std::vector<int> rowHeights, rowOffset;
    std::vector<int> columnWidths, columnOffset;
}
@end


@implementation TableCollectionViewLayout
-(void)prepareLayout
{
    [super prepareLayout];
    width = 0;
    static int widths[]={40,60,100};
    columnWidths.resize(self.collectionView.numberOfSections);
    columnOffset.resize(columnWidths.size());
    for(int i=0;i<self.collectionView.numberOfSections;i++){
        columnWidths[i]=widths[i%3];
        columnOffset[i]=width;
        width+=columnWidths[i];
    }
    height = 0;
    static int heights[]={40,60,100};
    rowHeights.resize([self.collectionView numberOfItemsInSection:0]);
    rowOffset.resize(rowHeights.size());
    for(int i=0;i<[self.collectionView numberOfItemsInSection:0];i++){
        rowHeights[i]=heights[i%3];
        rowOffset[i]=height;
        height+=rowHeights[i];
    }
}
-(CGSize)collectionViewContentSize{
    return CGSizeMake(width, height);
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* elementsInRect = [NSMutableArray array];
    
    auto startColumn = std::lower_bound(columnOffset.begin(), columnOffset.end(), rect.origin.x)-columnOffset.begin();
    if(startColumn>0) startColumn--;
    CGFloat xMax = rect.origin.x+rect.size.width, yMax = rect.origin.y+rect.size.height;
    
    for(NSUInteger i = startColumn, iMax=[self.collectionView numberOfSections]; i < iMax && columnOffset[i]<=xMax; i++)
    {
        auto startRow = std::lower_bound(rowOffset.begin(), rowOffset.end(), rect.origin.y)-rowOffset.begin();
        if(startRow>0) startRow--;
        for(NSUInteger j = startRow, jMax=[self.collectionView numberOfItemsInSection:i]; j < jMax && rowOffset[j]<=yMax; j++)
        {
            CGRect cellFrame = CGRectMake(columnOffset[i],rowOffset[j],columnWidths[i], rowHeights[j]);
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            attr.frame = cellFrame;
            [elementsInRect addObject:attr];
        }
    }
    
    return elementsInRect;
}
@end
