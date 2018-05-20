//
//  HomeFlag.m
//  Task
//
//  Created by Алексей on 20.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "HomeFlag.h"

@implementation HomeFlag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:83.0/255.0 blue:87.0/255.0 alpha:1];
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
    
    CGFloat houseWidth = 0.3 * self.bounds.size.width;
    CGFloat multiplier = houseWidth/6;
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 + houseWidth/2, self.bounds.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + houseWidth/2, self.bounds.size.height/2 + houseWidth * 0.6);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - houseWidth/2, self.bounds.size.height/2 + houseWidth * 0.6);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - houseWidth/2, self.bounds.size.height/2);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 + multiplier, self.bounds.size.height/2 + houseWidth * 0.6);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + multiplier, self.bounds.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - multiplier, self.bounds.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - multiplier, self.bounds.size.height/2 + houseWidth * 0.6);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 - houseWidth/2 - multiplier, self.bounds.size.height/2 + multiplier);
    CGContextAddLineToPoint(context, self.bounds.size.width/2, self.bounds.size.height/2 - houseWidth/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + houseWidth/2 + multiplier, self.bounds.size.height/2 + multiplier);
    CGContextStrokePath(context);
}


@end
