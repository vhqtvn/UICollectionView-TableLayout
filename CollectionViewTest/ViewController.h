//
//  ViewController.h
//  CollectionViewTest
//
//  Created by Hoa Nguyen Van on 9/15/15.
//  Copyright (c) 2015 vhn.vn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property(retain,nonatomic) IBOutlet UICollectionView* collectionView;

@end

