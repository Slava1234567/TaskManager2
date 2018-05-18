//
//  TaskView.m
//  Task
//
//  Created by Slava on 5/17/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "TaskView.h"

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
        _title.backgroundColor = [UIColor grayColor];
        _descriptions = [[UILabel alloc] initWithFrame:CGRectMake(positionX,
                                                                  offSetPositionY,
                                                                  positionX * 2 - border,
                                                                  offSetPositionY - border)];
        _descriptions.backgroundColor = [UIColor grayColor];
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(positionX,
                                                            offSetPositionY * 2,
                                                            positionX * 2 - border,
                                                            offSetPositionY - border)];
        _detail.backgroundColor = [UIColor grayColor];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x + border,
                                                                   self.bounds.origin.y + border,
                                                                   positionX - (border * 2) ,
                                                                   offSetPositionY * 3 - (border * 2))];
        _imageView.backgroundColor = [UIColor blueColor];
        _imageView.layer.cornerRadius = 10;
        _imageView.layer.masksToBounds = YES;

    }
    return self;
}



- (void)addSubViews {
    [self addSubview:self.title];
    [self addSubview:self.descriptions];
    [self addSubview:self.detail];
    [self addSubview:self.imageView];
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
}

@end
