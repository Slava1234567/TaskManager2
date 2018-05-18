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
#import "TaskView.h"

@interface TasksViewController () <AddTaskViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray<Task *> *taskArray;

@end

@implementation TasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tasks";
    
    _taskArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addButttonTapped:)];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Info" style:UIBarButtonItemStyleDone target:self action:@selector(infoButttonTapped:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    [rightButton release];
    [leftButton release];
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:self.view.frame] autorelease];
    [self.view addSubview:self.scrollView];
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
    [_taskArray addObject:task];
    [self reloadAllTasks];
}

-(void)updateTask {
    [self reloadAllTasks];
}

-(void)reloadAllTasks {
    
    // Remove all subvies from scrollView
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Create and add all subviews
    [_taskArray enumerateObjectsUsingBlock:^(Task * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat height = 130;
        CGRect frame = CGRectMake(self.scrollView.bounds.origin.x, height * idx, self.scrollView.bounds.size.width, height);
        
        TaskView *taskView = [[TaskView alloc] initWithFrame:frame];
        [taskView addSubViews];
        taskView.tag = idx;
        
        [taskView updateViewWithTask:task];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [taskView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height * _taskArray.count);
        [_scrollView addSubview:taskView];
        
    }];
}

- (void)handleTap:(UITapGestureRecognizer*) tapGesture {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action" message:@"Choose action" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_taskArray removeObjectAtIndex:tapGesture.view.tag];
        [self reloadAllTasks];
        
    }];
    
    UIAlertAction *actionEdit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] init];
        addTaskViewController.delegate = self;
        addTaskViewController.task = _taskArray[tapGesture.view.tag];
        
        [self.navigationController pushViewController:addTaskViewController animated:true];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:actionDelete];
    [alertController addAction:actionEdit];
    [alertController addAction:actionCancel];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_taskArray release];
    [_scrollView release];
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
