//
//  TaskView.h
//  Task
//
//  Created by Slava on 5/17/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskView : UIView

@property (nonatomic,retain) UILabel* title;
@property (nonatomic,retain) UILabel* descriptions;
@property (nonatomic,retain) UILabel* detail;
@property (nonatomic,retain) UIImageView* imageView;

- (void)addSubViews;
- (void)setValueInSubviewsTitle:(NSString*)title description:(NSString*)description detail:(NSString*)detail; //imageView:(UIImageView*)imageView;
-(void)updateViewWithTask:(Task*) task;

@end
