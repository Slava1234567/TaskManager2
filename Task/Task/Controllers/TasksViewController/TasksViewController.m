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
@property (nonatomic, retain) NSMutableArray<TaskView *> *taskViewArray;
//@property (nonatomic, retain) TaskView *taskView;

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
    //[self createObjectTaskView];
    //[self.taskView setValueInSubviewsTitle:task.title description:task.descript detail:task.details];
    
    [_taskArray addObject:task];
    [self reloadAllTasks];
    //self.taskView.tag = self.taskArray.count;
    
    for (Task *task in _taskArray) {
        NSLog(@"Task title: %@, descr - %@", task.title, task.descript);
    }
}

-(void)reloadAllTasks {
    [_taskArray enumerateObjectsUsingBlock:^(Task * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat height = 200.0f;
        CGRect frame = CGRectMake(self.scrollView.bounds.origin.x, height * idx, self.scrollView.bounds.size.width, height);
        
        TaskView *taskView = [[TaskView alloc] initWithFrame:frame];
        [taskView addSubViews];
        [taskView updateViewWithTask:_taskArray[idx]];
        taskView.backgroundColor = UIColor.yellowColor;
        taskView.tag = idx;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [taskView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        [_scrollView addSubview:taskView];
        
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height * _taskArray.count);
        
    }];
}

-(void)updateTask {
    [self reloadAllTasks];
}

//- (void)createObjectTaskView {
//
//    CGFloat height = 200.0f;
//    CGRect frame = CGRectMake(self.scrollView.bounds.origin.x,
//                              height * self.tasksArray.count,
//                              self.scrollView.bounds.size.width,
//                              height);
//
//    self.taskView = [[[TaskView alloc] initWithFrame:frame]autorelease];
//    self.taskView.backgroundColor = [UIColor yellowColor];
//    [self.taskView addSubViews];
//
//    UITapGestureRecognizer *tapGestore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    [self.taskView addGestureRecognizer:tapGestore];
//
//    [tapGestore release];
//}

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
    
//    if (self.taskView) {
//        self.scrollView.contentSize
//        [self.scrollView addSubview:self.taskView];
//    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
