//
//  TableCollectionViewCell.h
//  CollectionViewTest
//
//  Created by Hoa Nguyen Van on 9/15/15.
//  Copyright (c) 2015 vhn.vn. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TableCollectionViewCellBordersMask
{
    TableCollectionViewCellBorderLeft=1,
    TableCollectionViewCellBorderRight=2,
    TableCollectionViewCellBorderUp=4,
    TableCollectionViewCellBorderDown=8,
};

@interface TableCollectionViewCell : UICollectionViewCell
@property(retain,nonatomic) NSString* text;
@property(nonatomic) NSIndexPath* indexPath;
@property(nonatomic) int borderMask;
-(void)newOccupied;
-(BOOL)checkIfNeedUpdate;
@end
