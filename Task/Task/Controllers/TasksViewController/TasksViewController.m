//
//  TasksViewController.m
//  Task
//
//  Created by Slava on 5/16/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "TasksViewController.h"
#import "AddTaskViewController.h"
#import "InfoViewController.h"

@interface TasksViewController () <AddTaskViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray<Task *> *tasksArray;

@end

@implementation TasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tasks";
    
    _tasksArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addButttonTapped:)];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Info" style:UIBarButtonItemStyleDone target:self action:@selector(infoButttonTapped:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    [rightButton release];
    [leftButton release];
}

- (void)addButttonTapped:(id)sender {
    AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] init];
    addTaskViewController.delegate = self;
    
    [self.navigationController pushViewController:addTaskViewController animated:true];
}

- (void)infoButttonTapped:(id)sender {
    InfoViewController *addTaskViewController = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:addTaskViewController animated:true];
}

// AddTaskViewControllerDelegate protocol required method
-(void)saveNewTask:(Task *)task {
    [_tasksArray addObject:task];
    
    for (Task *task in _tasksArray) {
        NSLog(@"Task title: %@", task.title);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_tasksArray release];
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
