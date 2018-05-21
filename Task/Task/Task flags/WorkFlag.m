//
//  WorkFlag.m
//  Task
//
//  Created by Алексей on 20.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "WorkFlag.h"

@implementation WorkFlag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:252.0/255.0 green:156.0/255.0 blue:96.0/255.0 alpha:1];
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
    
    CGFloat width = 0.35 * self.bounds.size.width;
    CGFloat height = 0.25 * self.bounds.size.height;
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 - width/2, self.bounds.size.height/2 - height/2 + height/5);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + width/2, self.bounds.size.height/2 - height/2 + height/5);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + width/2, self.bounds.size.height/2 + height/2 + height/5);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - width/2, self.bounds.size.height/2 + height/2 + height/5);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 - width/4, self.bounds.size.height/2 - height/2 + height/5);
    CGContextAddQuadCurveToPoint(context, self.bounds.size.width/2, self.bounds.size.height/2 - height/1.2, self.bounds.size.width/2 + width/4, self.bounds.size.height/2 - height/2 + height/5);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 - width/10, self.bounds.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + width/10, self.bounds.size.height/2);
    CGContextStrokePath(context);
}

@end
