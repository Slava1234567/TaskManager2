//
//  TaskView.h
//  Task
//
//  Created by Slava on 5/17/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task, TaskView;

@protocol TaskViewDelegate <NSObject>

@required

-(void)editTaskAtIndex: (NSInteger) index;
-(void)deleteTaskAtIndex: (NSInteger) index;

@end

@interface TaskView : UIView

@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* descriptions;
@property (nonatomic, strong) UILabel* detail;
@property (nonatomic, strong) UIView* flagView;


@property (nonatomic, weak) id<TaskViewDelegate> delegate;

- (void)addSubViews;
- (void)updateViewWithTask:(Task*) task;


    


@end
