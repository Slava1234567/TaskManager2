//
//  FamilyFlag.m
//  Task
//
//  Created by Алексей on 20.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "FamilyFlag.h"

@implementation FamilyFlag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:152.0/255.0 blue:200.0/255.0 alpha:1];
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
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 + 0.1 * multiplier, self.bounds.size.height/2 + 3 * multiplier);
    CGContextAddCurveToPoint(context, self.bounds.size.width/2 - 5 * multiplier, self.bounds.size.height/2 - 1.5 * multiplier, self.bounds.size.width/2 - 2 * multiplier, self.bounds.size.height/2 - 4 * multiplier, self.bounds.size.width/2 + 0.1 * multiplier, self.bounds.size.height/2 - 2 * multiplier);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2  - 0.1 * multiplier, self.bounds.size.height/2 + 3 * multiplier);
    CGContextAddCurveToPoint(context, self.bounds.size.width/2 + 5 * multiplier, self.bounds.size.height/2 - 1.5 * multiplier, self.bounds.size.width/2 + 2 * multiplier, self.bounds.size.height/2 - 4 * multiplier, self.bounds.size.width/2  - 0.1 * multiplier, self.bounds.size.height/2 - 2 * multiplier);
    CGContextStrokePath(context);
}

@end
