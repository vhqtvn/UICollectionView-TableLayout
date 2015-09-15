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
    
    [self.text drawInRect:CGRectInset(rect, 5, 5) withAttributes:attributes];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor] );
    if(self.borderMask&TableCollectionViewCellBorderLeft)
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect)), CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    if(self.borderMask&TableCollectionViewCellBorderRight)
        CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect)), CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    if(self.borderMask&TableCollectionViewCellBorderUp)
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect)), CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    if(self.borderMask&TableCollectionViewCellBorderDown)
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect)), CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath(context);
    if(~self.borderMask&TableCollectionViewCellBorderLeft)
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect)), CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    if(~self.borderMask&TableCollectionViewCellBorderRight)
        CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect)), CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    if(~self.borderMask&TableCollectionViewCellBorderUp)
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect)), CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    if(~self.borderMask&TableCollectionViewCellBorderDown)
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect)), CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetLineWidth(context, 0.5);
    CGContextStrokePath(context);
}
@end
