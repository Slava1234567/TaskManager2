//
//  TaskView.h
//  Task
//
//  Created by Slava on 5/17/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@interface TaskView : UIView

@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* descriptions;
@property (nonatomic, strong) UILabel* detail;
@property (nonatomic, strong) UIView* flagView;

- (void)addSubViews;
- (void)setValueInSubviewsTitle:(NSString*)title description:(NSString*)description detail:(NSString*)detail; //imageView:(UIImageView*)imageView;
-(void)updateViewWithTask:(Task*) task;

@end
