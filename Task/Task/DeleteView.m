//
//  DeleteView.m
//  Task
//
//  Created by Slava on 5/19/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "DeleteView.h"

@implementation DeleteView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _deleteLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _deleteLabel.backgroundColor = [UIColor redColor];
        _deleteLabel.textAlignment = 1;
        _deleteLabel.text = @"Delete";
        _deleteLabel.font = [UIFont fontWithName:@"Courier-Bold" size:22];
        _deleteLabel.layer.cornerRadius = 10;
        _deleteLabel.layer.masksToBounds = YES;
        _deleteLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _deleteLabel.layer.borderWidth = 1.5;
        
        [self addSubview:_deleteLabel];
    }
    return self;
}



+ (DeleteView*)redrawDeleteViewWithGestoreSuperView:(UIPanGestureRecognizer*)panGestore {
    
    DeleteView* deleteView = [[[DeleteView alloc] init] autorelease];

    
    CGFloat widht = 0;
    CGFloat positionX = CGRectGetMaxX(panGestore.view.bounds);
    
    CGRect frame = CGRectMake(positionX ,
                              CGRectGetMinY(panGestore.view.bounds),
                              widht, panGestore.view.bounds.size.height);

    CGPoint translation = CGPointMake(0, 0);
    
    switch (panGestore.state) {
        case UIGestureRecognizerStateBegan:
            translation = [panGestore translationInView:panGestore.view];
            deleteView.frame = frame;
            break;
        case UIGestureRecognizerStateChanged:
            if (([panGestore translationInView:panGestore.view]).x > translation.x) {
                CGFloat offSet = ([panGestore translationInView:panGestore.view]).x - translation.x;
                widht = offSet + widht;
                positionX = positionX - offSet;
                frame.size.width = widht;
                frame.origin.x = positionX;
                deleteView.frame = frame;
            }
            break;
        case UIGestureRecognizerStateEnded:
            widht = panGestore.view.bounds.size.width / 3;
            positionX = positionX - widht;
            frame.size.width = widht + 10;
            frame.origin.x = positionX;
            deleteView.frame = frame;
        default: break;
    }
    return  deleteView;
}

- (void)dealloc {
    [_deleteLabel release];
    [super dealloc];
}

@end
