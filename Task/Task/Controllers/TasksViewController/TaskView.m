//
//  TaskView.m
//  Task
//
//  Created by Slava on 5/17/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "TaskView.h"
#import "Task.h"

@implementation TaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat positionX = frame.size.width / 3;
        CGFloat offSetPositionY = frame.size.height / 3;
        CGFloat border = 10.0f;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(positionX ,
                                                           self.bounds.origin.y + border ,
                                                           positionX * 2 - border,
                                                           offSetPositionY - (border * 2))];
        //_title.backgroundColor = [UIColor grayColor];
        _descriptions = [[UILabel alloc] initWithFrame:CGRectMake(positionX,
                                                                  offSetPositionY,
                                                                  positionX * 2 - border,
                                                                  offSetPositionY - border)];
        //_descriptions.backgroundColor = [UIColor grayColor];
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(positionX,
                                                            offSetPositionY * 2,
                                                            positionX * 2 - border,
                                                            offSetPositionY - border)];
        //_detail.backgroundColor = [UIColor grayColor];
//        _flagView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x + border,
//                                                                   self.bounds.origin.y + border,
//                                                                   offSetPositionY * 3 - (border * 2),
//                                                                   offSetPositionY * 3 - (border * 2))];
        //_flagView.backgroundColor = [UIColor lightGrayColor];
        //_flagView.layer.cornerRadius = 10;
        //_flagView.layer.masksToBounds = YES;
        
        CALayer *layer = self.layer;
        [layer setBorderWidth:0.4];
        layer.borderColor=[[UIColor lightGrayColor] CGColor];

    }
    return self;
}



- (void)addSubViews {
    [self addSubview:self.title];
    [self addSubview:self.descriptions];
    [self addSubview:self.detail];
    [self addSubview:self.flagView];
}

- (void)setValueInSubviewsTitle:(NSString*)title description:(NSString*)description detail:(NSString*)detail{ //imageView:(UIImageView*)imageView {
    
    self.title.text = title;
    self.descriptions.text = description;
    self.detail.text = detail;
   // self.imageView = imageView;
}

-(void)updateViewWithTask:(Task*) task {
    self.title.text = task.title;
    self.descriptions.text = task.descript;
    self.detail.text = task.details;
    self.flagView = task.flag;
    
    CGFloat offSetPositionY = self.frame.size.height / 3;
    CGFloat border = 10.0f;
    
    [_flagView setFrame:CGRectMake(self.bounds.origin.x + border,self.bounds.origin.y + border, offSetPositionY * 3 - (border * 2), offSetPositionY * 3 - (border * 2))];
    [self addSubview:_flagView];
}

@end
