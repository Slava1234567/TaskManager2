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
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        self.layer.cornerRadius = self.bounds.size.width/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
