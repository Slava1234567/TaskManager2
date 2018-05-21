//
//  AddTaskViewController.h
//  Task
//
//  Created by Алексей on 5/16/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@protocol AddTaskViewControllerDelegate <NSObject>

@required

-(void)saveNewTask: (Task*) task;
-(void)updateTask: (Task*) task;

@end

@interface AddTaskViewController : UIViewController

@property (nonatomic, strong) Task *task;
@property (nonatomic, weak) id<AddTaskViewControllerDelegate> delegate;

@end
