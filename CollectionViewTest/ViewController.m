//
//  ViewController.m
//  CollectionViewTest
//
//  Created by Hoa Nguyen Van on 9/15/15.
//  Copyright (c) 2015 vhn.vn. All rights reserved.
//

#import "ViewController.h"
#import "TableCollectionViewLayout.h"
#import "TableCollectionViewCell.h"

#define MAX_COLS 1000
#define MAX_ROWS 65000

@interface ViewController ()
{
    int value[MAX_COLS][MAX_ROWS];
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    memset(value, 0, sizeof(value));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateCellsForRow: (NSInteger)row andColumn: (NSInteger)column
{
    [self.collectionView.subviews enumerateObjectsUsingBlock:^(UIView* v, NSUInteger idx, BOOL *stop) {
        if([v isKindOfClass:[TableCollectionViewCell class]]){
            TableCollectionViewCell* cell = (TableCollectionViewCell*)v;
            if((row==NSNotFound || row==cell.indexPath.row)&&(column==NSNotFound || column==cell.indexPath.section)){
                cell.text = [NSString stringWithFormat:@"%d",value[cell.indexPath.section][cell.indexPath.row]];
                [cell setNeedsDisplay];
            }
        }
    }];
}
-(IBAction)addFirstCell:(id)sender
{
    value[0][0]++;
    [self updateCellsForRow:0 andColumn:0];
}
-(IBAction)addFirstRow:(id)sender
{
    for(int i=0;i<MAX_COLS;i++) value[i][0]++;
    [self updateCellsForRow:0 andColumn:NSNotFound];
}
-(IBAction)addFirstColumn:(id)sender
{
    for(int i=0;i<MAX_ROWS;i++) value[0][i]++;
    [self updateCellsForRow:NSNotFound andColumn:0];
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MAX_COLS;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section<MAX_COLS) return MAX_ROWS;
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.text = [NSString stringWithFormat:@"%d",value[indexPath.section][indexPath.row]];
    cell.indexPath = indexPath;
    [cell setNeedsDisplay];
    return cell;
}
#pragma mark UIColectionViewDelegate

#pragma mark UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    TableCollectionViewLayout* layout = (TableCollectionViewLayout*)self.collectionView.collectionViewLayout;
    layout.cellDenseFactor = 6;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    TableCollectionViewLayout* layout = (TableCollectionViewLayout*)self.collectionView.collectionViewLayout;
    layout.cellDenseFactor = 1;
    self.collectionView.backgroundColor = [UIColor colorWithRed:.8 green:1 blue:.5 alpha:1.];
    self.collectionView.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^(){
            self.collectionView.backgroundColor = [UIColor whiteColor];
            self.collectionView.userInteractionEnabled = YES;
        });
    });
}
@end
