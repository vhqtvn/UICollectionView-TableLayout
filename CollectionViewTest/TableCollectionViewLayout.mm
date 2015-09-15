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
    int iw=self.collectionView.frame.size.width/30;
    int ih=self.collectionView.frame.size.height/30;
    static int widths[]={iw,iw-1,iw+1};
    columnWidths.resize(self.collectionView.numberOfSections);
    columnOffset.resize(columnWidths.size());
    for(int i=0;i<self.collectionView.numberOfSections;i++){
        columnWidths[i]=widths[i%3];
        columnOffset[i]=width;
        width+=columnWidths[i];
    }
    height = 0;
    static int heights[]={ih,ih-1,ih+1};
    rowHeights.resize([self.collectionView numberOfItemsInSection:0]);
    rowOffset.resize(rowHeights.size());
    for(int i=0;i<[self.collectionView numberOfItemsInSection:0];i++){
        rowHeights[i]=heights[i%3];
        rowOffset[i]=height;
        height+=rowHeights[i];
    }
    self.cellDenseFactor = 1;
}
-(CGSize)collectionViewContentSize{
    return CGSizeMake(width, height);
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* elementsInRect = [NSMutableArray array];
    auto startColumn = std::lower_bound(columnOffset.begin(), columnOffset.end(), rect.origin.x)-columnOffset.begin();
    if(startColumn>0) startColumn--;
    auto startRow = std::lower_bound(rowOffset.begin(), rowOffset.end(), rect.origin.y)-rowOffset.begin();
    if(startRow>0) startRow--;
    int iSkip = MAX(1,self.cellDenseFactor);
    CGFloat xMax = rect.origin.x+rect.size.width, yMax = rect.origin.y+rect.size.height;
    NSUInteger i,j,iMax,jMax;
    for(i = startColumn, iMax=[self.collectionView numberOfSections]; i < iMax && columnOffset[i]<=xMax; i++)
    {
        if(i%iSkip) continue;
        for(j = startRow, jMax=[self.collectionView numberOfItemsInSection:i]; j < jMax && rowOffset[j]<=yMax; j++)
        {
            if(j%iSkip) continue;
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
