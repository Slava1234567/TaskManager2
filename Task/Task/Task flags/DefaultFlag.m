//
//  DefaultFlag.m
//  Task
//
//  Created by Алексей on 20.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "DefaultFlag.h"

@implementation DefaultFlag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:163.0/255.0 blue:150.0/255.0 alpha:1];
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
    
    CGFloat listWidth = self.bounds.size.width * 1.5;
    CGFloat y = self.bounds.size.height/2;
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 - listWidth/9, y);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - listWidth/9 + listWidth/13, y + listWidth/13);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - listWidth/9 + 3 * listWidth/13, y - listWidth/13);
    CGContextStrokePath(context);
}

@end
