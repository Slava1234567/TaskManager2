//
//  IconView.m
//  Task
//
//  Created by Алексей on 19.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "IconView.h"

@implementation IconView


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
    
    // Draw outer circle
    CGFloat cirlceRadius = 0.45 * self.bounds.size.width;
    CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.width/2, cirlceRadius, M_PI, 4 * M_PI, 0);
    CGContextStrokePath(context);
    
    // Draw list rectangle
    CGFloat listWidth = 0.45 * self.bounds.size.width;
    CGFloat listHeight = 0.50 * self.bounds.size.height;
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 - listWidth/2, self.bounds.size.height/2 + listHeight/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 - listWidth/2, self.bounds.size.height/2 - listHeight/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + listWidth/2, self.bounds.size.height/2 - listHeight/2);
    CGContextAddLineToPoint(context, self.bounds.size.width/2 + listWidth/2, self.bounds.size.height/2 + listHeight/2);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.bounds.size.width/2 - listWidth/4, self.bounds.size.height/2 - listHeight/2);
    CGContextAddQuadCurveToPoint(context, self.bounds.size.width/2, self.bounds.size.height/2 - listHeight/2 - listWidth/3, self.bounds.size.width/2 + listWidth/4, self.bounds.size.height/2 - listHeight/2);
    CGContextStrokePath(context);
    
    // Draw check marks and tasks in list rectangle
    CGFloat y = self.bounds.size.height/2 - listHeight/4;
    for (int i = 0; i < 3; i++) {
        CGContextMoveToPoint(context, self.bounds.size.width/2, y);
        CGContextAddLineToPoint(context, self.bounds.size.width/2 + listWidth/3, y);
        CGContextStrokePath(context);
        
        CGContextSetLineWidth(context, 0.01 * self.bounds.size.width);
        CGContextMoveToPoint(context, self.bounds.size.width/2 - listWidth/3, y);
        CGContextAddLineToPoint(context, self.bounds.size.width/2 - listWidth/3 + listWidth/13, y + listWidth/13);
        CGContextAddLineToPoint(context, self.bounds.size.width/2 - listWidth/3 + 3 * listWidth/13, y - listWidth/13);
        CGContextStrokePath(context);
        
        CGContextSetLineWidth(context, 0.03 * self.bounds.size.width);
        y += listHeight/4;
    }
    
}


@end
