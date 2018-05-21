//
//  TaskView.m
//  Task
//
//  Created by Slava on 5/17/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "TaskView.h"
#import "Task.h"

@interface TaskView()

@property (nonatomic, assign) CGPoint locationBounds;
@property (nonatomic, strong) UIView *deleteView;
@property (nonatomic, strong) UILabel *deleteLabel;

@end

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
        
        _deleteView = [[UIView alloc] init];
        _deleteView.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:70.0/255.0 blue:73.0/255.0 alpha:1];
        
        _deleteLabel = [[UILabel alloc] init];
        _deleteLabel.text = @"Delete";
        _deleteLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
        _deleteLabel.textColor = UIColor.whiteColor;
        _deleteLabel.textAlignment = NSTextAlignmentCenter;
        
        [_deleteView addSubview:_deleteLabel];
        
        [self addSubview:_deleteView];

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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _locationBounds = [[touches anyObject] locationInView:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint locationFrame = [[touches anyObject] locationInView:self.superview];
    CGFloat offset = _locationBounds.x + self.bounds.size.width;
    CGFloat labelWidth = self.bounds.size.width * 0.3;
    
    [self setFrame:CGRectMake(locationFrame.x - _locationBounds.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)];
    [_deleteView setFrame:CGRectMake(offset, self.bounds.origin.y, self.bounds.size.width - offset, self.bounds.size.height)];
    [_deleteLabel setFrame:CGRectMake(_deleteView.bounds.size.width/2 - labelWidth/2, _deleteView.bounds.size.height/2 - 10, labelWidth, 20)];
    
    if (locationFrame.x - _locationBounds.x + self.bounds.size.width < self.bounds.size.width/4) {
        [self removeFromSuperview];
        [_delegate taskViewDidRemoveFromSuperview: self];
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setFrame:CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)];
    [_deleteView setFrame:CGRectMake(self.bounds.size.width, self.frame.origin.y, 0, self.bounds.size.height)];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setFrame:CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)];
}

@end
