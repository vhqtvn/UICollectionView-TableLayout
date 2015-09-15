//
//  TableCollectionViewCell.m
//  CollectionViewTest
//
//  Created by Hoa Nguyen Van on 9/15/15.
//  Copyright (c) 2015 vhn.vn. All rights reserved.
//

#import "TableCollectionViewCell.h"

@interface TableCollectionViewCell()
{
    int currentGeneration;
    int lastUpdateGeneration;
}
@end

@implementation TableCollectionViewCell
-(void)newOccupied
{
    currentGeneration++;
}
-(BOOL)checkIfNeedUpdate
{
    if(lastUpdateGeneration!=currentGeneration){
        lastUpdateGeneration = currentGeneration;
        [self setNeedsDisplay];
        return YES;
    }
    return NO;
}
-(void)drawRect:(CGRect)rect
{
    rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont fontWithName:@"Helvetica" size:12] forKey:NSFontAttributeName];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    [attributes setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
    [self.text drawInRect:rect withAttributes:attributes];
}
@end
