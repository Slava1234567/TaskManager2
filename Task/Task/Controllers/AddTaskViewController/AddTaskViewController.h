//
//  AddTaskViewController.h
//  Task
//
//  Created by Slava on 5/16/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>

@required

-(void)saveNewTask: (Task*) task;

@end

@interface AddTaskViewController : UIViewController

@property (nonatomic, retain) UITextField *titleTextField;
@property (nonatomic, retain) UITextView *descriptionTextView;
@property (nonatomic, retain) UITextView *detailsTextView;

@property (nonatomic, assign) id<AddTaskViewControllerDelegate> delegate;

@end
