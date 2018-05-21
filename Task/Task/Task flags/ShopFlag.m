//
//  ShopFlag.m
//  Task
//
//  Created by Алексей on 20.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "ShopFlag.h"

@implementation ShopFlag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:225.0/255.0 blue:175.0/255.0 alpha:1];
        self.layer.cornerRadius = self.bounds.size.width/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextSetLineWidth(context, 0.03 * self.bounds.size.width);
    
    CGFloat multiplier = self.bounds.size.width/15;
    
    CGContextMoveToPoint(context, 4.5 * multiplier, 5 * multiplier);
    CGContextAddLineToPoint(context, 5.5 * multiplier, 9 * multiplier);
    CGContextAddLineToPoint(context, 9.5 * multiplier, 9 * multiplier);
    CGContextAddLineToPoint(context, 10 * multiplier, 6 * multiplier);
    CGContextAddLineToPoint(context, 4.8 * multiplier, 6 * multiplier);
    CGContextStrokePath(context);
    
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextAddArc(context, 6.2 * multiplier, 10 * multiplier, 0.4 * multiplier, M_PI, 4 * M_PI, 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 8.8 * multiplier, 10 * multiplier, 0.4 * multiplier, M_PI, 4 * M_PI, 0);
    CGContextFillPath(context);
}

@end
