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
#import "Task.h"

@interface TasksViewController () <AddTaskViewControllerDelegate, TaskViewDelegate>

@property (nonatomic, strong) NSMutableArray<Task *> *taskArray;
@property (nonatomic, strong) NSMutableArray<TaskView *> *taskViewArray;

@end

@implementation TasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tasks";
    
    _taskArray = [[NSMutableArray alloc] init];
    _taskViewArray = [[NSMutableArray alloc] init];
    
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
    task.tag = _taskArray.count;
    [_taskArray addObject:task];
    
    CGFloat height = 130;
    CGRect frame = CGRectMake(self.scrollView.bounds.origin.x, height * _taskViewArray.count, self.scrollView.bounds.size.width, height);
    
    TaskView *taskView = [[TaskView alloc] initWithFrame:frame];
    
    [taskView addSubViews];
    taskView.tag = _taskViewArray.count;
    [taskView updateViewWithTask:task];
    
    taskView.delegate = self;
    
    [_taskViewArray addObject:taskView];
    
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height * _taskArray.count);
    [_scrollView addSubview:_taskViewArray.lastObject];
    
    [taskView release];
}

-(void)updateTask:(Task *) task {
    [_taskViewArray[task.tag] updateViewWithTask:task];
}

-(void)reloadTasksFromRow:(NSInteger) row {
    CGFloat height = 130;
    
    for (NSInteger i = row; i < _taskViewArray.count; i++) {
        [_taskViewArray[i] setFrame:CGRectMake(self.scrollView.bounds.origin.x, height * i, self.scrollView.bounds.size.width, height)];
        
        _taskArray[i].tag = i;
        _taskViewArray[i].tag = i;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height * _taskViewArray.count);
    }
}

-(void)taskViewDidRemoveFromSuperview: (TaskView*) taskView {
    [_taskArray removeObjectAtIndex:taskView.tag];
    [_taskViewArray removeObjectAtIndex:taskView.tag];
    
    [self reloadTasksFromRow:taskView.tag];
}

- (void)handleSwipe:(UISwipeGestureRecognizer*) gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    NSLog(@"Point x = %f, y =%f", point.x, point.y);
}

- (void)handleTap:(UITapGestureRecognizer*) tapGesture {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action" message:@"Choose action" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_taskArray removeObjectAtIndex:tapGesture.view.tag];
        [_taskViewArray[tapGesture.view.tag] removeFromSuperview];
        [_taskViewArray removeObjectAtIndex:tapGesture.view.tag];
        
        [self reloadTasksFromRow:tapGesture.view.tag];
        
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
    [_taskViewArray release];
    [_scrollView release];
    
    [super dealloc];
}

@end
