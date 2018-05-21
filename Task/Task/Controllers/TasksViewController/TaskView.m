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
        
        self.backgroundColor = UIColor.whiteColor;
        
        CGFloat border = self.frame.size.width/30;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height * 0.7 + 2 * border,
                                                           self.bounds.origin.y + border,
                                                           self.bounds.size.width - (self.frame.size.height * 0.7 + 3 * border),
                                                           20)];
        
        _descriptions = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height * 0.7 + 2 * border,
                                                                  self.bounds.size.height - 40,
                                                                  self.bounds.size.width - (self.frame.size.height * 0.7 + 3 * border),
                                                                  20)];
        _descriptions.adjustsFontSizeToFitWidth = YES;
        
        CALayer *layer = self.layer;
        [layer setBorderWidth:0.4];
        layer.borderColor=[[UIColor lightGrayColor] CGColor];
        
        _deleteView = [[UIView alloc] init];
        _deleteView.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:70.0/255.0 blue:73.0/255.0 alpha:1];
        
        _deleteLabel = [[UILabel alloc] init];
        _deleteLabel.text = @"Delete";
        _deleteLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
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

-(void)updateViewWithTask:(Task*) task {
    self.title.text = task.title;
    self.descriptions.text = task.descript;
    self.detail.text = task.details;
    self.flagView = task.flag;
    
    CGFloat border = self.frame.size.width/30;
    
    CGFloat flagWidth = self.frame.size.height * 0.7;
    
    [_flagView setFrame:CGRectMake(self.bounds.origin.x + border,self.bounds.size.height/2 - flagWidth/2, flagWidth, flagWidth)];
    _flagView.layer.cornerRadius = _flagView.bounds.size.width/2;
    _flagView.layer.masksToBounds = YES;
    
    [self addSubview:_flagView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _locationBounds = [[touches anyObject] locationInView:self];
    if (touches.anyObject.tapCount == 2) {
        [_delegate editTaskAtIndex:self.tag];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint locationFrame = [[touches anyObject] locationInView:self.superview];
    CGFloat offset = _locationBounds.x + self.bounds.size.width;
    CGFloat labelWidth = self.bounds.size.width * 0.3;
    
    [self setFrame:CGRectMake(locationFrame.x - _locationBounds.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)];
    [_deleteView setFrame:CGRectMake(offset, self.bounds.origin.y, self.bounds.size.width - offset, self.bounds.size.height)];
    [_deleteLabel setFrame:CGRectMake(_deleteView.bounds.size.width/2 - labelWidth/2, _deleteView.bounds.size.height/2 - 10, labelWidth, 20)];
    
    if (locationFrame.x - _locationBounds.x + self.bounds.size.width < self.bounds.size.width/4) {
        [_delegate deleteTaskAtIndex:self.tag];
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setFrame:CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)];
    [_deleteView setFrame:CGRectMake(self.bounds.size.width, self.frame.origin.y, 0, self.bounds.size.height)];
}

-(void)dealloc {
    [_title release];
    [_detail release];
    [_descriptions release];
    [_deleteView release];
    [_deleteLabel release];
    [_flagView release];
    
    [super dealloc];
}

@end
