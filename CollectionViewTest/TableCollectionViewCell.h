//
//  TableCollectionViewCell.h
//  CollectionViewTest
//
//  Created by Hoa Nguyen Van on 9/15/15.
//  Copyright (c) 2015 vhn.vn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCollectionViewCell : UICollectionViewCell
@property(retain,nonatomic) NSString* text;
@property(nonatomic) NSIndexPath* indexPath;
-(void)newOccupied;
-(BOOL)checkIfNeedUpdate;
@end
