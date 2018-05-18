//
//  AddTaskViewController.h
//  Task
//
//  Created by Slava on 5/16/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@protocol AddTaskViewControllerDelegate <NSObject>

@required

-(void)saveNewTask: (Task*) task;
-(void)updateTask;

@end

@interface AddTaskViewController : UIViewController

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView *descriptionTextView;
@property (nonatomic, strong) UITextView *detailsTextView;

@property (nonatomic, strong) Task *task;

@property (nonatomic, weak) id<AddTaskViewControllerDelegate> delegate;

@end
