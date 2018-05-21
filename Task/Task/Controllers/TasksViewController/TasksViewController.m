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
#import "DeleteView.h"

#import "Task.h"

@interface TasksViewController () <AddTaskViewControllerDelegate, TaskViewDelegate>

@property (nonatomic, strong) NSMutableArray<Task *> *taskArray;
@property (nonatomic, strong) NSMutableArray<TaskView *> *taskViewArray;

@property (nonatomic, readonly, strong) UILabel *firstLabelForEmptyScreen;


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
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    _firstLabelForEmptyScreen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width,self.scrollView.bounds.size.height/2)];
    _firstLabelForEmptyScreen.numberOfLines = 5;
    _firstLabelForEmptyScreen.text = @"Add your first task, please ➕\n\nDouble tap to edit task ✏️\n\nLeft swipe to Delete task ❌";
    _firstLabelForEmptyScreen.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    _firstLabelForEmptyScreen.textAlignment = NSTextAlignmentCenter;
    
    [_scrollView addSubview:_firstLabelForEmptyScreen];
    
    [self.view addSubview:_scrollView];
}

- (void)addButttonTapped:(id)sender {
    AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] init];
    addTaskViewController.delegate = self;

    [self.navigationController pushViewController:addTaskViewController animated:true];

    [addTaskViewController release];
}

- (void)infoButttonTapped:(id)sender {
    InfoViewController *infoViewController = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:infoViewController animated:true];
    
    [infoViewController release];
}

-(void)reloadTasksFromRow:(NSInteger) row {
    CGFloat height = self.view.bounds.size.height/7;
    
    for (NSInteger i = row; i < _taskViewArray.count; i++) {
        [_taskViewArray[i] setFrame:CGRectMake(self.scrollView.bounds.origin.x, height * i, self.scrollView.bounds.size.width, height)];
        
        _taskArray[i].tag = i;
        _taskViewArray[i].tag = i;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height * _taskViewArray.count);
    }
    
    [self showFirstLabelForEmtyScreen];

}

// MARK: - AddTaskViewControllerDelegate protocol required methods

-(void)saveNewTask:(Task *)task {
    task.tag = _taskArray.count;
    [_taskArray addObject:task];
    
    CGFloat height = self.view.bounds.size.height/7;
    CGRect frame = CGRectMake(self.scrollView.bounds.origin.x, height * _taskViewArray.count, self.scrollView.bounds.size.width, height);
    
    TaskView *taskView = [[TaskView alloc] initWithFrame:frame];
    
  
    taskView.tag = _taskViewArray.count;
    [taskView updateViewWithTask:task];
    
    taskView.delegate = self;
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [taskView addGestureRecognizer:doubleTapGesture];
    [doubleTapGesture release];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [taskView addGestureRecognizer:panGesture];
    [panGesture release];
    
    [_taskViewArray addObject:taskView];
    
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height * _taskArray.count);
    [_scrollView addSubview:_taskViewArray.lastObject];
    
    [taskView release];
}

- (void) handlePan:(UIPanGestureRecognizer*)panGestore {
    
    if (panGestore.state == UIGestureRecognizerStateBegan ||
        panGestore.state == UIGestureRecognizerStateChanged ||
        panGestore.state == UIGestureRecognizerStateEnded) {

        [self.deleteView removeFromSuperview];
        self.deleteView = [[DeleteView redrawDeleteViewWithGestoreSuperView:panGestore] init];
        self.deleteView.tag = panGestore.view.tag;
        UITapGestureRecognizer *tapDeleteGestore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapDelete:)];
        
        [self.deleteView addGestureRecognizer:tapDeleteGestore];

        TaskView *taskView = [self.taskViewArray[panGestore.view.tag] retain];
        [taskView addSubview:self.deleteView];

        [self.deleteView release];
        [taskView release];

    }
}

- (void) handleTapDelete:(UITapGestureRecognizer*) tapDeleteGestore {
    
    [_taskArray removeObjectAtIndex:tapDeleteGestore.view.tag];
    [_taskViewArray[tapDeleteGestore.view.tag] removeFromSuperview];
    [_taskViewArray removeObjectAtIndex:tapDeleteGestore.view.tag];
    
    [self reloadTasksFromRow:tapDeleteGestore.view.tag];

}

-(void)updateTask:(Task *) task {
    [_taskViewArray[task.tag] updateViewWithTask:task];
}


// MARK: - AddTaskViewControllerDelegate protocol required methods

-(void)deleteTaskAtIndex:(NSInteger)index {
    [_taskArray removeObjectAtIndex:index];
    
    [_taskViewArray[index] removeFromSuperview];
    [_taskViewArray removeObjectAtIndex:index];
    
    [self reloadTasksFromRow:index];
}

- (void)editTaskAtIndex:(NSInteger)index {
    AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] init];
    addTaskViewController.delegate = self;
    addTaskViewController.task = _taskArray[index];
    
    [self.navigationController pushViewController:addTaskViewController animated:YES];
    [addTaskViewController release];
}

- (void)showFirstLabelForEmtyScreen {
    if (_taskViewArray.count != 0) {
        _firstLabelForEmptyScreen.hidden = YES;
    } else{
        _firstLabelForEmptyScreen.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showFirstLabelForEmtyScreen];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_taskArray release];
    [_taskViewArray release];
    [_scrollView release];

    [_firstLabelForEmptyScreen release];
    

    [super dealloc];
}

@end
